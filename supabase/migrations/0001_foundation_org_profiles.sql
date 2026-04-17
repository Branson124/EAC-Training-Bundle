-- EAC Training Bundle — foundation: single-org default + profiles + auth trigger.
-- Run via Supabase CLI or SQL Editor in order (0001, 0002, …).

-- Default organization (single-tenant; extend with more rows later for multi-org).
create table if not exists public.organizations (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  created_at timestamptz not null default now()
);

insert into public.organizations (id, name)
values ('00000000-0000-0000-0000-000000000001'::uuid, 'Energy Advocate Carolinas')
on conflict (id) do nothing;

alter table public.organizations enable row level security;

drop policy if exists "Organizations readable by authenticated" on public.organizations;
create policy "Organizations readable by authenticated"
  on public.organizations
  for select
  to authenticated
  using (true);

comment on table public.organizations is 'Company / tenant; default row is single-org EAC.';

-- Profile per auth user (role + org membership).
create table if not exists public.profiles (
  user_id uuid primary key references auth.users (id) on delete cascade,
  org_id uuid not null references public.organizations (id) on delete restrict default '00000000-0000-0000-0000-000000000001'::uuid,
  role text not null default 'member' check (role in ('member', 'admin')),
  display_name text,
  full_name text,
  updated_at timestamptz not null default now()
);

create index if not exists profiles_org_id on public.profiles (org_id);

alter table public.profiles enable row level security;

drop policy if exists "Profiles select own" on public.profiles;
create policy "Profiles select own"
  on public.profiles
  for select
  to authenticated
  using (auth.uid() = user_id);

drop policy if exists "Profiles update own" on public.profiles;
create policy "Profiles update own"
  on public.profiles
  for update
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

comment on table public.profiles is 'One row per employee; org_id scopes company data.';

-- Auto-create profile when a user signs up.
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (user_id, org_id, role)
  values (new.id, '00000000-0000-0000-0000-000000000001'::uuid, 'member')
  on conflict (user_id) do nothing;
  return new;
end;
$$;

drop trigger if exists eac_handle_new_user_trigger on auth.users;
create trigger eac_handle_new_user_trigger
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- Backfill profiles for existing Auth users (safe to re-run).
insert into public.profiles (user_id, org_id, role)
select u.id, '00000000-0000-0000-0000-000000000001'::uuid, 'member'
from auth.users u
where not exists (select 1 from public.profiles p where p.user_id = u.id)
on conflict (user_id) do nothing;
