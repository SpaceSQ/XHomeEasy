-- X Home Easy website accounts. Own project. Not the KHomeEasy database.
-- Countries are the United States and Canada. Listing rank keeps the column
-- name knx_official_rank so the shared account shape stays stable.

create extension if not exists "uuid-ossp";
create schema if not exists private;
revoke all on schema private from public;
grant usage on schema private to anon, authenticated, service_role;

do $$ begin
  create type public.evidence_level as enum ('E1', 'E2', 'E3', 'E4');
exception when duplicate_object then null;
end $$;

do $$ begin
  create type public.project_stage as enum (
    'cognition', 'planning', 'rfq_sent', 'quoting', 'contracting', 'construction', 'handover', 'maintenance'
  );
exception when duplicate_object then null;
end $$;

do $$ begin
  create type public.knx_partner_rank as enum ('Silver', 'Gold', 'Platinum');
exception when duplicate_object then null;
end $$;

create table if not exists public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  role text not null default 'homeowner' check (role in ('homeowner', 'architect', 'installer', 'admin')),
  full_name text,
  locale text default 'en-US' check (locale in ('en-US', 'de-DE')),
  country_code text default 'US' check (country_code in ('US', 'CA')),
  postal_code text,
  city text,
  house_number text,
  address_line text,
  area_sqm integer,
  floors integer,
  room_count integer,
  latitude double precision,
  longitude double precision,
  created_at timestamptz default now(),
  constraint profiles_area_sqm_check check (area_sqm is null or area_sqm > 0),
  constraint profiles_floors_check check (floors is null or floors > 0),
  constraint profiles_room_count_check check (room_count is null or room_count > 0)
);

comment on column public.profiles.house_number is
  'Owner-only house number. Not shown to integrators until a later request explicitly includes it.';

