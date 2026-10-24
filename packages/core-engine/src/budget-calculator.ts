import type { BudgetReport, ControlBrand, Copy, CostBucket, Intake, PackageTier } from "./types.ts";
import { BUDGET_DISCLAIMER } from "./types.ts";

const copy = (en: string, zh: string): Copy => ({ en, zh });

const BASE: Record<ControlBrand, { low: number; high: number }> = {
  Control4: { low: 50_000, high: 120_000 },
  Savant: { low: 70_000, high: 160_000 },
  Crestron: { low: 80_000, high: 180_000 },
};

const SQFT: Record<Intake["sqft"], number> = {
  under3000: 0.55,
  ft3000to5000: 0.72,
  ft5000to8000: 1,
  over8000: 1.35,
};

const TIER: Record<PackageTier, number> = { Good: 0.78, Better: 1, Best: 1.32 };
const STAGE: Record<Intake["stage"], number> = {
  new_build_pre_drywall: 1,
  major_renovation: 0.96,
  retrofit_existing: 0.84,
  inherited_home: 0.78,
};

const HOURS: Record<Intake["sqft"], [number, number]> = {
  under3000: [24, 60],
  ft3000to5000: [48, 90],
  ft5000to8000: [80, 140],
  over8000: [120, 200],
};

const BUCKETS: { id: string; label: Copy; lowPct: number; highPct: number; mid: number }[] = [
  { id: "prewire", label: copy("Structured wiring and low-voltage infrastructure", "结构化布线与弱电基础设施"), lowPct: 0.15, highPct: 0.20, mid: 0.175 },
  { id: "lighting", label: copy("Lighting control and shades", "照明控制与电动遮阳"), lowPct: 0.20, highPct: 0.25, mid: 0.225 },
  { id: "av", label: copy("Distributed audio and theater", "分布式音频与家庭影院"), lowPct: 0.20, highPct: 0.30, mid: 0.25 },
  { id: "control", label: copy("Control hardware and programming", "控制平台硬件与编程调试"), lowPct: 0.15, highPct: 0.20, mid: 0.175 },
  { id: "aux", label: copy("Security, network, HVAC, and pool", "安防、网络、暖通与泳池"), lowPct: 0.10, highPct: 0.20, mid: 0.15 },
];

function round1k(n: number): number {
  return Math.round(n / 1000) * 1000;
}

export function expectedProgrammingHours(input: Intake, tier: PackageTier): { low: number; high: number } {
  const base = HOURS[input.sqft];
  const mul = tier === "Good" ? 0.75 : tier === "Best" ? 1.3 : 1;
  return { low: Math.round(base[0] * mul), high: Math.round(base[1] * mul) };
}

