-- Staff claim rules. Additive only: no table drops, no row deletes, no directory rewrite.
-- One listed company keeps a single claimed_by_user_id. A dispute is a pending
-- application and does not write a second claimant.
-- Evidence files live in the private claim-evidence bucket. installer_directory
-- is unchanged, so the public directory does not gain email, street, or files.
-- This migration does not set projects.is_pro_unlocked and does not add a payment.

alter table public.integrator_applications
  add column if not exists company_email text,
  add column if not exists card_photo_path text,
  add column if not exists office_photo_path text,
  add column if not exists extra_evidence_path text;

comment on column public.integrator_applications.company_email is
  'Personal company email for a claim or dispute. Staff can read it. The public directory does not select it.';

comment on column public.integrator_applications.card_photo_path is
  'Object path in the private claim-evidence bucket for a business-card photo.';

comment on column public.integrator_applications.office_photo_path is
  'Object path in the private claim-evidence bucket for an office photo that shows the company logo.';

comment on column public.integrator_applications.extra_evidence_path is
  'Optional extra evidence path in the private claim-evidence bucket.';

comment on column public.installers.claimed_by_user_id is
  'The single claimant for this company. Dispute approval must not add another claimant.';

do $$
declare
  constraint_name text;
begin
  for constraint_name in
    select con.conname
    from pg_constraint con
    join pg_class rel on rel.oid = con.conrelid
    join pg_namespace nsp on nsp.oid = rel.relnamespace
    where nsp.nspname = 'public'
      and rel.relname = 'integrator_applications'
      and con.contype = 'c'
      and (
        con.conname in ('integrator_applications_kind_check', 'integrator_applications_target_chk')
        or pg_get_constraintdef(con.oid) ~* 'kind'
      )
  loop
    execute format('alter table public.integrator_applications drop constraint %I', constraint_name);
  end loop;
end $$;

alter table public.integrator_applications
  drop constraint if exists integrator_applications_evidence_len_chk;

alter table public.integrator_applications
  add constraint integrator_applications_kind_check
  check (kind in ('claim', 'new_company', 'dispute'));

alter table public.integrator_applications
  add constraint integrator_applications_target_chk
  check (
    (kind = 'new_company' and target_installer_id is null)
    or (kind in ('claim', 'dispute') and target_installer_id is not null)
  );

alter table public.integrator_applications
  add constraint integrator_applications_evidence_len_chk
  check (
    (company_email is null or char_length(company_email) <= 200)
    and (card_photo_path is null or char_length(card_photo_path) <= 400)
    and (office_photo_path is null or char_length(office_photo_path) <= 400)
    and (extra_evidence_path is null or char_length(extra_evidence_path) <= 400)
  );

create unique index if not exists integrator_applications_one_pending_dispute
  on public.integrator_applications (applicant_user_id, target_installer_id)
  where status = 'pending' and kind = 'dispute';

create unique index if not exists integrator_applications_one_approved_claim
  on public.integrator_applications (target_installer_id)
  where status = 'approved' and kind = 'claim';

create table if not exists public.integrator_communications (
  id uuid primary key default gen_random_uuid(),
  homeowner_user_id uuid references public.profiles (id) on delete set null,
  installer_user_id uuid references public.profiles (id) on delete set null,
  installer_id uuid references public.installers (id) on delete set null,
  summary text not null,
  created_at timestamptz not null default now(),
  constraint integrator_communications_summary_chk check (char_length(btrim(summary)) between 1 and 2000)
);

comment on table public.integrator_communications is
  'Key notes between a homeowner and an integrator. Not a payment and not a house number. Empty until a real note is stored.';

create index if not exists integrator_communications_created_at_idx
  on public.integrator_communications (created_at desc);

create index if not exists integrator_communications_homeowner_idx
  on public.integrator_communications (homeowner_user_id);

create index if not exists integrator_communications_installer_user_idx
  on public.integrator_communications (installer_user_id);

