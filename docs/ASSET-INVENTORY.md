# Asset inventory — Contractor training bundle

This document maps **repositories**, **application code**, and **companion assets** into **product modules** for the strategic bundle.

**CRM application repo:** [github.com/branson124/EAC-CRM](https://github.com/branson124/EAC-CRM)

**In this monorepo:** the CRM is also checked out at [`packages/eac-crm/`](../packages/eac-crm) (git submodule). Use GitHub URLs below for web links; use the local path for development inside the bundle.

---

## 1. Pipeline CRM (separate GitHub repository)

| Asset | Location | Module role |
|-------|----------|-------------|
| Static CRM (pipeline, filters, import/export) | [index.html](https://github.com/branson124/EAC-CRM/blob/main/index.html), [app.js](https://github.com/branson124/EAC-CRM/blob/main/app.js) | **Pipeline CRM** — lead stages, stats, client cards, IndexedDB persistence |
| Deploy config | [render.yaml](https://github.com/branson124/EAC-CRM/blob/main/render.yaml), [_redirects](https://github.com/branson124/EAC-CRM/blob/main/_redirects) | Hosting blueprint (Render / Cloudflare-style) |
| App documentation | [EAC-CRM README](https://github.com/branson124/EAC-CRM/blob/main/README.md) | Operator setup, not trainee-facing |

**CRM data model (implementation reference)**

- **Statuses** (pipeline): `new`, `called`, `contacted`, `intake_scheduled`, `intake_done`, `app_submitted`, `awaiting_approval`, `assessor_scheduled`, `scope_review`, `install_scheduled`, `installed`, `not_eligible`, `dropped` (see `STATUSES` in [app.js](https://github.com/branson124/EAC-CRM/blob/main/app.js)).
- **Fields captured**: name, phone, address, county, household size, income band, owner/renter, Duke customer, status, source, date added, notes, follow-up date, `auto_qual[]`, `needs[]`.

---

## 2. Companion assets (Desktop / [`assets/`](../assets/) in this repo)

These often start on the **Desktop** or in marketing folders; **copy into [`assets/`](../assets/README.md)** here when you want them versioned with the bundle.

| File | Type | Module role |
|------|------|-------------|
| `EAC_Website_Pages_Full_Content_SEO.md` | Markdown (long-form page copy) | **Program & eligibility literacy**, **talk tracks**, SEO-aligned homeowner messaging |
| `EAC_Eligibility_OnePager.pdf` | PDF | **Field one-pager** — quick qualification framing |
| `EAC_Homeowner_Intake_Form.pdf` | PDF | **Intake discipline** — what to collect before back-office |
| `EAC_BELMONT.pdf` | PDF | **Market/event-specific** collateral (Belmont) |
| `EAC_Retractable_Banner_Specs_For_Canva.md` | Markdown | **Event marketing** — booth / retractable banner specs |
| `EAC_QR_Code_Banner.png`, `EAC_QR_Code_Banner_DarkBlue.png` | PNG | **QR / event lead capture** creative |
| `Ecogreen-Door-Setter-Field-Guide.md` (if present) | Markdown | **Door / field process** (cross-check naming with CRM `source` and stages) |

---

## 3. Module mapping (bundle view)

| Product module | Primary sources |
|----------------|-----------------|
| **Pipeline CRM** | [EAC-CRM](https://github.com/branson124/EAC-CRM) (`app.js`, `index.html`) |
| **Program & eligibility literacy** | `EAC_Website_Pages_Full_Content_SEO.md`, `EAC_Eligibility_OnePager.pdf` |
| **Intake & documentation** | `EAC_Homeowner_Intake_Form.pdf`, CRM fields (`notes`, `followup_date`, `needs`) |
| **Talk tracks & objections** | Derived from website MD + CRM `source` / `status` vocabulary |
| **Marketing / events** | Banner specs MD, QR PNGs, Belmont PDF |
| **Roleplay / certification** | *Not built yet* — Phase B (see [PHASE-B-MVP.md](./PHASE-B-MVP.md)) |
| **Manager analytics** | *Not in static CRM* — Phase C (see [PHASE-C-B2B-ARCHITECTURE.md](./PHASE-C-B2B-ARCHITECTURE.md)) |

---

## 4. Gaps to close before a sold bundle

1. **Single vocabulary** — Align PDF field names and playbook headings with CRM labels (`Pipeline Status`, `Source`, `Auto-Qualify Programs`, `Home Needs`).
2. **Asset location** — Decide which PDFs ship inside the app (hosted URLs) vs. download-only.
3. **Legal** — Program disclaimers on all trainee-facing content (official rules trump training material).

---

*This file lives in the **EAC-Training-Bundle** umbrella repo, not inside EAC-CRM.*