export function calculateBudget(input: Intake, tier: PackageTier, brand: ControlBrand): BudgetReport {
  if (input.hospitality || input.budget === "unstated") {
    return {
      totalLow: 0,
      totalHigh: 0,
      estateBand: false,
      amountsWithheld: true,
      buckets: [],
      programmingShare: copy(
        "Programming is often described as 15–25% and about $100–$250 per hour when a residential project has a stated band. No dollars are shown until that band exists.",
        "住宅项目在已选择预算档时，编程常见为 15%–25%，工时费常见每小时 100–250 美元。没有预算档之前，不显示金额。",
      ),
      programmingHoursLow: 0,
      programmingHoursHigh: 0,
      hourlyRateLow: 100,
      hourlyRateHigh: 250,
      laborComposite: copy(
        "Labor, programming, and rack finish are often described as 30–55% of a residential ticket. That percentage is not applied to a hotel, and not to a house with no budget.",
        "人工、编程和机柜收边在住宅票价里常见占 30%–55%。这个比例不用于酒店，也不用于还没预算的住宅。",
      ),
      questions: QUESTIONS,
      disclaimer: input.hospitality
        ? copy(
          "The published house bands are not a guest-room price. Do not multiply a villa range by the number of keys.",
          "已公开的住宅区间不是客房单价。不要用别墅带宽乘以房间数。",
        )
        : copy(
          "No budget was stated, so there is no dollar band. The ten questions below are still the right ones to ask.",
          "没有填写预算，所以没有金额带宽。下面十个问题仍然该问。",
        ),
      sources: [
        { label: "homeautomation.us.com luxury planning", url: "https://homeautomation.us.com/planning/luxury-smart-home/", tier: "E3" },
      ],
    };
  }
  const estateBand = brand === "Crestron" && input.sqft === "over8000" && tier === "Best";
  const base = BASE[brand];
  const factor = SQFT[input.sqft] * TIER[tier] * STAGE[input.stage];
  const totalLow = estateBand ? 300_000 : round1k(base.low * factor);
  const totalHigh = estateBand ? 500_000 : round1k(base.high * factor);
  const midSum = BUCKETS.reduce((sum, bucket) => sum + bucket.mid, 0);
  const hours = expectedProgrammingHours(input, tier);
  const buckets: CostBucket[] = BUCKETS.map((bucket) => ({
    id: bucket.id,
    label: bucket.label,
    lowPct: bucket.lowPct,
    highPct: bucket.highPct,
    dollarLow: round1k(totalLow * bucket.lowPct),
    dollarHigh: round1k(totalHigh * bucket.highPct),
    barShare: bucket.mid / midSum,
  }));

  return {
    totalLow,
    totalHigh,
    estateBand,
    amountsWithheld: false,
    buckets,
    programmingShare: copy(
      "Programming and commissioning are often described as 15–25% of the project, at about $100–$250 per hour. Whole-home work is often described as 80–200 hours before this house's size adjustment. Ask for the included hours.",
      "编程与调试在公开口径里常见为项目的 15%–25%，工时费常见每小时 100–250 美元。整屋在按面积修正前，常见说法是 80–200 小时。一定问清包含多少小时。",
    ),
    programmingHoursLow: hours.low,
    programmingHoursHigh: hours.high,
    hourlyRateLow: 100,
    hourlyRateHigh: 250,
    laborComposite: copy(
      "Labor, programming, and rack finish-out together are often described as 30–55% of the ticket. That is a trade-press magnitude, not a national average.",
      "人工、编程和机柜收边合计，公开口径常见占总价 30%–55%。这是媒体量级，不是全国官方均值。",
    ),
    questions: QUESTIONS,
    disclaimer: estateBand
      ? copy(
        "This estate band ($300k–$500k+) is the published custom Crestron / SIMPL / large-matrix magnitude, not a quote. " + BUDGET_DISCLAIMER.en,
        "这个庄园区间（30 万至 50 万美元以上）是公开材料里的 Crestron 定制 / SIMPL / 大型矩阵量级，不是报价。" + BUDGET_DISCLAIMER.zh,
      )
      : BUDGET_DISCLAIMER,
    sources: [
      { label: "homeautomation.us.com luxury planning", url: "https://homeautomation.us.com/planning/luxury-smart-home/", tier: "E3" },
      { label: "CE Pro on CEDIA 2026", url: "https://www.cepro.com/news/cedia-research-pegs-u-s-residential-tech-market-at-33-8-billion-with-ai-and-skilled-labor-defining-the-year-ahead/628665/", tier: "E2" },
      { label: "Crestron cost article, South Florida", url: "https://www.geeksfl.com/blog/crestron-smart-home-cost-south-florida/", tier: "E3" },
    ],
  };
}

const QUESTIONS: Copy[] = [
  copy("How many programming hours are included?", "包含多少编程小时？"),
  copy("What is the change-order rate after those hours are used?", "小时用完之后，变更单的单价是多少？"),
  copy("Are the rack, UPS, and network switch their own lines?", "机柜、UPS 和网络交换机是否单独列项？"),
  copy("Is Connect, Essentials, or Assist mandatory, and who sends the bill?", "Connect、Essentials 或 Assist 是否强制，账单谁来出？"),
  copy("What does year-two service include that year-one warranty does not?", "第二年服务比第一年质保多了什么？"),
  copy("Which project files, passwords, and admin accounts transfer at the final payment?", "尾款时移交哪些工程文件、密码和管理员账号？"),
  copy("If this is Crestron, is it Crestron Home or SIMPL, and does the uncompiled source transfer?", "如果是 Crestron，这是 Crestron Home 还是 SIMPL？未编译源码交不交？"),
  copy("If this is Control4, will OvrC ownership move to the household and will a customer.control4.com login be created?", "如果是 Control4，OvrC 归属会转到业主名下吗？会建立 customer.control4.com 登录吗？"),
  copy("Are travel, lifts, and drywall patching included or extra?", "差旅、升降设备和墙面修补是包含还是另计？"),
  copy("What is excluded, including line-voltage electrical, finishes, and the internet service?", "哪些不包括？例如市电、饰面和宽带服务。"),
];
