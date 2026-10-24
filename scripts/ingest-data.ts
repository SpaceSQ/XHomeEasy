import crypto from "node:crypto";
import fs from "node:fs";
import path from "node:path";
import { lineVoltageFromNames } from "../packages/core-engine/src/keyword-radar.ts";

const root = "/Users/David1/XHomeEasy";
const doc = path.join(root, "deliverables/02-Doc");
const outDir = path.join(root, "apps/apple-client/XHomeEasy/Resources/OfflineKnowledgeBundle");

const PATTERN: Record<string, string> = {
  "knx-legacy": "KNX backbone + legacy control UI",
  "knx-gateway": "KNX multi-protocol gateway",
  "matter-retrofit": "Matter retrofit over a wired core",
  "matter-newbuild": "Matter new-build beside a wired core",
  "install-experience": "Field install note (no line-voltage steps)",
  trend: "Published market trend",
};

function readJSON<T>(file: string): T {
  return JSON.parse(fs.readFileSync(file, "utf8")) as T;
}

function firstSentence(text: string): string {
  const trimmed = text.replace(/\s+/g, " ").trim();
  const match = trimmed.match(/^.*?[。！？.!?]/);
  return (match?.[0] ?? trimmed).slice(0, 220);
}

function practiceLabel(region?: string): string | null {
  if (!region) return null;
  const value = region.toLowerCase();
  if (/(europe|united kingdom|\buk\b|england|scotland|glasgow|france|germany|spain|mallorca|italy|netherlands|belgium|sweden|iceland|switzerland|portugal|ireland)/.test(value)) {
    return "欧洲工程实践参考";
  }
  if (/(middle|dubai|uae|qatar|saudi|abu dhabi|^ae-)/.test(value)) return "中东工程实践参考";
  return null;
}

function excerpt(file: string): string {
  if (!fs.existsSync(file) || file.includes(`${path.sep}99-raw${path.sep}`)) return "";
  const raw = fs.readFileSync(file, "utf8");
  const lines = raw.split(/\r?\n/).filter((line) => {
    const trimmed = line.trim();
    return trimmed && !trimmed.startsWith("#") && !trimmed.startsWith("|") && !trimmed.startsWith("```");
  });
  return lines.join(" ").replace(/\s+/g, " ").slice(0, 420);
}

function brands() {
  const folders = ["01-Control4", "02-Crestron", "03-Savant", "04-Lutron"];
  const rows: Record<string, unknown>[] = [];
  for (const folder of folders) {
    const manifest = readJSON<{ brand: string; items: { id: string; category: string; title: string; source_url: string; fetched_on: string; local_path?: string; notes?: string }[] }>(
      path.join(doc, folder, "10-manifest.json"),
    );
    for (const item of manifest.items) {
      const local = item.local_path ?? "";
      const summary = local.includes("99-raw")
        ? (item.notes ?? item.title)
        : (excerpt(path.join(doc, local)) || item.notes || item.title);
      rows.push({
        id: item.id,
        brand: manifest.brand,
        category: item.category,
        title: item.title,
        summary,
        tier: "E1",
        url: item.source_url,
        fetchedOn: item.fetched_on,
      });
    }
  }
  return rows;
}

function cases() {
  const manifest = readJSON<{ items: { id: string; title: string; source_url: string; category: string; brands: string[]; geography?: string; quality_notes?: string; fetched_on: string }[] }>(
    path.join(doc, "06-internet-cases/manifest.json"),
  );
  return manifest.items.map((item) => {
    const host = new URL(item.source_url).hostname;
    const tier = /(control4|crestron|savant|lutron|knx\.org)/.test(host)
      ? "E1"
      : /(cepro|cedia|adiglobal)/.test(host) ? "E2" : "E3";
    return {
      id: item.id,
      title: item.title,
      category: item.category,
      brands: item.brands,
      geography: item.geography ?? "",
      practiceLabel: practiceLabel(item.geography),
      tier,
      url: item.source_url,
      note: item.quality_notes ?? "",
      fetchedOn: item.fetched_on,
    };
  });
}

