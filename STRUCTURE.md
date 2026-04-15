# Monorepo layout (cohesive app structure)

This repository is the **umbrella**: strategy docs plus **pinned copies** of application code via **git submodules**, and a **hub** that exposes them on one origin for tabbed browsing.

```text
EAC-Training-Bundle/
├── README.md                 # Entry point + hub instructions
├── STRUCTURE.md              # This file
├── REPOS.md                  # Submodule & workflow notes
├── package.json              # Hub dev server (Express + proxy)
├── public/
│   └── index.html            # Tabbed shell (iframes → /apps/*)
├── .gitmodules               # Submodule registration
├── docs/                     # GTM + curriculum (no app runtime)
├── assets/                   # Optional: PDFs, website MD exports
├── packages/
│   ├── eac-crm/              # Submodule → EAC-CRM
│   ├── eac-command-center/   # Submodule → eac-command-center
│   ├── manual-j-calculator/  # Submodule → manual-j-calculator
│   ├── sales-rep-consultant-app/  # Submodule → sales-rep-consultant-app (+ Node server)
│   └── home-efficiency-tool/      # Submodule → home-efficiency-tool (+ hep-photo-server)
└── scripts/
    ├── dev-server.js         # Local hub: static apps + proxy to Node backends
    └── publish-to-github.sh  # Create remote repo + push (needs auth)
```

## Why submodules?

Each app stays its own repo (deploy Render/Cloudflare from that repo unchanged). This bundle **tracks specific commits** when you bump submodules—useful for “Training bundle v1.2 includes CRM at `abc123`.”

## Commands

```bash
# Clone this repo including submodules
git clone --recursive https://github.com/branson124/EAC-Training-Bundle.git

# Or after a shallow clone
git submodule update --init --recursive

# Run the tabbed hub (see README)
npm install && npm run install:apps && npm run dev

# Bump one submodule to latest main
cd packages/eac-crm && git fetch origin && git checkout main && git pull && cd ../..
git add packages/eac-crm && git commit -m "Bump eac-crm submodule"
```

## Future additions

| Path | Purpose |
|------|---------|
| `apps/training-portal/` | Static Phase B playbook site (optional new package or repo) |
| `packages/eac-website` | Submodule when public site has its own repo |
| `content/` | Symlink or copy of long-form MD/PDFs if you avoid LFS in `assets/` |
