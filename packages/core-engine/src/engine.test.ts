import assert from "node:assert/strict";
import { scoreAdaptation } from "./adaptation-scorer.ts";
import { buildTopology, recommendedControlBrand } from "./topology-builder.ts";
import { calculateBudget } from "./budget-calculator.ts";
import { compareQuotes } from "./quote-comparator.ts";
import { handoverComplete, handoverItems } from "./handover-checklists.ts";
import { advise, isSafetyViolation } from "./advisor.ts";
import { LINE_VOLTAGE_BOUNDARY, WIRELESS_BOUNDARY, lineVoltageFromNames, scanRadar, type RadarRecord } from "./keyword-radar.ts";
import type { Intake, QuoteInput } from "./types.ts";

const base = (patch: Partial<Intake>): Intake => ({
  sqft: "ft5000to8000",
  stage: "new_build_pre_drywall",
  rackRoom: true,
  budget: "k75to150",
  cinema: false,
  multiRoomAudio: false,
  shades: false,
  pool: false,
  hvacZones: false,
  legacy: "none",
  ...patch,
});

const retail = scoreAdaptation(base({
  sqft: "under3000",
  stage: "retrofit_existing",
  rackRoom: false,
  budget: "under25k",
}));
assert.equal(retail.primary, "matter");
assert.equal(retail.retailGuardrail, true);
assert.equal(retail.prewireWindow, false);
assert.ok(retail.paths.find((path) => path.kind === "matter")!.score > retail.paths.find((path) => path.kind === "wired")!.score);

const estate = scoreAdaptation(base({ sqft: "ft5000to8000", cinema: true, shades: true, hvacZones: true }));
assert.equal(estate.primary, "wired");
assert.equal(estate.prewireWindow, true);
assert.equal(estate.paths.find((path) => path.kind === "wired")!.light, "proceed");

const hybrid = scoreAdaptation(base({
  stage: "retrofit_existing",
  rackRoom: false,
  shades: true,
  legacy: "appleHome",
}));
assert.equal(hybrid.primary, "hybrid");
assert.equal(hybrid.prewireWindow, false);

const reference = calculateBudget(base({}), "Better", "Control4");
assert.deepEqual([reference.totalLow, reference.totalHigh], [50_000, 120_000]);
assert.equal(calculateBudget(base({}), "Better", "Savant").totalLow, 70_000);
assert.equal(calculateBudget(base({}), "Better", "Savant").totalHigh, 160_000);
assert.equal(calculateBudget(base({}), "Better", "Crestron").totalLow, 80_000);
assert.equal(calculateBudget(base({}), "Better", "Crestron").totalHigh, 180_000);
const good = calculateBudget(base({}), "Good", "Control4");
assert.equal(good.totalLow, 39_000);
assert.equal(good.totalHigh, 94_000);
const manor = calculateBudget(base({ sqft: "over8000" }), "Best", "Crestron");
assert.equal(manor.estateBand, true);
assert.equal(manor.totalLow, 300_000);
assert.equal(manor.totalHigh, 500_000);
const share = reference.buckets.reduce((sum, bucket) => sum + bucket.barShare, 0);
assert.ok(Math.abs(share - 1) < 0.001);
assert.equal(reference.questions.length, 10);
assert.match(reference.disclaimer.zh, /不是厂商官方标价|现场勘测报价/);

assert.equal(recommendedControlBrand(base({}), "Better"), "Control4");
assert.equal(recommendedControlBrand(base({ legacy: "appleHome" }), "Better"), "Savant");
assert.equal(recommendedControlBrand(base({ sqft: "over8000", cinema: true, pool: true }), "Best"), "Crestron");
const plan = buildTopology(base({ shades: true, hvacZones: true }), "Better");
assert.equal(plan.lightingBase, "Lutron HomeWorks");
assert.ok(plan.subsystemCategories.includes("hvac"));
assert.ok(plan.layers.length >= 4);