alter table public.integrator_communications enable row level security;

revoke all on table public.integrator_communications from public, anon, authenticated;
grant select on table public.integrator_communications to authenticated;
grant all on table public.integrator_communications to service_role;

drop policy if exists integrator_communications_select_parties on public.integrator_communications;
create policy integrator_communications_select_parties
  on public.integrator_communications
  for select
  to authenticated
  using (
    (select private.is_admin())
    or homeowner_user_id = (select auth.uid())
    or installer_user_id = (select auth.uid())
  );

-- Clients cannot change who claimed a row. The service role still can, and
-- dispute approval in the app must not call that write for a second person.
create or replace function private.guard_installer_row()
returns trigger
language plpgsql
security invoker
set search_path = ''
as $$
begin
  if current_user in ('postgres', 'supabase_admin', 'service_role')
     or coalesce(auth.role(), '') = 'service_role' then
    return new;
  end if;
  if tg_op = 'INSERT' then
    raise exception 'installer records are created by the server' using errcode = '42501';
  end if;
  new.id := old.id;
  new.created_at := old.created_at;
  new.subscription_tier := old.subscription_tier;
  new.knx_official_rank := old.knx_official_rank;
  new.is_founding_partner := old.is_founding_partner;
  new.verified_projects_count := old.verified_projects_count;
  new.claimed_by_user_id := old.claimed_by_user_id;
  return new;
end;
$$;

revoke all on function private.guard_installer_row() from public, anon;
grant execute on function private.guard_installer_row() to authenticated, service_role;

create or replace function private.guard_integrator_application()
returns trigger
language plpgsql
security invoker
set search_path = ''
as $$
declare
  claimant uuid;
begin
  if current_user in ('postgres', 'supabase_admin', 'service_role')
     or coalesce(auth.role(), '') = 'service_role' then
    if tg_op = 'UPDATE' then
      new.updated_at := now();
    end if;
    return new;
  end if;

  if tg_op = 'INSERT' then
    if not exists (
      select 1 from public.profiles
      where id = (select auth.uid()) and role = 'installer'
    ) then
      raise exception 'installer role required' using errcode = '42501';
    end if;
    new.applicant_user_id := (select auth.uid());
    new.status := 'pending';
    new.staff_note := null;
    new.reviewed_at := null;
    new.reviewed_by := null;
    new.result_installer_id := null;
    new.created_at := now();
    new.updated_at := now();
    if new.kind = 'new_company' then
      new.target_installer_id := null;
      new.company_email := null;
      new.card_photo_path := null;
      new.office_photo_path := null;
      new.extra_evidence_path := null;
    end if;
    if new.kind in ('claim', 'dispute') and new.target_installer_id is null then
      raise exception 'claim requires a listed company' using errcode = '23514';
    end if;
    if new.kind in ('claim', 'dispute') then
      new.company_email := nullif(btrim(new.company_email), '');
      if new.company_email is null
         or position('@' in new.company_email) < 2
         or new.card_photo_path is null
         or btrim(new.card_photo_path) = ''
         or new.office_photo_path is null
         or btrim(new.office_photo_path) = ''
      then
        raise exception 'claim evidence required' using errcode = '23514';
      end if;
      if new.card_photo_path like '%..%'
         or new.office_photo_path like '%..%'
         or coalesce(new.extra_evidence_path, '') like '%..%'
         or new.card_photo_path not like (select auth.uid())::text || '/%'
         or new.office_photo_path not like (select auth.uid())::text || '/%'
         or (
           new.extra_evidence_path is not null
           and new.extra_evidence_path not like (select auth.uid())::text || '/%'
         )
      then
        raise exception 'evidence path rejected' using errcode = '42501';
      end if;
      select claimed_by_user_id into claimant
      from public.installers
      where id = new.target_installer_id;
      if new.kind = 'claim' and claimant is not null and claimant is distinct from (select auth.uid()) then
        raise exception 'company already has a claimant' using errcode = '23505';
      end if;
      if new.kind = 'dispute' and (claimant is null or claimant is not distinct from (select auth.uid())) then
        raise exception 'dispute requires an existing claimant' using errcode = '23514';
      end if;
    end if;
    return new;
  end if;

  new.id := old.id;
  new.applicant_user_id := old.applicant_user_id;
  new.kind := old.kind;
  new.target_installer_id := old.target_installer_id;
  new.result_installer_id := old.result_installer_id;
  new.company_email := old.company_email;
  new.card_photo_path := old.card_photo_path;
  new.office_photo_path := old.office_photo_path;
  new.extra_evidence_path := old.extra_evidence_path;
  new.status := old.status;
  new.staff_note := old.staff_note;
  new.reviewed_at := old.reviewed_at;
  new.reviewed_by := old.reviewed_by;
  new.created_at := old.created_at;
  new.updated_at := old.updated_at;
  raise exception 'applicants cannot review applications' using errcode = '42501';
