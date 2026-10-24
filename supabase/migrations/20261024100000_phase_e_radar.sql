-- Phase E keyword radar. The iPhone reads the offline bundle; these tables are the server copy.
-- Prices stay text ranges from the corpus. Do not compute an MSRP here.
-- Load rows from supabase/seeds/phase_e_radar.sql after this migration. Ingest regenerates that seed.

create table public.niche_wired_systems (
    id text primary key check (id ~ '^NW[0-9]{3}$'),
    section text not null,
    brand_or_protocol_name text not null,
    trigger_keywords text[] not null check (cardinality(trigger_keywords) > 0),
    operating_company text not null,
    founded_year_and_status text not null,
    status_enum text not null,
    protocol_characteristics text not null,
    pros text[] not null check (cardinality(pros) > 0),
    cons text[] not null check (cardinality(cons) > 0),
    main_products text[] not null check (cardinality(main_products) > 0),
    application_areas text[] not null check (cardinality(application_areas) > 0),
    price_range_and_model text not null,
    xhome_action_advice text not null,
    four_giant_bridge text not null,
    evidence_tier evidence_tier not null,
    sources jsonb not null,
    line_voltage_boundary boolean not null default false,
    fetched_on date not null default '2026-10-24'
);

create table public.wireless_intercept_catalog (
    id text primary key check (id ~ '^WL[0-9]{3}$'),
    section text not null,
    brand_or_protocol_name text not null,
    trigger_keywords text[] not null check (cardinality(trigger_keywords) > 0),
    operating_company text not null,
    founded_year_and_status text not null,
    status_enum text not null,
    protocol_characteristics text not null,
    pros text[] not null check (cardinality(pros) > 0),
    cons text[] not null check (cardinality(cons) > 0),
    main_products text[] not null check (cardinality(main_products) > 0),
    application_areas text[] not null check (cardinality(application_areas) > 0),
    price_range_and_model text not null,
    xhome_action_advice text not null,
    redirect_target_app text[] not null check (cardinality(redirect_target_app) > 0),
    redirect_script_zh text not null,
    evidence_tier evidence_tier not null,
    sources jsonb not null,
    line_voltage_boundary boolean not null default false,
    fetched_on date not null default '2026-10-24'
);

create table public.keyword_radar_index (
    keyword text primary key,
    record_ids text[] not null check (cardinality(record_ids) > 0)
);

create index niche_wired_keywords_gin on public.niche_wired_systems using gin (trigger_keywords);
create index wireless_intercept_keywords_gin on public.wireless_intercept_catalog using gin (trigger_keywords);
create index keyword_radar_ids_gin on public.keyword_radar_index using gin (record_ids);

alter table public.niche_wired_systems enable row level security;
alter table public.wireless_intercept_catalog enable row level security;
alter table public.keyword_radar_index enable row level security;

create policy "public read niche wired" on public.niche_wired_systems for select using (true);
create policy "public read wireless intercept" on public.wireless_intercept_catalog for select using (true);
create policy "public read keyword radar" on public.keyword_radar_index for select using (true);

comment on table public.niche_wired_systems is 'Phase E1 NW001-NW125. Offline bundle is what the app matches against.';
comment on table public.wireless_intercept_catalog is 'Phase E2 WL001-WL150. Hits redirect to AHomeEasy or MHomeEasy. Not a wireless recommendation.';
comment on column public.niche_wired_systems.line_voltage_boundary is 'True means show the licensed-electrician topology-only boundary. Never a wiring procedure.';