function fusion() {
  const lines = fs.readFileSync(path.join(doc, "06-internet-cases/fusion-hybrid/corpus.jsonl"), "utf8").split(/\n/).filter(Boolean);
  return lines.map((line) => {
    const row = JSON.parse(line) as Record<string, unknown>;
    const summary = String(row.summary_zh ?? "");
    const takeaway = String(row.app_takeaway_zh ?? "").trim() || firstSentence(summary);
    const pattern = String(row.fusion_pattern ?? "").trim() || PATTERN[String(row.category)] || "Documented fusion note";
    const region = String(row.region ?? "Other");
    return {
      id: row.id,
      title: row.title,
      category: row.category,
      brands: row.brands ?? [],
      tier: row.evidence_tier,
      region,
      practiceLabel: practiceLabel(region),
      pattern,
      summary,
      takeaway,
      url: row.source_url,
      sourceName: row.source_name ?? "",
      fetchedOn: row.fetched_on ?? "2026-10-21",
    };
  });
}

function subsystems() {
  const lines = fs.readFileSync(path.join(doc, "08-subsystems/00-index/master.corpus.jsonl"), "utf8").split(/\n/).filter(Boolean);
  return lines.map((line) => {
    const row = JSON.parse(line) as Record<string, unknown>;
    const legacy = Array.isArray(row.mentions_legacy_brands) ? row.mentions_legacy_brands.map(String) : [];
    const summary = String(row.summary_zh ?? "");
    return {
      id: row.id,
      category: row.category,
      brand: row.brand,
      subsystem: row.subsystem,
      title: row.title,
      tier: row.evidence_tier,
      region: row.region ?? "",
      practiceLabel: practiceLabel(String(row.region ?? "")),
      mentionsLegacy: legacy.length > 0 || row.mentions_legacy_brands === true,
      legacyBrands: legacy,
      fit: String(row.control_layer_fit ?? ""),
      takeaway: String(row.app_takeaway_zh ?? "").trim() || firstSentence(summary),
      summary,
      url: row.source_url,
      fetchedOn: row.fetched_on ?? "2026-10-21",
    };
  });
}

function parseCSV(text: string): string[][] {
  const rows: string[][] = [];
  let row: string[] = [];
  let cell = "";
  let quoted = false;
  for (let i = 0; i < text.length; i += 1) {
    const char = text[i];
    if (quoted) {
      if (char === '"') {
        if (text[i + 1] === '"') {
          cell += '"';
          i += 1;
        } else quoted = false;
      } else cell += char;
    } else if (char === '"') quoted = true;
    else if (char === ",") {
      row.push(cell);
      cell = "";
    } else if (char === "\n") {
      row.push(cell);
      rows.push(row);
      row = [];
      cell = "";
    } else if (char !== "\r") cell += char;
  }
  if (cell.length || row.length) {
    row.push(cell);
    rows.push(row);
  }
  return rows.filter((entry) => entry.some((value) => value.trim().length > 0));
}

function splitList(value: string): string[] {
  return value.split(/[;|,]/).map((part) => part.trim()).filter(Boolean).filter((part) => !/none/i.test(part));
}

function partners() {
  const table = parseCSV(fs.readFileSync(path.join(doc, "07-channel-partners/unified/channel-partners-master.csv"), "utf8"));
  const [header, ...body] = table;
  const index = Object.fromEntries(header.map((name, position) => [name, position]));
  return body.map((cells, position) => ({
    id: `cp-${String(position + 1).padStart(4, "0")}`,
    name: cells[index.name] ?? "",
    brands: splitList(cells[index.brand_affiliations] ?? ""),
    city: cells[index.city] ?? "",
    state: cells[index.state] ?? "",
    country: cells[index.country] ?? "",
    phone: cells[index.phone] ?? "",
    email: cells[index.email] ?? "",
    website: cells[index.website] ?? "",
    tier: cells[index.source_tier] ?? "E3",
    url: cells[index.source_url] ?? "",
    certs: splitList(cells[index.certification_tiers] ?? ""),
    fetchedOn: cells[index.fetched_on] ?? "2026-10-21",
    sponsored: false,
  }));
}