create table if not exists public.projects (
  id uuid primary key default uuid_generate_v4(),
  owner_id uuid not null references public.profiles (id) on delete cascade,
  title text not null default 'My project',
  stage public.project_stage not null default 'cognition',
  build_type text not null default 'unsure' check (build_type in ('new_build', 'renovation', 'unsure')),
  construction_phase text check (construction_phase in ('design', 'shell_construction', 'finished')),
  area_sqm integer,
  selected_tier text default 'better' check (selected_tier in ('good', 'better', 'best')),
  fit_assessment_json jsonb,
  budget_estimate_json jsonb,
  is_pro_unlocked boolean default false,
  stripe_payment_id text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

comment on column public.projects.stripe_payment_id is
  'Historical column name. Written only by the service role after Apple confirms an in-app purchase. Not a Stripe charge.';

create table if not exists public.installers (
  id uuid primary key default uuid_generate_v4(),
  claimed_by_user_id uuid references public.profiles (id),
  company_name text not null,
  country_code text not null check (country_code in ('US', 'CA')),
  city text not null,
  postal_code text not null,
  street_address text,
  house_number text,
  service_radius_km integer default 50,
  knx_official_rank public.knx_partner_rank not null default 'Silver',
  is_contact_public boolean default false,
  public_email text,
  public_website text,
  subscription_tier text default 'free' check (subscription_tier in ('free', 'pro')),
  is_founding_partner boolean default false,
  avg_response_hours integer,
  verified_projects_count integer default 0,
  gdpr_art14_notified_at timestamptz,
  opted_out boolean default false,
  latitude double precision,
  longitude double precision,
  created_at timestamptz default now()
);

create table if not exists public.installer_fact_cards (
  id uuid primary key default uuid_generate_v4(),
  installer_id uuid not null references public.installers (id) on delete cascade,
  fact_category text not null,
  fact_text_de text not null,
  fact_text_en text not null,
  evidence public.evidence_level not null,
  source_url text not null,
  verified_at date not null,
  expires_at date not null,
  is_disputed boolean default false
);

create table if not exists public.login_challenges (
  id uuid primary key default gen_random_uuid(),
  secret_hash text not null,
  role text not null check (role in ('homeowner', 'installer')),
  status text not null default 'pending' check (status in ('pending', 'approved', 'consumed')),
  approved_by uuid references public.profiles (id),
  expires_at timestamptz not null,
  created_at timestamptz not null default now()
);

alter table public.login_challenges enable row level security;
revoke all on table public.login_challenges from public, anon, authenticated;
grant all on table public.login_challenges to service_role;

create or replace function private.is_admin()
returns boolean language sql stable security definer set search_path = ''
as $$
  select exists (select 1 from public.profiles where id = (select auth.uid()) and role = 'admin');
$$;

create or replace function private.owns_project(project_id uuid)
returns boolean language sql stable security definer set search_path = ''
as $$
  select exists (select 1 from public.projects where id = project_id and owner_id = (select auth.uid()));
$$;

create or replace function private.installer_is_listed(installer_id uuid)
returns boolean language sql stable security definer set search_path = ''
as $$
  select exists (select 1 from public.installers where id = installer_id and opted_out = false);
$$;

create or replace function private.claims_installer(installer_id uuid)
returns boolean language sql stable security definer set search_path = ''
as $$
  select exists (
    select 1 from public.installers
    where id = claims_installer.installer_id and claimed_by_user_id = (select auth.uid())
  );
$$;

revoke all on function private.is_admin() from public, anon;
revoke all on function private.owns_project(uuid) from public, anon;
revoke all on function private.installer_is_listed(uuid) from public;
revoke all on function private.claims_installer(uuid) from public, anon;
grant execute on function private.is_admin() to authenticated;
grant execute on function private.owns_project(uuid) to authenticated;
grant execute on function private.installer_is_listed(uuid) to anon, authenticated;
grant execute on function private.claims_installer(uuid) to authenticated;

create or replace function private.handle_new_user()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  insert into public.profiles (id, full_name, locale)
  values (
    new.id,
    nullif(new.raw_user_meta_data ->> 'full_name', ''),
    case
      when new.raw_user_meta_data ->> 'locale' in ('en-US', 'de-DE')
        then new.raw_user_meta_data ->> 'locale'
      else 'en-US'
    end
  )
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function private.handle_new_user();

create or replace function private.guard_profile_row()
returns trigger language plpgsql security invoker set search_path = ''
as $$
begin
  if current_user in ('postgres', 'supabase_admin', 'service_role')
     or coalesce(auth.role(), '') = 'service_role' then
    return new;
  end if;
  if tg_op = 'INSERT' then
    new.id := auth.uid();
    if new.role is distinct from 'homeowner' and new.role is distinct from 'architect' and new.role is distinct from 'installer' then
      new.role := 'homeowner';
    end if;
    return new;
  end if;
  new.id := old.id;
  new.created_at := old.created_at;
  if new.role = 'admin' and old.role is distinct from 'admin' then
    new.role := old.role;
  end if;
  return new;
end;
$$;

drop trigger if exists profiles_guard on public.profiles;
create trigger profiles_guard before insert or update on public.profiles
  for each row execute function private.guard_profile_row();

create or replace function private.guard_project_row()
returns trigger language plpgsql security invoker set search_path = ''
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
    new.owner_id := auth.uid();
    new.is_pro_unlocked := false;
    new.stripe_payment_id := null;
    new.updated_at := now();
    return new;
  end if;
  new.id := old.id;
  new.owner_id := old.owner_id;
  new.created_at := old.created_at;
  new.is_pro_unlocked := old.is_pro_unlocked;
  new.stripe_payment_id := old.stripe_payment_id;
  new.updated_at := now();
  return new;
end;
$$;

drop trigger if exists projects_guard on public.projects;
create trigger projects_guard before insert or update on public.projects
  for each row execute function private.guard_project_row();

create or replace function private.guard_installer_row()
returns trigger language plpgsql security invoker set search_path = ''
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
  if new.claimed_by_user_id is distinct from old.claimed_by_user_id then
    if old.claimed_by_user_id is null then
      new.claimed_by_user_id := auth.uid();
    else
      new.claimed_by_user_id := old.claimed_by_user_id;
    end if;
  end if;
  return new;
end;
$$;

drop trigger if exists installers_guard on public.installers;
create trigger installers_guard before insert or update on public.installers
  for each row execute function private.guard_installer_row();

revoke all on function private.handle_new_user() from public, anon, authenticated;
grant execute on function private.guard_profile_row() to authenticated, service_role;
grant execute on function private.guard_project_row() to authenticated, service_role;
grant execute on function private.guard_installer_row() to authenticated, service_role;

drop view if exists public.installer_directory;
create view public.installer_directory
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
    else nullif(btrim(concat_ws(' ', street_address, house_number)), '')
  end as public_street,
  case
    when knx_official_rank = 'Silver' and claimed_by_user_id is null then null
    when is_contact_public is not true then null
    else public_email
  end as public_email,
  (knx_official_rank = 'Silver' and claimed_by_user_id is null) as contact_withheld
from public.installers
where opted_out = false;

revoke all on table public.profiles from public, anon, authenticated;
revoke all on table public.projects from public, anon, authenticated;
revoke all on table public.installers from public, anon, authenticated;
revoke all on table public.installer_fact_cards from public, anon, authenticated;
revoke all on table public.installer_directory from public, anon, authenticated;

grant select, insert, update, delete on table public.profiles to authenticated;
grant select, insert, delete on table public.projects to authenticated;
grant update (
  title, stage, build_type, construction_phase, area_sqm, selected_tier,
  fit_assessment_json, budget_estimate_json, updated_at
) on table public.projects to authenticated;
grant select, delete on table public.installers to authenticated;
grant update (
  company_name, country_code, city, postal_code, street_address, house_number,
  service_radius_km, is_contact_public, public_email, public_website,
  avg_response_hours, gdpr_art14_notified_at, opted_out, claimed_by_user_id,
  latitude, longitude
) on table public.installers to authenticated;
grant select on table public.installer_fact_cards to anon, authenticated;
grant insert, update, delete on table public.installer_fact_cards to authenticated;
grant select on table public.installer_directory to anon, authenticated, service_role;
grant all on table public.profiles to service_role;
grant all on table public.projects to service_role;
grant all on table public.installers to service_role;
grant all on table public.installer_fact_cards to service_role;

alter table public.profiles enable row level security;
alter table public.projects enable row level security;
alter table public.installers enable row level security;
alter table public.installer_fact_cards enable row level security;

drop policy if exists profiles_select_own on public.profiles;
drop policy if exists profiles_insert_own on public.profiles;
drop policy if exists profiles_update_own on public.profiles;
drop policy if exists profiles_delete_own on public.profiles;
create policy profiles_select_own on public.profiles for select to authenticated
  using (id = (select auth.uid()) or (select private.is_admin()));
create policy profiles_insert_own on public.profiles for insert to authenticated
  with check (id = (select auth.uid()) and role is distinct from 'admin');
create policy profiles_update_own on public.profiles for update to authenticated
  using (id = (select auth.uid()) or (select private.is_admin()))
  with check ((id = (select auth.uid()) and role is distinct from 'admin') or (select private.is_admin()));
create policy profiles_delete_own on public.profiles for delete to authenticated
  using (id = (select auth.uid()) or (select private.is_admin()));

drop policy if exists projects_select_own on public.projects;
drop policy if exists projects_insert_own on public.projects;
drop policy if exists projects_update_own on public.projects;
drop policy if exists projects_delete_own on public.projects;
create policy projects_select_own on public.projects for select to authenticated
  using (owner_id = (select auth.uid()) or (select private.is_admin()));
create policy projects_insert_own on public.projects for insert to authenticated
  with check (owner_id = (select auth.uid()) and is_pro_unlocked is not true and stripe_payment_id is null);
create policy projects_update_own on public.projects for update to authenticated
  using (owner_id = (select auth.uid()) or (select private.is_admin()))
  with check (owner_id = (select auth.uid()) or (select private.is_admin()));
create policy projects_delete_own on public.projects for delete to authenticated
  using (owner_id = (select auth.uid()) or (select private.is_admin()));

drop policy if exists installers_select_claimed on public.installers;
drop policy if exists installers_update_claim on public.installers;
drop policy if exists installers_delete_admin on public.installers;
create policy installers_select_claimed on public.installers for select to authenticated
  using (claimed_by_user_id = (select auth.uid()) or (select private.is_admin()));
create policy installers_update_claim on public.installers for update to authenticated
  using (claimed_by_user_id = (select auth.uid()) or claimed_by_user_id is null or (select private.is_admin()))
  with check (claimed_by_user_id = (select auth.uid()) or (select private.is_admin()));
create policy installers_delete_admin on public.installers for delete to authenticated
  using ((select private.is_admin()));

drop policy if exists fact_cards_public_read on public.installer_fact_cards;
drop policy if exists fact_cards_claimed_write on public.installer_fact_cards;
drop policy if exists fact_cards_claimed_update on public.installer_fact_cards;
drop policy if exists fact_cards_claimed_delete on public.installer_fact_cards;
create policy fact_cards_public_read on public.installer_fact_cards for select to anon, authenticated
  using (is_disputed = false and expires_at >= current_date and (select private.installer_is_listed(installer_id)));
create policy fact_cards_claimed_write on public.installer_fact_cards for insert to authenticated
  with check ((select private.claims_installer(installer_id)) or (select private.is_admin()));
create policy fact_cards_claimed_update on public.installer_fact_cards for update to authenticated
  using ((select private.claims_installer(installer_id)) or (select private.is_admin()))
  with check ((select private.claims_installer(installer_id)) or (select private.is_admin()));
create policy fact_cards_claimed_delete on public.installer_fact_cards for delete to authenticated
  using ((select private.claims_installer(installer_id)) or (select private.is_admin()));
