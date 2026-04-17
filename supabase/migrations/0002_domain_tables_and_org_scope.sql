-- Domain tables (CRM, Door Setter, Home Docs, HE leads). Safe on fresh DB: creates IF NOT EXISTS.
-- Run after 0001_foundation_org_profiles.sql.

-- CRM workspace (per-user JSON list).
create table if not exists public.eac_crm_workspace (
  user_id uuid primary key references auth.users (id) on delete cascade,
  org_id uuid references public.organizations (id) default '00000000-0000-0000-0000-000000000001'::uuid,
  clients jsonb not null default '[]'::jsonb,
  updated_at timestamptz not null default now()
);

create index if not exists eac_crm_workspace_updated_at on public.eac_crm_workspace (updated_at desc);

alter table public.eac_crm_workspace enable row level security;

-- Door Setter workspace (per-user JSON state).
create table if not exists public.door_setter_workspace (
  user_id uuid primary key references auth.users (id) on delete cascade,
  org_id uuid references public.organizations (id) default '00000000-0000-0000-0000-000000000001'::uuid,
  state jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.door_setter_workspace enable row level security;

-- Upgrade path: tables created by older SQL without org_id.
alter table public.eac_crm_workspace
  add column if not exists org_id uuid references public.organizations (id) default '00000000-0000-0000-0000-000000000001'::uuid;
alter table public.door_setter_workspace
  add column if not exists org_id uuid references public.organizations (id) default '00000000-0000-0000-0000-000000000001'::uuid;

-- Backfill org_id for existing rows (no-op if already set).
update public.eac_crm_workspace
set org_id = coalesce(org_id, '00000000-0000-0000-0000-000000000001'::uuid);

update public.door_setter_workspace
set org_id = coalesce(org_id, '00000000-0000-0000-0000-000000000001'::uuid);

drop policy if exists "Users manage own CRM workspace" on public.eac_crm_workspace;
create policy "Users manage own CRM workspace"
  on public.eac_crm_workspace
  for all
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Users manage own door setter workspace" on public.door_setter_workspace;
create policy "Users manage own door setter workspace"
  on public.door_setter_workspace
  for all
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

comment on table public.eac_crm_workspace is 'EAC CRM: one row per user; clients JSON array.';
comment on table public.door_setter_workspace is 'Door Setter: one row per user; state JSON.';

-- Home Docs: one JSON document per client_id per org (shared within org).
create table if not exists public.home_docs_documents (
  id uuid primary key default gen_random_uuid(),
  org_id uuid not null references public.organizations (id) on delete cascade default '00000000-0000-0000-0000-000000000001'::uuid,
  client_id text not null,
  payload jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now(),
  updated_by uuid references auth.users (id) on delete set null,
  unique (org_id, client_id)
);

create index if not exists home_docs_org_client on public.home_docs_documents (org_id, client_id);

alter table public.home_docs_documents enable row level security;

drop policy if exists "Org members manage home docs" on public.home_docs_documents;
create policy "Org members manage home docs"
  on public.home_docs_documents
  for all
  to authenticated
  using (
    org_id = (select p.org_id from public.profiles p where p.user_id = auth.uid())
  )
  with check (
    org_id = (select p.org_id from public.profiles p where p.user_id = auth.uid())
  );

comment on table public.home_docs_documents is 'Client Home Docs JSON payload; one row per client_id per org.';

-- Home Efficiency–style leads (replaces SQLite when apps use Supabase).
create table if not exists public.hep_field_leads (
  id text primary key,
  org_id uuid not null references public.organizations (id) on delete cascade default '00000000-0000-0000-0000-000000000001'::uuid,
  lead_type text not null,
  payload_json jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  created_by uuid references auth.users (id) on delete set null
);

create index if not exists hep_field_leads_org on public.hep_field_leads (org_id);
create index if not exists hep_field_leads_created on public.hep_field_leads (created_at desc);

alter table public.hep_field_leads enable row level security;

drop policy if exists "Org members read hep leads" on public.hep_field_leads;
create policy "Org members read hep leads"
  on public.hep_field_leads
  for select
  to authenticated
  using (org_id = (select p.org_id from public.profiles p where p.user_id = auth.uid()));

drop policy if exists "Org members insert hep leads" on public.hep_field_leads;
create policy "Org members insert hep leads"
  on public.hep_field_leads
  for insert
  to authenticated
  with check (
    org_id = (select p.org_id from public.profiles p where p.user_id = auth.uid())
  );

drop policy if exists "Org members update hep leads" on public.hep_field_leads;
create policy "Org members update hep leads"
  on public.hep_field_leads
  for update
  to authenticated
  using (org_id = (select p.org_id from public.profiles p where p.user_id = auth.uid()))
  with check (org_id = (select p.org_id from public.profiles p where p.user_id = auth.uid()));

drop policy if exists "Org members delete hep leads" on public.hep_field_leads;
create policy "Org members delete hep leads"
  on public.hep_field_leads
  for delete
  to authenticated
  using (org_id = (select p.org_id from public.profiles p where p.user_id = auth.uid()));

comment on table public.hep_field_leads is 'HE field leads; migrate from SQLite hep-photo-server when ready.';
