# Repository layout (umbrella vs apps)

This **EAC-Training-Bundle** repo is the **home for IP, curriculum, and go-to-market docs**, plus **application code via submodules** under [`packages/`](./STRUCTURE.md), and a **hub** ([`public/index.html`](./public/index.html)) served by [`scripts/dev-server.js`](./scripts/dev-server.js).

## Bundled submodules

| Path | Remote | Role |
|------|--------|------|
| [`packages/eac-crm`](./packages/eac-crm) | `https://github.com/branson124/EAC-CRM.git` | Pipeline CRM — static client tracker |
| [`packages/eac-command-center`](./packages/eac-command-center) | `https://github.com/branson124/eac-command-center.git` | AMI/FPL command center (single-page CDN React) |
| [`packages/manual-j-calculator`](./packages/manual-j-calculator) | `https://github.com/branson124/manual-j-calculator.git` | Manual J load calculator |
| [`packages/sales-rep-consultant-app`](./packages/sales-rep-consultant-app) | `https://github.com/branson124/sales-rep-consultant-app.git` | Sales rep tool + Express photo API |
| [`packages/home-efficiency-tool`](./packages/home-efficiency-tool) | `https://github.com/branson124/home-efficiency-tool.git` | Home efficiency UI + `hep-photo-server` API |

## Clone this repo

```bash
git clone --recursive https://github.com/branson124/EAC-Training-Bundle.git
# or, if already cloned without --recursive:
git submodule update --init --recursive
```

## Bump a submodule to latest

```bash
cd packages/eac-crm && git fetch origin && git checkout main && git pull
cd ../..
git add packages/eac-crm
git commit -m "Bump eac-crm submodule"
git push
```

Paths in [`docs/ASSET-INVENTORY.md`](./docs/ASSET-INVENTORY.md) may reference GitHub URLs; locally, code lives under `packages/<name>/`.

## Optional future repos

| Repo (example name) | Role |
|---------------------|------|
| `eac-website` or `energy-advocate-site` | Public marketing site |
| `eac-media` | PDFs, banners, large binaries (or store in `assets/` here + Git LFS) |

Record each in this file when created.
