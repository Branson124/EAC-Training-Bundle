# EAC contractor training bundle (umbrella)

This repository holds **strategic product documentation** and, via **git submodules**, pinned copies of **EAC apps** behind a single **tabbed hub** for local use.

## App hub (bundled UI)

From the repo root:

```bash
git submodule update --init --recursive
npm install
npm run install:apps
npm run dev
```

Open **http://127.0.0.1:3000/** (override with `PORT=`). The hub loads each tool in its own tab:

| Tab | Served from | Notes |
|-----|-------------|--------|
| Door Setter | `/apps/sales-rep/` | Door setter workflow only (`app.html`). Optional **cross-device sync**: set the same secret phrase on each device to load/save state via `GET/PUT /api/sync/door-setter/:syncId/state` (requires HTTPS for `crypto.subtle`). Same Node server as Client Home Docs. Hub spawns it on `SALES_REP_PORT` (default `4001`). |
| Client Home Docs | `/apps/sales-rep/client-home-docs.html` | Client attic / systems form, photos & videos per **Client ID**; data under `storage/homeDocs/` on the server. Use the **same Client ID** on phone and desktop to see the same job (no passphrase — type or paste the ID). |
| Command Center | `/apps/eac-command-center/` | Static `index.html` (CDN React). |
| Home Efficiency | `/apps/home-efficiency/` | [AMI-calculator](https://github.com/Branson124/AMI-calculator) — NC AMI tier check & intake; hub spawns on `HOME_EFFICIENCY_PORT` (default `4002`). |
| EAC CRM | `/apps/eac-crm/` | Static `index.html` + `app.js`. |
| Manual J | `/apps/manual-j-calculator/` | Static `index.html` (CDN React). |

Environment variables: `PORT`, `SALES_REP_PORT`, `HOME_EFFICIENCY_PORT`.

**Supabase (company database):** SQL migrations and redirect-URL checklist live in [`supabase/README.md`](./supabase/README.md). Apply migrations in order after creating your Supabase project.

### Render (Web Service)

Use a **Node Web Service** (not a Static Site). Set:

| Variable | Value |
|----------|--------|
| **`GIT_SUBMODULE_STRATEGY`** | **`recursive`** (required — otherwise `packages/` submodules are empty and the Sales Rep / Home Efficiency servers never start) |
| **`NODE_ENV`** | `production` (recommended for session cookies on Sales Rep / Client Home Docs) |

**Build command:** `npm install && npm run build` (runs `install:apps` so Sales Rep and AMI-calculator get `node_modules`).

**Start command:** `npm start`

See [`render.yaml`](./render.yaml) for a Blueprint you can paste or sync. After changing env vars, **clear build cache & redeploy** once so the clone includes submodules.

**Persistent storage:** Uploads and `home-data.json` live on disk under `packages/sales-rep-consultant-app/storage/`. On Render, attach a **persistent disk** to the web service and mount it where that path lives (or set a single working directory that survives deploys), or files will be lost when the instance restarts without a disk.

**Submodule note:** `packages/sales-rep-consultant-app/server.js` includes a small path fix so `app.html` resolves when `server.js` lives in the repo root (same layout as on GitHub). Commit that change inside the submodule and push to [sales-rep-consultant-app](https://github.com/branson124/sales-rep-consultant-app) when you are ready so the fix is upstream.

## What lives here

| Path | Contents |
|------|----------|
| [`docs/`](./docs/README.md) | Asset inventory, buyer model, Phase A–C planning |
| [`public/index.html`](./public/index.html) | Hub shell (tabs + iframes) |
| [`scripts/dev-server.js`](./scripts/dev-server.js) | Express: static `/apps/*` + proxy to the two Node backends |
| [`packages/*`](./STRUCTURE.md) | **Submodules** — CRM, Command Center, Manual J, Sales Rep, AMI calculator, optional legacy `home-efficiency-tool` |
| [`STRUCTURE.md`](./STRUCTURE.md) | Monorepo layout, submodule commands |
| [`REPOS.md`](./REPOS.md) | Submodule URLs and bump workflow |
| [`assets/`](./assets/README.md) | Placeholder for PDFs / website copy you version here |
| [`scripts/publish-to-github.sh`](./scripts/publish-to-github.sh) | Create GitHub repo (`GITHUB_TOKEN`) and push |
| [`docs/GITHUB-SETUP.md`](./docs/GITHUB-SETUP.md) | First-time publish — empty repo on GitHub, then `git push` |

## Related repositories

- [EAC-CRM](https://github.com/branson124/EAC-CRM), [eac-command-center](https://github.com/branson124/eac-command-center), [manual-j-calculator](https://github.com/branson124/manual-j-calculator), [sales-rep-consultant-app](https://github.com/branson124/sales-rep-consultant-app), [AMI-calculator](https://github.com/Branson124/AMI-calculator), [home-efficiency-tool](https://github.com/branson124/home-efficiency-tool) (legacy; not used by the hub tab)

---

Energy Advocate Carolinas LLC
