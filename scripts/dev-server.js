/**
 * Serves the hub (public/) and static sub-apps under /apps/*.
 * Proxies Express-backed apps: sales-rep-consultant-app and home-efficiency-tool.
 */
const path = require("path");
const { spawn } = require("child_process");
const express = require("express");
const { createProxyMiddleware } = require("http-proxy-middleware");

const ROOT = path.join(__dirname, "..");
const PORT = Number(process.env.PORT || 3000);
const SALES_REP_PORT = Number(process.env.SALES_REP_PORT || 4001);
const HOME_EFF_PORT = Number(process.env.HOME_EFFICIENCY_PORT || 4002);

const children = [];

function spawnServer(name, cwd, port) {
  const child = spawn(process.execPath, ["server.js"], {
    cwd,
    env: { ...process.env, PORT: String(port) },
    stdio: "inherit",
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

spawnServer("sales-rep-consultant-app", path.join(ROOT, "packages", "sales-rep-consultant-app"), SALES_REP_PORT);
spawnServer(
  "home-efficiency (hep-photo-server)",
  path.join(ROOT, "packages", "home-efficiency-tool", "hep-photo-server"),
  HOME_EFF_PORT
);

const app = express();

// Express strips the mount path before forwarding; targets see "/" for the tab root.
app.use(
  "/apps/sales-rep",
  createProxyMiddleware({
    target: `http://127.0.0.1:${SALES_REP_PORT}`,
    changeOrigin: true,
  })
);

app.use(
  "/apps/home-efficiency",
  createProxyMiddleware({
    target: `http://127.0.0.1:${HOME_EFF_PORT}`,
    changeOrigin: true,
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

app.listen(PORT, () => {
  console.log(`[hub] Open http://127.0.0.1:${PORT}/`);
  console.log(`[hub] Sales rep backend :${SALES_REP_PORT}  Home efficiency :${HOME_EFF_PORT}`);
});
