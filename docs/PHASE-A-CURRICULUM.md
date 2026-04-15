# Phase A — Curriculum outline (talk tracks, objections, never-say)

Phase A is **IP and language**, not code. Align every lesson with **CRM fields** in the [EAC-CRM](https://github.com/branson124/EAC-CRM) app ([`index.html`](https://github.com/branson124/EAC-CRM/blob/main/index.html) / [`app.js`](https://github.com/branson124/EAC-CRM/blob/main/app.js)) so reps train on **one vocabulary**.

**Disclaimer (trainees and slides):** Training reflects **your organization’s sales process**. Official **EnergySaverNC / utility / income eligibility** rules change; verify against **current program documents** before promising outcomes.

---

## 1. Pipeline stages (map 1:1 to CRM `Pipeline Status`)

Teach reps what each stage **means** and what **must happen** before advancing.

| CRM value | Label (UI) | Teaching focus |
|-----------|--------------|------------------|
| `new` | New Lead | First capture: name, phone, address, **source**, rough need. Set **follow-up date**. |
| `called` | Called — No Answer | Cadence: how many attempts, when to leave SMS/voicemail, when to move to dropped. |
| `contacted` | Contacted — Interested | Confirm homeowner vs renter path; schedule or disqualify politely. |
| `intake_scheduled` | Intake Visit Scheduled | What to bring, what to verify on-site, align with **intake PDF**. |
| `intake_done` | Intake Visit Complete | Paperwork complete; what goes to office same day. |
| `app_submitted` | Application Submitted | Office/program confirmation; no “approved” language until official. |
| `awaiting_approval` | Awaiting ESNC Approval | Set expectations on timeline; no guarantees. |
| `assessor_scheduled` | Assessor Scheduled | Who attends; access to attic/panel. |
| `scope_review` | Scope Under Review | Explain scope vs change orders at high level. |
| `install_scheduled` | Install Scheduled | Date confirmation, prep list for homeowner. |
| `installed` | Install Complete | Close loop; referral ask if appropriate. |
| `not_eligible` | Not Eligible | Document **why** in notes (refer to official criteria). |
| `dropped` | Dropped | Lost to competitor, ghosted, or opted out—**notes** matter for coaching. |

**Exercise:** Given a scenario card, pick the **correct stage** and **one note line** to log.

---

## 2. CRM fields reps must understand (field-by-field)

| Field | Why it matters |
|-------|----------------|
| **Source** | Tied to marketing ROI and talk track (farmers market vs referral vs door knock). |
| **County** | Program and utility territory; wrong county = wrong process. |
| **Household size & income band** | Qualification framing; never diagnose eligibility—**screen and refer**. |
| **Owner / Renter** | Changes path; renter may need landlord engagement. |
| **Duke Customer?** | Utility-specific; if “No,” note **which utility** in **Notes** (CRM + talk track). |
| **Auto-Qualify Programs** | SNAP/EBT, Medicaid, SSI, etc.—language for **screening**, not for guaranteeing benefits. |
| **Home Needs** | HVAC, water heater, panel, insulation, roof/structural, high bill—sets technical and program narrative. |
| **Follow-Up Date** | Manager visibility; reduces dropped leads. |

---

## 3. Talk tracks (short scripts — expand from website MD)

Use your full **website page copy** export (e.g. `EAC_Website_Pages_Full_Content_SEO.md` on Desktop or copied under [`assets/`](../assets/)) for full paragraphs; below are **training stubs**.

### 3.1 Opening (event / door / referral)

- “We help homeowners understand **free and reduced-cost energy programs** you may already qualify for. No cost for the conversation—we’re here to see if it makes sense for **your** home.”
- Capture: name, best phone, address, **how they heard** (maps to **Source**).

### 3.2 Qualification (screen, don’t certify)

- “Eligibility depends on **household income**, **programs you’re in**, and sometimes **utility territory**. I’m going to ask a few questions so our team can **confirm** what applies—not a final yes/no from me on the spot.”
- Log **auto-qual** checkboxes as **signals**, not guarantees.

### 3.3 Utility / Duke vs non-Duke

- If not Duke: “Different utilities have different paths—we’ll note **who your electric provider is** and our team will use the **right** program steps.” (Put detail in **Notes**.)

### 3.4 Renter

- “Some paths need the **property owner** involved. We can still capture your info and explain what’s possible.” Set **Owner** = Renter; note landlord contact in **Notes** if known.

### 3.5 Next step

- Always end with a **follow-up date** or **scheduled intake** when possible; update **Pipeline Status** same day.

---

## 4. Objection handling (table for roleplay)

| Objection | Response direction |
|-----------|-------------------|
| “Is this a scam?” | Free assessment conversation; **no payment to us** for the first step; point to **official program** materials when available. |
| “I don’t want a credit check / sign today.” | No pressure; we document interest and **follow up**; stage = `contacted` or `new` with note. |
| “I was told I’m not eligible.” | “Rules change and depend on details—we’ll **verify** with current program criteria, not guess on the sidewalk.” |
| “I’m on Duke / not on Duke.” | Capture accurately; **Duke** field + **Notes** for other utility name. |
| “Only renters here.” | Explain renter/landlord path without promising; **Notes**. |

---

## 5. “Never say” list (compliance-minded)

Trainees must **not**:

1. **Guarantee** approval, rebate amount, or install date (“you’re in,” “you’ll get X dollars”).
2. **Present themselves as** a government agency or utility employee.
3. **Dismiss** safety or structural issues—note and escalate in **Notes**.
4. **Promise** a specific contractor outcome—your bundle is **process and education**, not a single vendor’s SLA.
5. **Skip** documentation of **source** and **follow-up date**—managers depend on CRM hygiene.

---

## 6. Alignment checklist (before Phase B build)

- [ ] Every **Pipeline Status** in CRM has a **one-paragraph** lesson in your facilitator guide.
- [ ] **Auto-qual** and **needs** labels in slides match CRM strings exactly.
- [ ] **Source** list in CRM matches how marketing reports channels (add “Other” handling in training).
- [ ] PDFs (intake, one-pager) use the **same terms** as CRM fields.

---

*This file lives in the **EAC-Training-Bundle** umbrella repo.*
