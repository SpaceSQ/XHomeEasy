-- Integrator claims and RFQ leads. Pending applications are not directory rows.
-- Approval is performed with the service role. A signed-in user cannot set status to approved.
-- House number is not a column on these tables and is removed from the public street line.

create table public.integrator_applications (
  id uuid primary key default gen_random_uuid(),
  applicant_user_id uuid not null references public.profiles (id) on delete cascade,
  kind text not null check (kind in ('claim', 'new_company')),
  target_installer_id uuid references public.installers (id),
  result_installer_id uuid references public.installers (id) on delete set null,
  company_name text not null,
  city text not null,
  state text not null,
  postal_code text not null,
  country_code text not null check (country_code in ('US', 'CA')),
  street_address text,
  public_website text,
  status text not null default 'pending' check (status in ('pending', 'approved', 'rejected')),
  staff_note text,
  reviewed_at timestamptz,
  reviewed_by uuid references public.profiles (id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint integrator_applications_target_chk check (
    (kind = 'new_company' and target_installer_id is null)
    or (kind = 'claim' and target_installer_id is not null)
  ),
  constraint integrator_applications_text_chk check (
    char_length(btrim(company_name)) between 1 and 160
    and char_length(btrim(city)) between 1 and 120
    and char_length(btrim(state)) between 1 and 80
    and char_length(btrim(postal_code)) between 1 and 20
    and (street_address is null or char_length(street_address) <= 200)
    and (public_website is null or char_length(public_website) <= 300)
    and (staff_note is null or char_length(staff_note) <= 2000)
  )
);

comment on table public.integrator_applications is
  'Claim or new-company request. Pending rows are not part of installer_directory. Status approved is written only by the service role.';

comment on column public.integrator_applications.street_address is
  'Optional street for staff review. House number is not collected and is not published.';

comment on column public.integrator_applications.staff_note is
  'Written by staff during review. Applicants cannot set it.';

create index integrator_applications_applicant_idx
  on public.integrator_applications (applicant_user_id);

create index integrator_applications_target_idx
  on public.integrator_applications (target_installer_id);

create unique index integrator_applications_one_pending_claim
  on public.integrator_applications (applicant_user_id, target_installer_id)
  where status = 'pending' and kind = 'claim';

create unique index integrator_applications_one_pending_company
  on public.integrator_applications (applicant_user_id)
  where status = 'pending' and kind = 'new_company';

create table public.integrator_leads (
  id uuid primary key default gen_random_uuid(),
  installer_id uuid not null references public.installers (id) on delete cascade,
  project_id uuid references public.projects (id) on delete set null,
  rfq_id uuid references public.projects_rfq (id) on delete set null,
  title text not null,
  city text,
  state text,
  postal_code text,
  country_code text check (country_code is null or country_code in ('US', 'CA')),
  status text not null default 'open' check (status in ('open', 'quoting', 'closed')),
  summary text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint integrator_leads_text_chk check (
    char_length(btrim(title)) between 1 and 160
    and (city is null or char_length(city) <= 120)
    and (state is null or char_length(state) <= 80)
    and (postal_code is null or char_length(postal_code) <= 20)
    and (summary is null or char_length(summary) <= 2000)
  )
);

comment on table public.integrator_leads is
  'RFQ or quote request addressed to an integrator. Not a payment. Inserted by the service role only. This build does not open homeowner delivery, and projects stay locked.';

comment on column public.integrator_leads.summary is
  'Request summary. Do not store a house number here.';

create index integrator_leads_installer_idx
  on public.integrator_leads (installer_id);

create index if not exists installers_claimed_by_user_id_idx
  on public.installers (claimed_by_user_id);

create or replace function private.guard_integrator_application()
returns trigger
language plpgsql
security invoker
set search_path = ''
as $$
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
    end if;
    if new.kind = 'claim' and new.target_installer_id is null then
      raise exception 'claim requires a listed company' using errcode = '23514';
    end if;
    return new;
  end if;

  new.id := old.id;
  new.applicant_user_id := old.applicant_user_id;
  new.kind := old.kind;
  new.target_installer_id := old.target_installer_id;
  new.result_installer_id := old.result_installer_id;
  new.status := old.status;
  new.staff_note := old.staff_note;
  new.reviewed_at := old.reviewed_at;
  new.reviewed_by := old.reviewed_by;
  new.created_at := old.created_at;
  new.updated_at := old.updated_at;
  raise exception 'applicants cannot review applications' using errcode = '42501';
end;
$$;

create or replace function private.guard_integrator_lead()
returns trigger
language plpgsql
security invoker
set search_path = ''
as $$
begin
  if current_user in ('postgres', 'supabase_admin', 'service_role')
     or coalesce(auth.role(), '') = 'service_role' then
    if tg_op = 'UPDATE' then
      new.updated_at := now();
    end if;
    return new;
  end if;
  raise exception 'integrator leads are created by the server' using errcode = '42501';
end;
$$;

revoke all on function private.guard_integrator_application() from public, anon;
revoke all on function private.guard_integrator_lead() from public, anon;
grant execute on function private.guard_integrator_application() to authenticated, service_role;
grant execute on function private.guard_integrator_lead() to authenticated, service_role;

drop trigger if exists integrator_applications_guard on public.integrator_applications;
create trigger integrator_applications_guard
  before insert or update on public.integrator_applications
  for each row execute function private.guard_integrator_application();

drop trigger if exists integrator_leads_guard on public.integrator_leads;
create trigger integrator_leads_guard
  before insert or update on public.integrator_leads
  for each row execute function private.guard_integrator_lead();

alter table public.integrator_applications enable row level security;
alter table public.integrator_leads enable row level security;

revoke all on table public.integrator_applications from public, anon, authenticated;
revoke all on table public.integrator_leads from public, anon, authenticated;

grant select, insert on table public.integrator_applications to authenticated;
grant select on table public.integrator_leads to authenticated;
grant all on table public.integrator_applications to service_role;
grant all on table public.integrator_leads to service_role;

drop policy if exists integrator_applications_select_own on public.integrator_applications;
drop policy if exists integrator_applications_insert_own on public.integrator_applications;
create policy integrator_applications_select_own
  on public.integrator_applications
  for select
  to authenticated
  using (
    applicant_user_id = (select auth.uid())
    or (
      kind = 'claim'
      and target_installer_id is not null
      and (select private.claims_installer(target_installer_id))
    )
    or (select private.is_admin())
  );

create policy integrator_applications_insert_own
  on public.integrator_applications
  for insert
  to authenticated
  with check (
    applicant_user_id = (select auth.uid())
    and status = 'pending'
    and staff_note is null
    and reviewed_at is null
    and reviewed_by is null
    and result_installer_id is null
    and country_code in ('US', 'CA')
    and exists (
      select 1 from public.profiles
      where id = (select auth.uid()) and role = 'installer'
    )
  );

drop policy if exists integrator_leads_select_claimed on public.integrator_leads;
create policy integrator_leads_select_claimed
  on public.integrator_leads
  for select
  to authenticated
  using (
    (select private.claims_installer(installer_id))
    or (select private.is_admin())
  );

-- Public directory keeps its redaction view. security_invoker stays off so
-- anonymous readers still see unclaimed companies; installers row security
-- would hide those rows. House number is no longer concatenated into the street.
create or replace view public.installer_directory
with (security_barrier = true, security_invoker = false) as
select
  id,
  company_name,
  country_code,
  city,
  postal_code,
  service_radius_km,
  knx_official_rank,
  is_founding_partner,
  avg_response_hours,
  verified_projects_count,
  public_website,
  latitude,
  longitude,
  case
    when claimed_by_user_id is null then null
    else nullif(btrim(street_address), '')
  end as public_street,
  case
    when knx_official_rank = 'Silver' and claimed_by_user_id is null then null
    when is_contact_public is not true then null
    else public_email
  end as public_email,
  (knx_official_rank = 'Silver' and claimed_by_user_id is null) as contact_withheld
from public.installers
where opted_out = false;

comment on view public.installer_directory is
  'Public directory for the United States and Canada. Unclaimed rows omit street. Unclaimed Silver also omits email. House number is never selected. There is no phone column. Sort is not defined here.';