function write(name: string, value: unknown) {
  fs.writeFileSync(path.join(outDir, name), JSON.stringify(value));
}

const CORE_FIELDS = [
  "brand_or_protocol_name",
  "trigger_keywords",
  "operating_company",
  "founded_year_and_status",
  "protocol_characteristics",
  "pros_and_cons",
  "main_products",
  "application_areas",
  "price_range_and_model",
  "xhome_action_advice",
] as const;

const STATUS_ENUM = new Set(["LEGACY_MAINTENANCE", "ACTIVE_NICHE", "ACTIVE_MAIN", "DISCONTINUED"]);
const TIERS = new Set(["E1", "E2", "E3", "E4"]);
const WIRED_SHA = "7858148567c4df53c6eafab0100df1e7cf429a0a0397d282ff0c56893e61b1f7";
const WIRELESS_SHA = "fc4a954429962accea8298a9f4d3ecfa430c5edeb68f89455da4499cebbd93e1";

function sha256(file: string): string {
  return crypto.createHash("sha256").update(fs.readFileSync(file)).digest("hex");
}

function fail(message: string): never {
  console.error(message);
  process.exit(1);
}

function asRecord(value: unknown, id: string): Record<string, unknown> {
  if (!value || typeof value !== "object" || Array.isArray(value)) fail(`${id} is not an object`);
  return value as Record<string, unknown>;
}

function asText(row: Record<string, unknown>, key: string, id: string): string {
  const value = row[key];
  if (typeof value !== "string" || !value.trim()) fail(`${id} missing ${key}`);
  return value.trim();
}

function asList(row: Record<string, unknown>, key: string, id: string): string[] {
  const value = row[key];
  if (!Array.isArray(value) || value.length === 0 || value.some((item) => typeof item !== "string" || !item.trim())) {
    fail(`${id} missing ${key}`);
  }
  return value.map((item) => String(item).trim());
}

function readJSONL(file: string): Record<string, unknown>[] {
  return fs.readFileSync(file, "utf8").split(/\n/).filter((line) => line.trim()).map((line, index) => {
    try {
      return asRecord(JSON.parse(line), `${path.basename(file)}:${index + 1}`);
    } catch (error) {
      fail(`${file}:${index + 1} ${(error as Error).message}`);
    }
  });
}

function expectIDs(rows: Record<string, unknown>[], prefix: "NW" | "WL", count: number) {
  const ids = rows.map((row) => String(row.id));
  if (new Set(ids).size !== count) fail(`${prefix} ids are not unique`);
  for (let number = 1; number <= count; number += 1) {
    const id = `${prefix}${String(number).padStart(3, "0")}`;
    if (!ids.includes(id)) fail(`missing ${id}`);
  }
}

interface RadarSourceRow {
  url: string;
  note: string;
  fetchedOn: string;
}

function sourcesOf(row: Record<string, unknown>, id: string): RadarSourceRow[] {
  const value = row.sources;
  if (!Array.isArray(value) || value.length === 0) fail(`${id} missing sources`);
  return value.map((item) => {
    const source = asRecord(item, id);
    const url = asText(source, "url", id);
    if (!url.startsWith("http")) fail(`${id} source is not a url`);
    return { url, note: asText(source, "note", id), fetchedOn: asText(source, "fetched_on", id) };
  });
}

function sqlText(value: string): string {
  return `'${value.replace(/'/g, "''")}'`;
}

function sqlArray(values: string[]): string {
  return `array[${values.map(sqlText).join(", ")}]::text[]`;
}

