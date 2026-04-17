-- Private bucket for Client Home Docs uploads (photos/videos). Path: {org_id}/{client_id}/filename
-- Run after 0002. Adjust policies if you use a different path layout.

insert into storage.buckets (id, name, public)
values ('home-docs-media', 'home-docs-media', false)
on conflict (id) do nothing;

-- Authenticated users: read/write only under their org folder (first path segment = org UUID as text).
drop policy if exists "home_docs_media_select" on storage.objects;
create policy "home_docs_media_select"
  on storage.objects
  for select
  to authenticated
  using (
    bucket_id = 'home-docs-media'
    and split_part(name, '/', 1) = (select p.org_id::text from public.profiles p where p.user_id = auth.uid())
  );

drop policy if exists "home_docs_media_insert" on storage.objects;
create policy "home_docs_media_insert"
  on storage.objects
  for insert
  to authenticated
  with check (
    bucket_id = 'home-docs-media'
    and split_part(name, '/', 1) = (select p.org_id::text from public.profiles p where p.user_id = auth.uid())
  );

drop policy if exists "home_docs_media_update" on storage.objects;
create policy "home_docs_media_update"
  on storage.objects
  for update
  to authenticated
  using (
    bucket_id = 'home-docs-media'
    and split_part(name, '/', 1) = (select p.org_id::text from public.profiles p where p.user_id = auth.uid())
  )
  with check (
    bucket_id = 'home-docs-media'
    and split_part(name, '/', 1) = (select p.org_id::text from public.profiles p where p.user_id = auth.uid())
  );

drop policy if exists "home_docs_media_delete" on storage.objects;
create policy "home_docs_media_delete"
  on storage.objects
  for delete
  to authenticated
  using (
    bucket_id = 'home-docs-media'
    and split_part(name, '/', 1) = (select p.org_id::text from public.profiles p where p.user_id = auth.uid())
  );
