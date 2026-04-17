-- Private bucket for HE field photo/video uploads (future cutover from hep-photo-server disk).
-- Path convention: {org_id}/{lead_type}/{lead_id}/{system_id}/filename
-- Run after 0003.

insert into storage.buckets (id, name, public)
values ('hep-field-photos', 'hep-field-photos', false)
on conflict (id) do nothing;

drop policy if exists "hep_field_photos_select" on storage.objects;
create policy "hep_field_photos_select"
  on storage.objects
  for select
  to authenticated
  using (
    bucket_id = 'hep-field-photos'
    and split_part(name, '/', 1) = (select p.org_id::text from public.profiles p where p.user_id = auth.uid())
  );

drop policy if exists "hep_field_photos_insert" on storage.objects;
create policy "hep_field_photos_insert"
  on storage.objects
  for insert
  to authenticated
  with check (
    bucket_id = 'hep-field-photos'
    and split_part(name, '/', 1) = (select p.org_id::text from public.profiles p where p.user_id = auth.uid())
  );

drop policy if exists "hep_field_photos_update" on storage.objects;
create policy "hep_field_photos_update"
  on storage.objects
  for update
  to authenticated
  using (
    bucket_id = 'hep-field-photos'
    and split_part(name, '/', 1) = (select p.org_id::text from public.profiles p where p.user_id = auth.uid())
  )
  with check (
    bucket_id = 'hep-field-photos'
    and split_part(name, '/', 1) = (select p.org_id::text from public.profiles p where p.user_id = auth.uid())
  );

drop policy if exists "hep_field_photos_delete" on storage.objects;
create policy "hep_field_photos_delete"
  on storage.objects
  for delete
  to authenticated
  using (
    bucket_id = 'hep-field-photos'
    and split_part(name, '/', 1) = (select p.org_id::text from public.profiles p where p.user_id = auth.uid())
  );
