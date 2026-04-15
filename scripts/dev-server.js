/**
 * Serves the hub (public/) and static sub-apps under /apps/*.
 * Proxies Express-backed apps: sales-rep-consultant-app and home-efficiency-tool.
 */
const fs = require("fs");
const http = require("http");
const path = require("path");
const { spawn } = require("child_process");
const express = require("express");
const { createProxyMiddleware } = require("http-proxy-middleware");

const ROOT = path.join(__dirname, "..");
const PORT = Number(process.env.PORT || 3000);
const SALES_REP_PORT = Number(process.env.SALES_REP_PORT || 4001);
const HOME_EFF_PORT = Number(process.env.HOME_EFFICIENCY_PORT || 4002);

const SALES_CWD = path.join(ROOT, "packages", "sales-rep-consultant-app");
const HEP_CWD = path.join(ROOT, "packages", "home-efficiency-tool", "hep-photo-server");
const SALES_SERVER = path.join(SALES_CWD, "server.js");
const HEP_SERVER = path.join(HEP_CWD, "server.js");

const children = [];

function spawnServer(name, cwd, serverFile, port) {
  if (!fs.existsSync(serverFile)) {
    console.error(`[hub] Missing ${serverFile}`);
    console.error(
      "[hub] Clone submodules before deploy: git submodule update --init --recursive"
    );
    console.error(
      "[hub] On Render set env: GIT_SUBMODULE_STRATEGY=recursive and redeploy."
    );
    process.exit(1);
  }
  const child = spawn(process.execPath, [path.basename(serverFile)], {
    cwd,
    env: { ...process.env, PORT: String(port) },
    stdio: "inherit",
  });
  child.on("error", (err) => {
    console.error(`[hub] Failed to spawn ${name}:`, err.message);
  });
  child.on("exit", (code, signal) => {
    console.error(`[hub] ${name} exited (code=${code}, signal=${signal})`);
  });
  children.push(child);
}

function shutdown() {
  for (const c of children) {
    try {
      c.kill("SIGTERM");
    } catch (_) {}
  }
  process.exit(0);
}

process.on("SIGINT", shutdown);
process.on("SIGTERM", shutdown);

function waitForHttp(url, { timeoutMs = 90000, intervalMs = 500 } = {}) {
  const start = Date.now();
  return new Promise((resolve, reject) => {
    const tick = () => {
      const req = http.get(url, (res) => {
        res.resume();
        resolve();
      });
      req.on("error", () => {
        if (Date.now() - start > timeoutMs) {
          reject(new Error(`Timeout waiting for ${url}`));
        } else {
          setTimeout(tick, intervalMs);
        }
      });
      req.setTimeout(2000, () => {
        req.destroy();
      });
    };
    tick();
  });
}

function proxyOnError(label) {
  return (err, req, res) => {
    console.error(`[hub] Proxy error (${label}):`, err.message);
    if (res && !res.headersSent) {
      res.status(502).type("text/plain").send(
        `Backend unavailable (${label}). Check deploy logs and that GIT_SUBMODULE_STRATEGY=recursive is set on Render.`
      );
    }
  };
}

async function main() {
  spawnServer("sales-rep-consultant-app", SALES_CWD, SALES_SERVER, SALES_REP_PORT);
  spawnServer("home-efficiency (hep-photo-server)", HEP_CWD, HEP_SERVER, HOME_EFF_PORT);

  console.log("[hub] Waiting for backends to listen…");
  try {
    await waitForHttp(`http://127.0.0.1:${SALES_REP_PORT}/healthz`);
    await waitForHttp(`http://127.0.0.1:${HOME_EFF_PORT}/healthz`);
  } catch (e) {
    console.error("[hub] Backends did not become ready:", e.message);
    console.error(
      "[hub] Ensure `npm run install:apps` ran at build time and native deps built (hep-photo-server)."
    );
    process.exit(1);
  }

  const app = express();

  app.use(
    "/apps/sales-rep",
    createProxyMiddleware({
      target: `http://127.0.0.1:${SALES_REP_PORT}`,
      changeOrigin: true,
      on: {
        proxyReq: (proxyReq) => {
          proxyReq.setHeader("X-Forwarded-Prefix", "/apps/sales-rep");
        },
        error: proxyOnError("sales-rep"),
      },
    })
  );

  app.use(
    "/apps/home-efficiency",
    createProxyMiddleware({
      target: `http://127.0.0.1:${HOME_EFF_PORT}`,
      changeOrigin: true,
      on: {
        proxyReq: (proxyReq) => {
          proxyReq.setHeader("X-Forwarded-Prefix", "/apps/home-efficiency");
        },
        error: proxyOnError("home-efficiency"),
      },
    })
  );

  app.use(
    "/apps/eac-command-center",
    express.static(path.join(ROOT, "packages", "eac-command-center"))
  );
  app.use(
    "/apps/manual-j-calculator",
    express.static(path.join(ROOT, "packages", "manual-j-calculator"))
  );
  app.use("/apps/eac-crm", express.static(path.join(ROOT, "packages", "eac-crm")));

  app.use(express.static(path.join(ROOT, "public")));

  app.listen(PORT, "0.0.0.0", () => {
    console.log(`[hub] Listening on 0.0.0.0:${PORT}`);
    console.log(`[hub] Sales rep backend :${SALES_REP_PORT}  Home efficiency :${HOME_EFF_PORT}`);
  });
}

main().catch((err) => {
  console.error("[hub] Fatal:", err);
  process.exit(1);
});
