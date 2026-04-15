# Monorepo layout (cohesive app structure)

This repository is the **umbrella**: strategy docs plus **pinned copies** of application code via **git submodules**.

```text
EAC-Training-Bundle/
├── README.md                 # Entry point
├── STRUCTURE.md              # This file
├── REPOS.md                  # Submodule & workflow notes
├── .gitmodules               # Submodule registration
├── docs/                     # GTM + curriculum (no app runtime)
├── assets/                   # Optional: PDFs, website MD exports (see assets/README.md)
├── packages/
│   └── eac-crm/              # Submodule → github.com/branson124/EAC-CRM
└── scripts/
    └── publish-to-github.sh  # Create remote repo + push (needs auth)
```

## Why submodules?

- **EAC-CRM** stays its own repo (deploy Render/Cloudflare from that repo unchanged).
- This bundle **tracks a specific commit** of the CRM when you bump the submodule—useful for “Training bundle v1.2 includes CRM at commit `abc123`.”

## Commands

```bash
# Clone this repo including submodules
git clone --recursive https://github.com/branson124/EAC-Training-Bundle.git

# Or after a shallow clone
git submodule update --init --recursive

# Bump CRM to latest main inside the bundle
cd packages/eac-crm && git fetch origin && git checkout main && git pull && cd ../..
git add packages/eac-crm && git commit -m "Bump eac-crm submodule"
```

## Future additions

| Path | Purpose |
|------|---------|
| `apps/training-portal/` | Static Phase B playbook site (optional new package or repo) |
| `packages/eac-website` | Submodule when public site has its own repo |
| `content/` | Symlink or copy of long-form MD/PDFs if you avoid LFS in `assets/` |
