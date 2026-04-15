# Repository layout (umbrella vs apps)

This **EAC-Training-Bundle** repo is the **home for IP, curriculum, and go-to-market docs**, plus **application code via submodules** under [`packages/`](./STRUCTURE.md).

## Bundled submodule (current)

| Path | Remote | Role |
|------|--------|------|
| [`packages/eac-crm`](./packages/eac-crm) | `https://github.com/branson124/EAC-CRM.git` | Pipeline CRM — deploy or develop from this path after `git submodule update --init` |

## Clone this repo

```bash
git clone --recursive https://github.com/branson124/EAC-Training-Bundle.git
# or, if already cloned without --recursive:
git submodule update --init --recursive
```

## Bump CRM to latest

```bash
cd packages/eac-crm && git fetch origin && git checkout main && git pull
cd ../..
git add packages/eac-crm
git commit -m "Bump eac-crm submodule"
git push
```

Paths in [`docs/ASSET-INVENTORY.md`](./docs/ASSET-INVENTORY.md) reference the **EAC-CRM** GitHub URLs; locally, code lives under `packages/eac-crm/`.

## Future repos to add

| Repo (example name) | Role |
|---------------------|------|
| `eac-website` or `energy-advocate-site` | Public marketing site |
| `eac-media` | PDFs, banners, large binaries (or store in `assets/` here + Git LFS) |

Record each in this file when created.
