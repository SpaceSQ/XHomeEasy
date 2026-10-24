-- X Home Easy cloud schema. The iOS app ships an offline bundle and does not require this database to run.
-- Embeddings stay nullable until a later retrieval job. Do not load 99-raw into these tables.

create extension if not exists vector;
create extension if not exists postgis;

create type evidence_tier as enum ('E1', 'E2', 'E3', 'E4');

create table public.brand_manifests (
    id text primary key,
    brand text not null,
    section_category text not null,
    title text not null,
    summary_zh text not null,
    architecture_notes jsonb default '{}'::jsonb,
    handover_policy jsonb default '{}'::jsonb,
    remote_subscription jsonb default '{}'::jsonb,
    tier evidence_tier not null default 'E1',
    source_url text not null,
    fetched_on date not null default '2026-10-21'
);

create table public.fusion_corpus (
    id text primary key,
    title text not null,
    category text not null,
    brands text[] not null,
    tier evidence_tier not null,
    region text default 'Other',
    project_type text,
    fusion_pattern text not null,
    summary_zh text not null,
    app_takeaway_zh text not null,
    install_notes text,
    training_snippet text,
    source_url text not null,
    source_name text,
    fetched_on date not null default '2026-10-21',
    embedding vector(1536)
);

create table public.subsystems_corpus (
    id text primary key,
    category text not null,
    brand text not null,
    subsystem text not null,
    title text not null,
    tier evidence_tier not null,
    region text,
    mentions_legacy_brands boolean default false,
    control_layer_fit text not null,
    summary_zh text not null,
    app_takeaway_zh text not null,
    install_notes text,
    source_url text not null,
    fetched_on date not null default '2026-10-21',
    embedding vector(1536)
);

create table public.channel_partners (
    id uuid primary key default gen_random_uuid(),
    external_id text unique,
    name text not null,
    brand_affiliations text[] not null,
    address text,
    region text,
    city text,
    state text,
    country text default 'US',
    phone text,
    email text,
    website text,
    service_scope text,
    claimed_case_studies text,
    certification_tiers text[],
    source_url text not null,
    source_tier evidence_tier not null,
    is_claimed boolean default false,
    is_sponsored boolean default false,
    license_verified_at timestamptz,
    fetched_on date not null default '2026-10-21'
);

create table public.projects_rfq (
    id uuid primary key default gen_random_uuid(),
    owner_id uuid references auth.users(id),
    architect_id uuid references auth.users(id),
    project_title text not null,
    zip_code text not null,
    city text not null,
    state text not null,
    build_stage text not null check (build_stage in ('new_build_pre_drywall', 'major_renovation', 'retrofit_existing', 'inherited_home')),
    sqft_range text not null,
    room_cards jsonb not null,
    preferred_control_brands text[] not null,
    selected_tier text not null check (selected_tier in ('Good', 'Better', 'Best')),
    budget_bandwidth jsonb not null,
    mandatory_handover_clauses jsonb not null,
    status text not null default 'draft' check (status in ('draft', 'published', 'quoting', 'awarded', 'in_construction', 'handover_complete')),
    created_at timestamptz default now()
);

create table public.dealer_quotes (
    id uuid primary key default gen_random_uuid(),
    rfq_id uuid references public.projects_rfq(id) on delete cascade,
    partner_id uuid references public.channel_partners(id),
    proposed_control_brand text not null,
    proposed_lighting_brand text not null,
    hardware_cost_usd numeric not null,
    prewire_infra_cost_usd numeric not null,
    install_labor_cost_usd numeric not null,
    programming_cost_usd numeric not null,
    programming_hours numeric not null,
    programming_hourly_rate numeric not null,
    rack_network_cost_usd numeric not null,
    annual_subscription_usd numeric default 0,
    subscription_mandatory boolean default false,
    handover_terms_accepted boolean not null,
    warranty_months integer not null default 12,
    risk_warnings jsonb default '[]'::jsonb,
    created_at timestamptz default now()
);

alter table public.brand_manifests enable row level security;
alter table public.fusion_corpus enable row level security;
alter table public.subsystems_corpus enable row level security;
alter table public.channel_partners enable row level security;
alter table public.projects_rfq enable row level security;
alter table public.dealer_quotes enable row level security;

create policy "public read brands" on public.brand_manifests for select using (true);
create policy "public read fusion" on public.fusion_corpus for select using (true);
create policy "public read subsystems" on public.subsystems_corpus for select using (true);
create policy "public read partners" on public.channel_partners for select using (true);

create policy "owner reads rfq" on public.projects_rfq for select using (auth.uid() = owner_id or auth.uid() = architect_id);
create policy "owner writes rfq" on public.projects_rfq for all using (auth.uid() = owner_id) with check (auth.uid() = owner_id);

create policy "quote readers" on public.dealer_quotes for select using (
  exists (
    select 1 from public.projects_rfq p
    where p.id = rfq_id and (p.owner_id = auth.uid() or p.architect_id = auth.uid())
  )
);
