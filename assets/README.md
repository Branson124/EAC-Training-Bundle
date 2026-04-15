# Bundle assets (optional)

Copy **versioned** collateral here when you want it **in Git** with the training docs:

- `EAC_Website_Pages_Full_Content_SEO.md` (or a trimmed export)
- PDFs: eligibility one-pager, intake form, market one-pagers
- Banner specs, QR artwork

Large binaries: consider **Git LFS** or a separate `eac-media` repo; keep this folder for **text** and **small** images unless you enable LFS.

Do **not** commit live CRM exports with homeowner PII (`eac-migration-import.json`–style files).
