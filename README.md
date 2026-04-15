# EAC contractor training bundle (umbrella)

This repository holds **strategic product documentation** and, via **git submodule**, a pinned copy of the **EAC-CRM** app so contractors and your team have **one clone** that maps to one cohesive layout.

## What lives here

| Path | Contents |
|------|----------|
| [`docs/`](./docs/README.md) | Asset inventory, buyer model, Phase A–C planning |
| [`packages/eac-crm/`](./packages/eac-crm) | **Submodule** — [EAC-CRM](https://github.com/branson124/EAC-CRM) (pipeline CRM; deploy from that repo or this monorepo path) |
| [`STRUCTURE.md`](./STRUCTURE.md) | Monorepo layout, submodule commands |
| [`REPOS.md`](./REPOS.md) | How this repo relates to other GitHub repos |
| [`assets/`](./assets/README.md) | Placeholder for PDFs / website copy you choose to version here |
| [`scripts/publish-to-github.sh`](./scripts/publish-to-github.sh) | Create GitHub repo (needs `GITHUB_TOKEN`) and push |
| [`docs/GITHUB-SETUP.md`](./docs/GITHUB-SETUP.md) | **First-time publish** — create empty repo on GitHub, then `git push` |

## Related repositories

- **[EAC-CRM](https://github.com/branson124/EAC-CRM)** — source of `packages/eac-crm`; static client tracker, IndexedDB, import/export.

Add other application repos as **submodules** under `packages/` when they exist (see `REPOS.md`).

---

Energy Advocate Carolinas LLC
