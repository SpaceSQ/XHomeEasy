import fs from "node:fs";
import path from "node:path";

const dir = "/Users/David1/XHomeEasy/apps/apple-client/XHomeEasy/Resources/OfflineKnowledgeBundle";
const manifest = JSON.parse(fs.readFileSync(path.join(dir, "manifest.json"), "utf8")) as {
  counts: Record<string, number>;
  excluded: string[];
};
const expected: Record<string, number> = {
  brands: 73,
  cases: 30,
  fusion: 194,
  subsystems: 564,
  partners: 1132,
  nicheWired: 125,
  wirelessIntercept: 150,
};
for (const [key, count] of Object.entries(expected)) {
  if (manifest.counts[key] !== count) throw new Error(`${key} is ${manifest.counts[key]}, expected ${count}`);
}

function load(name: string): Record<string, unknown>[] {
  return JSON.parse(fs.readFileSync(path.join(dir, name), "utf8")) as Record<string, unknown>[];
}

const files = ["brands.json", "cases.json", "fusion.json", "subsystems.json", "partners.json"];
for (const file of files) {
  const raw = fs.readFileSync(path.join(dir, file), "utf8");
  if (raw.includes("99-raw/") || raw.includes("03-suite-related")) {
    throw new Error(`${file} contains an excluded corpus path`);
  }
  for (const row of load(file)) {
    const tier = String(row.tier ?? "");
    const url = String(row.url ?? "");
    if (!/^E[1-4]$/.test(tier)) throw new Error(`${file} ${row.id} missing tier`);
    if (!url.startsWith("http")) throw new Error(`${file} ${row.id} missing source url`);
  }
}
const fusion = load("fusion.json");
if (fusion.some((row) => !String(row.takeaway ?? "").trim() || !String(row.pattern ?? "").trim())) {
  throw new Error("fusion takeaway or pattern missing");
}
const subsystems = load("subsystems.json");
if (subsystems.some((row) => !String(row.fit ?? "").trim() || !String(row.takeaway ?? "").trim())) {
  throw new Error("subsystem fit or takeaway missing");
}
for (const file of ["niche-wired.corpus.jsonl", "wireless-intercept.corpus.jsonl"]) {
  const lines = fs.readFileSync(path.join(dir, file), "utf8").split(/\n/).filter(Boolean);
  const expectedLines = file.startsWith("niche") ? 125 : 150;
  if (lines.length !== expectedLines) throw new Error(`${file} has ${lines.length} lines`);
  if (lines.some((line) => line.includes("99-raw/") || line.includes("03-suite-related"))) {
    throw new Error(`${file} contains an excluded corpus path`);
  }
}
const radar = load("radar-records.json");
if (radar.length !== 275) throw new Error(`radar records ${radar.length}`);
const wired = radar.filter((row) => row.kind === "wired");
const wireless = radar.filter((row) => row.kind === "wireless");
if (wired.length !== 125 || wireless.length !== 150) throw new Error("radar kind split is wrong");
for (const row of radar) {
  const tier = String(row.evidenceTier ?? "");
  const sources = row.sources as { url?: string }[];
  if (!/^E[1-4]$/.test(tier)) throw new Error(`${row.id} missing tier`);
  if (!sources?.length || !String(sources[0].url ?? "").startsWith("http")) throw new Error(`${row.id} missing source`);
  if (row.kind === "wireless" && !(row.redirectScript as string)?.includes("Control4")) throw new Error(`${row.id} missing redirect`);
  if (row.kind === "wired" && !String(row.fourGiantBridge ?? "").trim()) throw new Error(`${row.id} missing bridge`);
}
const span = radar.find((row) => row.id === "NW069");
const x10 = radar.find((row) => row.id === "NW001");
if (span?.lineVoltageBoundary !== true || x10?.lineVoltageBoundary !== false) throw new Error("line-voltage flags drifted");
const index = JSON.parse(fs.readFileSync(path.join(dir, "keyword_radar_index.json"), "utf8")) as { keywords: Record<string, string[]> };
const ids = new Set(radar.map((row) => String(row.id)));
for (const [keyword, mapped] of Object.entries(index.keywords)) {
  if (keyword !== keyword.toLowerCase() || mapped.length === 0) throw new Error(`bad keyword ${keyword}`);
  if (mapped.some((id) => !ids.has(id))) throw new Error(`${keyword} points outside the corpus`);
}
if (!index.keywords.x10?.includes("NW001")) throw new Error("x10 index missing NW001");
if (!index.keywords.matter?.includes("WL001")) throw new Error("matter index missing WL001");
console.log("citation verify ok", manifest.counts);
