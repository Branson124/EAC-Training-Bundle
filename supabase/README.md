# Supabase (EAC Training Bundle)

Versioned SQL lives in [migrations](./migrations/). Apply **in numeric order** in the Supabase SQL Editor (or `supabase db push` if you use the CLI).

## Apply order

1. `0001_foundation_org_profiles.sql` — organizations, profiles, signup trigger  
2. `0002_domain_tables_and_org_scope.sql` — CRM, Door Setter, `home_docs_documents`, `hep_field_leads`  
3. `0003_storage_home_docs_media.sql` — Storage bucket `home-docs-media` + RLS  
4. `0004_storage_hep_field_photos.sql` — Storage bucket `hep-field-photos` + RLS (optional until HE uploads move off disk)  

If you already ran the older standalone files in submodules (`packages/eac-crm/supabase-schema.sql`, etc.), running `0001` then `0002` still works: `0002` uses `CREATE TABLE IF NOT EXISTS` and `ALTER TABLE ... ADD COLUMN IF NOT EXISTS` for upgrades.

## Command Center and Manual J (static apps)

With submodules checked out locally, search those packages for `localStorage`, `indexedDB`, `fetch`, and backend URLs. In this repo snapshot the `eac-command-center` and `manual-j-calculator` package folders may be **empty** (submodule not initialized); treat persistence as **unknown until cloned**. Add Supabase tables only if an app stores durable work data; ephemeral UI state does not need Postgres.

## Authentication redirect URLs

Add your real deploy host and local dev URLs under **Authentication → URL configuration** (Site URL + Redirect URLs). Include every path the apps use:

| App | Example paths |
|-----|----------------|
| Hub | `https://YOUR_HOST/` |
| EAC CRM | `https://YOUR_HOST/apps/eac-crm/`, `https://YOUR_HOST/apps/eac-crm/index.html` |
| Door Setter | `https://YOUR_HOST/apps/sales-rep/`, `https://YOUR_HOST/apps/sales-rep/app.html` |
| Client Home Docs | `https://YOUR_HOST/apps/sales-rep/client-home-docs.html` |
| Home Efficiency | `https://YOUR_HOST/apps/home-efficiency/`, `https://YOUR_HOST/apps/home-efficiency/index.html` (if used) |
| Local | `http://127.0.0.1:3000/...` with the same path patterns |

Magic links only redirect to URLs listed here.

## Storage

Bucket **`home-docs-media`** is private; uploads use paths `{org_id}/{client_id}/filename` so RLS can scope by org (first path segment).

Bucket **`hep-field-photos`** (migration `0004`) is for Home Efficiency field photos when you migrate off hep-photo-server disk; path prefix is the org UUID as text.

## Legacy submodule SQL

The files under `packages/eac-crm/supabase-schema.sql` and `packages/sales-rep-consultant-app/supabase-door-setter-schema.sql` are superseded by `migrations/0002` for new projects. Keep them as documentation or delete after migrating to this folder.