function phaseE() {
  const wiredFile = path.join(root, "Doc/10-niche-wired-systems/niche-wired.corpus.jsonl");
  const wirelessFile = path.join(root, "Doc/11-wireless-interception-catalog/wireless-intercept.corpus.jsonl");
  const wiredManifest = readJSON<{ total_records: number; corpus_sha256: string; counts_by_section: Record<string, number> }>(
    path.join(root, "Doc/10-niche-wired-systems/manifest.json"),
  );
  const wirelessManifest = readJSON<{ total_records: number; corpus_sha256: string; counts_by_section: Record<string, number> }>(
    path.join(root, "Doc/11-wireless-interception-catalog/manifest.json"),
  );
  if (sha256(wiredFile) !== WIRED_SHA || sha256(wiredFile) !== wiredManifest.corpus_sha256) fail("niche-wired corpus hash mismatch");
  if (sha256(wirelessFile) !== WIRELESS_SHA || sha256(wirelessFile) !== wirelessManifest.corpus_sha256) fail("wireless corpus hash mismatch");
  const wiredRows = readJSONL(wiredFile);
  const wirelessRows = readJSONL(wirelessFile);
  if (wiredRows.length !== 125 || wiredManifest.total_records !== 125) fail("expected 125 niche-wired records");
  if (wirelessRows.length !== 150 || wirelessManifest.total_records !== 150) fail("expected 150 wireless records");
  expectIDs(wiredRows, "NW", 125);
  expectIDs(wirelessRows, "WL", 150);
  const sectionCounts: Record<string, number> = {};
  const records: Record<string, unknown>[] = [];
  const keywords = new Map<string, Set<string>>();
  const addKeyword = (keyword: string, id: string) => {
    const key = keyword.toLowerCase();
    if (key.length < 2) fail(`${id} keyword too short: ${keyword}`);
    const bucket = keywords.get(key) ?? new Set<string>();
    bucket.add(id);
    keywords.set(key, bucket);
  };
  const consume = (row: Record<string, unknown>, kind: "wired" | "wireless") => {
    const id = asText(row, "id", kind);
    if ((kind === "wired" && !id.startsWith("NW")) || (kind === "wireless" && !id.startsWith("WL"))) fail(`${id} kind mismatch`);
    for (const field of CORE_FIELDS) {
      if (field === "trigger_keywords" || field === "main_products" || field === "application_areas") asList(row, field, id);
      else if (field !== "pros_and_cons") asText(row, field, id);
    }
    const prosAndCons = asRecord(row.pros_and_cons, id);
    const pros = asList(prosAndCons, "pros", id);
    const cons = asList(prosAndCons, "cons", id);
    const tier = asText(row, "evidence_tier", id);
    const status = asText(row, "status_enum", id);
    const section = asText(row, "section", id);
    if (!TIERS.has(tier)) fail(`${id} bad evidence tier`);
    if (!STATUS_ENUM.has(status)) fail(`${id} bad status`);
    const advice = asText(row, "xhome_action_advice", id);
    if (/第[一二三123]步/.test(advice) && /市电|120\s*v|breaker|配电箱接线/.test(advice.toLowerCase())) {
      fail(`${id} contains a line-voltage procedure`);
    }
    const triggerKeywords = asList(row, "trigger_keywords", id);
    const name = asText(row, "brand_or_protocol_name", id);
    const lineVoltageBoundary = (kind === "wired" && section === "03-hems-smart-panels") || lineVoltageFromNames(name, triggerKeywords);
    let fourGiantBridge = "";
    let redirectTargets: string[] = [];
    let redirectScript = "";
    if (kind === "wired") {
      fourGiantBridge = asText(row, "four_giant_bridge", id);
    } else {
      redirectTargets = asList(row, "redirect_target_app", id);
      if (redirectTargets.some((target) => target !== "AHomeEasy" && target !== "MHomeEasy")) fail(`${id} bad redirect target`);
      redirectScript = asText(row, "redirect_script_zh", id);
      if (!redirectScript.includes("无线") || !redirectScript.includes("Control4")) fail(`${id} redirect script incomplete`);
    }
    sectionCounts[section] = (sectionCounts[section] ?? 0) + 1;
    for (const keyword of triggerKeywords) addKeyword(keyword, id);
    const sources = sourcesOf(row, id);
    records.push({
      id,
      kind,
      section,
      brandOrProtocolName: name,
      triggerKeywords,
      operatingCompany: asText(row, "operating_company", id),
      foundedYearAndStatus: asText(row, "founded_year_and_status", id),
      statusEnum: status,
      protocolCharacteristics: asText(row, "protocol_characteristics", id),
      pros,
      cons,
      mainProducts: asList(row, "main_products", id),
      applicationAreas: asList(row, "application_areas", id),
      priceRangeAndModel: asText(row, "price_range_and_model", id),
      actionAdvice: advice,
      fourGiantBridge,
      redirectTargets,
      redirectScript,
      evidenceTier: tier,
      sources,
      lineVoltageBoundary,
    });
  };
  for (const row of wiredRows) consume(row, "wired");
  for (const row of wirelessRows) consume(row, "wireless");
  const expectedSections = { ...wiredManifest.counts_by_section, ...wirelessManifest.counts_by_section };
  for (const [section, count] of Object.entries(expectedSections)) {
    if (sectionCounts[section] !== count) fail(`${section} count ${sectionCounts[section]} != ${count}`);
  }
  const span = records.find((row) => row.id === "NW069");
  const leviton = records.find((row) => row.id === "NW074");
  const x10 = records.find((row) => row.id === "NW001");
  if (!span?.lineVoltageBoundary || !leviton?.lineVoltageBoundary || x10?.lineVoltageBoundary) {
    fail("line-voltage flags for SPAN, Leviton Load Center, or X10 are wrong");
  }
  const index = Object.fromEntries([...keywords.entries()].sort(([left], [right]) => left.localeCompare(right)).map(([key, ids]) => [
    key,
    [...ids].sort((left, right) => left.localeCompare(right, "en", { numeric: true })),
  ]));
  fs.copyFileSync(wiredFile, path.join(outDir, "niche-wired.corpus.jsonl"));
  fs.copyFileSync(wirelessFile, path.join(outDir, "wireless-intercept.corpus.jsonl"));
  write("radar-records.json", records);
  write("keyword_radar_index.json", { builtOn: "2026-10-24", keywordCount: Object.keys(index).length, recordCount: records.length, keywords: index });
  writePhaseESeed(records, index);
  return { nicheWired: wiredRows.length, wirelessIntercept: wirelessRows.length, radarKeywords: Object.keys(index).length };
}