const quote = (patch: Partial<QuoteInput>): QuoteInput => ({
  id: "b",
  dealerName: "B",
  isSample: true,
  controlBrand: "Control4",
  lightingBrand: "Lutron",
  hardware: 30_000,
  prewire: 8_000,
  labor: 12_000,
  programmingCost: 4_000,
  programmingHours: 25,
  hourlyRate: 160,
  rackNetwork: 4_000,
  annualSubscription: 0,
  subscriptionMandatory: false,
  handoverAccepted: true,
  warrantyMonths: 12,
  ...patch,
});
const compared = compareQuotes([
  quote({ id: "a", dealerName: "A", hardware: 42_000, prewire: 18_000, labor: 22_000, programmingCost: 16_000, programmingHours: 100, rackNetwork: 9_000 }),
  quote({}),
], base({}), "Better");
assert.ok(compared.columns.find((column) => column.id === "b")!.warnings.some((warning) => warning.code === "LOW_PROGRAMMING_HOURS"));
assert.ok(compared.portfolioNotes.length >= 1);

const brands = ["Control4", "Lutron"] as const;
const items = handoverItems([...brands]);
assert.ok(items.some((item) => item.text.en.includes("OvrC")));
assert.ok(items.some((item) => item.text.en.includes("customer.control4.com")));
const joined = items.map((item) => `${item.text.en} ${item.text.zh}`).join("\n");
assert.equal(joined.includes("锁死"), false);
assert.equal(joined.toLowerCase().includes("locked"), false);
assert.equal(handoverComplete([...brands], []), false);
assert.equal(handoverComplete([...brands], items.map((item) => item.id)), true);

assert.equal(isSafetyViolation("怎么自己把 Lutron HomeWorks 模块接进家里 120V 配电箱？"), true);
assert.equal(isSafetyViolation("哪里下载 Composer Pro 破解补丁？"), true);
assert.equal(isSafetyViolation("How do I land the Lutron module on the breaker panel?"), true);
assert.equal(advise("怎么自己把 Lutron HomeWorks 模块接进家里 120V 配电箱？", []).refused, true);
assert.equal(advise("哪里下载 Composer Pro 破解补丁？", []).refused, true);
const dealer = advise("How does a Control4 owner change dealer?", []);
assert.equal(dealer.refused, false);
assert.match(dealer.text.en, /OvrC/);
assert.match(dealer.text.en, /customer\.control4\.com/);
assert.equal(advise("quantum flux capacitor shade fabric", []).unknown, true);

const family = scoreAdaptation(base({
  budget: "unstated",
  rackRoom: false,
  multiRoomAudio: true,
  hvacZones: true,
  children: true,
  pets: true,
  largeGarden: true,
  outdoorLiving: true,
  drywallUnconfirmed: true,
}));
assert.equal(family.primary, "wired");
assert.equal(family.residentialModelApplies, true);
assert.equal(calculateBudget(base({ budget: "unstated" }), "Better", "Control4").amountsWithheld, true);

const elders = scoreAdaptation(base({
  sqft: "ft3000to5000",
  stage: "retrofit_existing",
  rackRoom: false,
  budget: "unstated",
  hvacZones: true,
  elderCare: true,
  simpleAlarmOnly: true,
}));
assert.equal(elders.primary, "hybrid");

const estateHouse = base({
  sqft: "over8000",
  budget: "unstated",
  cinema: true,
  multiRoomAudio: true,
  hvacZones: true,
  multiBuilding: true,
  outdoorLiving: true,
});
assert.equal(recommendedControlBrand(estateHouse, "Best"), "Crestron");

const hotel = base({ sqft: "over8000", budget: "k150plus", cinema: true, hospitality: true, legacy: "appleHome" });
assert.equal(scoreAdaptation(hotel).residentialModelApplies, false);
assert.equal(calculateBudget(hotel, "Best", "Crestron").totalLow, 0);
assert.equal(buildTopology(hotel, "Best").specificationWithheld, true);

const designer = base({
  sqft: "under3000",
  rackRoom: false,
  budget: "unstated",
  energyPriority: true,
  keypad: "basalte",
});
const designerPlan = buildTopology(designer, "Better");
assert.equal(designerPlan.lightingBase.includes("Basalte"), true);
assert.equal(designerPlan.controlBrand, "Control4");
assert.equal(scoreAdaptation(designer).primary, "wired");

