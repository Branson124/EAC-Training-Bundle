# Phase B — Training portal MVP (single URL)

Goal: **one place** a pilot contractor sends reps—**playbook + how to use the CRM + lightweight proof of learning**—without committing to full SaaS yet.

---

## Scope (in)

| Deliverable | Description | Suggested implementation |
|-------------|-------------|----------------------------|
| **Single “home” shell** | One landing page with clear navigation: Playbook, CRM, Resources, Quiz | Static site: new `portal.html` or sectioned `index` with anchor nav; or separate repo `eac-training-portal` that links to deployed CRM URL |
| **Playbook** | Phase A content surfaced as readable sections (stages, talk tracks, never-say) | Start as **Markdown rendered to HTML** or linked PDFs; minimum: one long `playbook.html` compiled from [`PHASE-A-CURRICULUM.md`](./PHASE-A-CURRICULUM.md) |
| **CRM usage story** | 5-minute “how to add a lead, set status, follow-up date, export backup” | Short embedded checklist + **link** to live **[EAC-CRM](https://github.com/branson124/EAC-CRM)** deploy (Render/custom domain) |
| **Quiz v0** | Proof reps read core compliance + stage definitions | **Google Form** or **Typeform** linked from portal (fastest); passing score tracked manually for pilot |
| **Resource links** | Eligibility one-pager, intake PDF | Host PDFs on secure storage (S3, Cloudflare R2, or website) with **signed URLs** or public marketing URLs |

---

## Scope (out) for Phase B

- No multi-tenant auth (unless you add **Cloudflare Access** or HTTP basic in front of static site for pilot privacy).
- No server-side CRM database (keep **IndexedDB** CRM; use **export/import** for office consolidation if needed).
- No custom video platform (use **Loom** / **YouTube unlisted** links if needed).

---

## Success criteria (60-day pilot)

| Metric | How to measure |
|--------|----------------|
| Reps can **add/edit** a lead with correct **stage** and **follow-up** | Spot-check 10 records / manager audit |
| **100%** of pilot reps complete **Quiz v0** | Form export |
| Manager reports **fewer** “what stage is this?” questions | Short weekly survey |

---

## Technical notes

- **One URL** can be achieved by: (1) subdirectory on same domain as CRM, (2) `portal.` subdomain, or (3) single-page app with iframes (avoid iframes if possible—use links).
- **SEO:** use `noindex` on trainee portal if content is **license-only** and not public marketing.

---

*This file lives in the **EAC-Training-Bundle** umbrella repo.*