function writePhaseESeed(records: Record<string, unknown>[], index: Record<string, string[]>) {
  const wired: string[] = [];
  const wireless: string[] = [];
  const keywordRows: string[] = [];
  for (const row of records) {
    const sources = JSON.stringify(row.sources).replace(/'/g, "''");
    const shared = [
      sqlText(String(row.id)),
      sqlText(String(row.section)),
      sqlText(String(row.brandOrProtocolName)),
      sqlArray(row.triggerKeywords as string[]),
      sqlText(String(row.operatingCompany)),
      sqlText(String(row.foundedYearAndStatus)),
      sqlText(String(row.statusEnum)),
      sqlText(String(row.protocolCharacteristics)),
      sqlArray(row.pros as string[]),
      sqlArray(row.cons as string[]),
      sqlArray(row.mainProducts as string[]),
      sqlArray(row.applicationAreas as string[]),
      sqlText(String(row.priceRangeAndModel)),
      sqlText(String(row.actionAdvice)),
    ];
    if (row.kind === "wired") {
      wired.push(`(${shared.join(", ")}, ${sqlText(String(row.fourGiantBridge))}, '${row.evidenceTier}'::evidence_tier, '${sources}'::jsonb, ${row.lineVoltageBoundary ? "true" : "false"}, '2026-10-24')`);
    } else {
      wireless.push(`(${shared.join(", ")}, ${sqlArray(row.redirectTargets as string[])}, ${sqlText(String(row.redirectScript))}, '${row.evidenceTier}'::evidence_tier, '${sources}'::jsonb, ${row.lineVoltageBoundary ? "true" : "false"}, '2026-10-24')`);
    }
  }
  for (const [keyword, ids] of Object.entries(index)) {
    keywordRows.push(`(${sqlText(keyword)}, ${sqlArray(ids)})`);
  }
  const sql = `-- Generated by scripts/ingest-data.ts from Doc/10 and Doc/11. Do not edit by hand.
begin;
insert into public.niche_wired_systems (
  id, section, brand_or_protocol_name, trigger_keywords, operating_company, founded_year_and_status, status_enum,
  protocol_characteristics, pros, cons, main_products, application_areas, price_range_and_model, xhome_action_advice,
  four_giant_bridge, evidence_tier, sources, line_voltage_boundary, fetched_on
) values
${wired.join(",\n")}
on conflict (id) do update set
  brand_or_protocol_name = excluded.brand_or_protocol_name,
  trigger_keywords = excluded.trigger_keywords,
  xhome_action_advice = excluded.xhome_action_advice,
  four_giant_bridge = excluded.four_giant_bridge,
  evidence_tier = excluded.evidence_tier,
  sources = excluded.sources,
  line_voltage_boundary = excluded.line_voltage_boundary;
insert into public.wireless_intercept_catalog (
  id, section, brand_or_protocol_name, trigger_keywords, operating_company, founded_year_and_status, status_enum,
  protocol_characteristics, pros, cons, main_products, application_areas, price_range_and_model, xhome_action_advice,
  redirect_target_app, redirect_script_zh, evidence_tier, sources, line_voltage_boundary, fetched_on
) values
${wireless.join(",\n")}
on conflict (id) do update set
  brand_or_protocol_name = excluded.brand_or_protocol_name,
  trigger_keywords = excluded.trigger_keywords,
  redirect_target_app = excluded.redirect_target_app,
  redirect_script_zh = excluded.redirect_script_zh,
  evidence_tier = excluded.evidence_tier,
  sources = excluded.sources;
insert into public.keyword_radar_index (keyword, record_ids) values
${keywordRows.join(",\n")}
on conflict (keyword) do update set record_ids = excluded.record_ids;
commit;
`;
  const seedDir = path.join(root, "supabase/seeds");
  fs.mkdirSync(seedDir, { recursive: true });
  fs.writeFileSync(path.join(seedDir, "phase_e_radar.sql"), sql);
}

const brandRows = brands();
const caseRows = cases();
const fusionRows = fusion();
const subsystemRows = subsystems();
const partnerRows = partners();
fs.mkdirSync(outDir, { recursive: true });
const radarCounts = phaseE();
write("brands.json", brandRows);
write("cases.json", caseRows);
write("fusion.json", fusionRows);
write("subsystems.json", subsystemRows);
write("partners.json", partnerRows);
const states = [...new Set(partnerRows.map((row) => row.state).filter(Boolean))].sort();
const manifest = {
  verifiedOn: "2026-10-24",
  counts: {
    brands: brandRows.length,
    cases: caseRows.length,
    fusion: fusionRows.length,
    subsystems: subsystemRows.length,
    partners: partnerRows.length,
    ...radarCounts,
  },
  emptyTakeaways: fusionRows.filter((row) => !row.takeaway).length + subsystemRows.filter((row) => !row.takeaway).length,
  states,
  excluded: ["02-Doc/99-raw", "Doc/99-raw", "03-suite-related", "Doc/10-niche-wired-systems/RAW_NOTES.md"],
};
write("manifest.json", manifest);
console.log(JSON.stringify(manifest.counts));
const expected = { brands: 73, cases: 30, fusion: 194, subsystems: 564, partners: 1132, nicheWired: 125, wirelessIntercept: 150 };
for (const [key, count] of Object.entries(expected)) {
  if (manifest.counts[key as keyof typeof expected] !== count) {
    console.error(`Count mismatch for ${key}`);
    process.exit(1);
  }
}
if (manifest.emptyTakeaways !== 0) {
  console.error("Empty takeaways remain");
  process.exit(1);
}
console.log("ingest ok");
