# Repository layout (umbrella vs apps)

This **EAC-Training-Bundle** repo is the **home for IP, curriculum, and go-to-market docs**. Application code stays in **focused repos** so you can deploy and permission them independently.

## Recommended clone layout (local)

Put repos **side by side** on your machine (e.g. Desktop):

```text
Desktop/
  EAC-Training-Bundle/     ← this repo (docs + strategy)
  EAC-CRM/                 ← pipeline CRM (GitHub: branson124/EAC-CRM)
```

Paths in [`docs/ASSET-INVENTORY.md`](./docs/ASSET-INVENTORY.md) use **GitHub links** to EAC-CRM so nothing breaks if folders move.

## Optional: Git submodule (advanced)

If you want this repo to always point at a **specific commit** of the CRM:

```bash
cd EAC-Training-Bundle
git submodule add https://github.com/branson124/EAC-CRM.git packages/eac-crm
```

Then update docs to reference `packages/eac-crm/` instead of GitHub URLs. Submodules add workflow overhead—only use if you need version pinning.

## Future repos to add

| Repo (example name) | Role |
|---------------------|------|
| `eac-website` or `energy-advocate-site` | Public marketing site |
| `eac-media` | PDFs, banners, large binaries (or store in `assets/` here + Git LFS) |

Record each in this file when created.