end;
$$;

revoke all on function private.guard_integrator_application() from public, anon;
grant execute on function private.guard_integrator_application() to authenticated, service_role;

drop policy if exists integrator_applications_select_own on public.integrator_applications;
create policy integrator_applications_select_own
  on public.integrator_applications
  for select
  to authenticated
  using (
    applicant_user_id = (select auth.uid())
    or (
      kind in ('claim', 'dispute')
      and target_installer_id is not null
      and (select private.claims_installer(target_installer_id))
    )
    or (select private.is_admin())
  );

do $$
begin
  if to_regclass('public.projects_rfq') is not null then
    execute 'drop policy if exists projects_rfq_staff_select on public.projects_rfq';
    execute 'create policy projects_rfq_staff_select on public.projects_rfq for select to authenticated using ((select private.is_admin()))';
  end if;
  if to_regclass('public.dealer_quotes') is not null then
    execute 'drop policy if exists dealer_quotes_staff_select on public.dealer_quotes';
    execute 'create policy dealer_quotes_staff_select on public.dealer_quotes for select to authenticated using ((select private.is_admin()))';
  end if;
end $$;

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values (
  'claim-evidence',
  'claim-evidence',
  false,
  5242880,
  array['image/jpeg', 'image/png', 'image/webp', 'application/pdf']::text[]
)
on conflict (id) do update
set
  public = false,
  file_size_limit = excluded.file_size_limit,
  allowed_mime_types = excluded.allowed_mime_types;

drop policy if exists claim_evidence_select_owner_or_staff on storage.objects;
create policy claim_evidence_select_owner_or_staff
  on storage.objects
  for select
  to authenticated
  using (
    bucket_id = 'claim-evidence'
    and (
      (storage.foldername(name))[1] = (select auth.uid())::text
      or (select private.is_admin())
    )
  );

drop policy if exists claim_evidence_insert_owner on storage.objects;
create policy claim_evidence_insert_owner
  on storage.objects
  for insert
  to authenticated
  with check (
    bucket_id = 'claim-evidence'
    and (storage.foldername(name))[1] = (select auth.uid())::text
  );

drop policy if exists claim_evidence_update_owner on storage.objects;
create policy claim_evidence_update_owner
  on storage.objects
  for update
  to authenticated
  using (
    bucket_id = 'claim-evidence'
    and (storage.foldername(name))[1] = (select auth.uid())::text
  )
  with check (
    bucket_id = 'claim-evidence'
    and (storage.foldername(name))[1] = (select auth.uid())::text
  );

-- Promote the staff mailbox if it already exists. No password is stored here.
insert into public.profiles (id, role, locale, country_code)
select id, 'admin', 'en-US', 'US'
from auth.users
where lower(email) = 'admin@staff.xhomeeasy.example'
on conflict (id) do update set role = 'admin';