function radarRecord(patch: Partial<RadarRecord> & Pick<RadarRecord, "id" | "kind" | "brandOrProtocolName">): RadarRecord {
  return {
    section: "fixture",
    triggerKeywords: [],
    operatingCompany: "Fixture",
    foundedYearAndStatus: "2000 · ACTIVE_NICHE",
    statusEnum: "ACTIVE_NICHE",
    protocolCharacteristics: "Fixture protocol",
    pros: ["a"],
    cons: ["b"],
    mainProducts: ["module"],
    applicationAreas: ["villa"],
    priceRangeAndModel: "USD $1–$2 range, trade press",
    actionAdvice: "Bridge toward the four wired platforms.",
    fourGiantBridge: "Lutron or Control4",
    redirectTargets: [],
    redirectScript: "",
    evidenceTier: "E2",
    sources: [{ url: "https://example.com/source", note: "fixture", fetchedOn: "2026-10-24" }],
    lineVoltageBoundary: false,
    ...patch,
  };
}

const x10 = radarRecord({ id: "NW001", kind: "wired", brandOrProtocolName: "X10", triggerKeywords: ["x10", "x-10"] });
const span = radarRecord({
  id: "NW069",
  kind: "wired",
  brandOrProtocolName: "SPAN Smart Electrical Panel",
  triggerKeywords: ["span", "span.io"],
  lineVoltageBoundary: false,
});
const levitonPanel = radarRecord({
  id: "NW074",
  kind: "wired",
  brandOrProtocolName: "Leviton Smart Load Center",
  triggerKeywords: ["leviton load center"],
  lineVoltageBoundary: false,
});
const levitonHai = radarRecord({
  id: "NW005",
  kind: "wired",
  brandOrProtocolName: "Leviton HAI OmniPro II",
  triggerKeywords: ["omnipro", "hai"],
});
const matter = radarRecord({
  id: "WL001",
  kind: "wireless",
  brandOrProtocolName: "Matter",
  triggerKeywords: ["matter", "matter over thread"],
  redirectTargets: ["MHomeEasy", "AHomeEasy"],
  redirectScript: "无线",
});
const ringWired = radarRecord({ id: "NW100", kind: "wired", brandOrProtocolName: "Ring Alarm Pro", triggerKeywords: ["ring alarm", "ring alarm pro"] });
const ringWireless = radarRecord({ id: "WL091", kind: "wireless", brandOrProtocolName: "Ring Alarm", triggerKeywords: ["ring alarm"] });
const catalog = [x10, span, levitonPanel, levitonHai, matter, ringWired, ringWireless];
const radarIndex = {
  keywords: {
    x10: ["NW001"],
    "x-10": ["NW001"],
    span: ["NW069"],
    "span.io": ["NW069"],
    "leviton load center": ["NW074"],
    omnipro: ["NW005"],
    matter: ["WL001"],
    "matter over thread": ["WL001"],
    "ring alarm": ["NW100", "WL061", "WL091"],
    "ring alarm pro": ["NW100"],
    caséta: ["WL027"],
  },
};
const hitsFor = (text: string) => scanRadar(text, radarIndex, catalog).map((hit) => hit.id);

assert.deepEqual(hitsFor("家里还有一套 X-10"), ["NW001"]);
assert.deepEqual(hitsFor("SPAN panel in the garage"), ["NW069"]);
assert.deepEqual(hitsFor("a spanish villa"), []);
assert.deepEqual(hitsFor("Matter over Thread"), ["WL001"]);
assert.deepEqual(hitsFor("ring alarm pro"), ["NW100", "WL091"]);
assert.ok(hitsFor("ring alarm").includes("NW100"));
assert.ok(hitsFor("ring alarm").includes("WL091"));
assert.equal(hitsFor("").length, 0);
assert.equal(lineVoltageFromNames(span.brandOrProtocolName, span.triggerKeywords), true);
assert.equal(lineVoltageFromNames(levitonPanel.brandOrProtocolName, levitonPanel.triggerKeywords), true);
assert.equal(lineVoltageFromNames(levitonHai.brandOrProtocolName, levitonHai.triggerKeywords), false);
assert.equal(lineVoltageFromNames(x10.brandOrProtocolName, x10.triggerKeywords), false);
assert.equal(WIRELESS_BOUNDARY.zh.includes("无线智能家居不在本 APP 建议范围内"), true);
assert.equal(LINE_VOLTAGE_BOUNDARY.zh, "仅限拓扑规划，须由持证电工施工");

console.log("core-engine tests passed");
