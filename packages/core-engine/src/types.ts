export type SqftBand = "under3000" | "ft3000to5000" | "ft5000to8000" | "over8000";
export type BuildStage = "new_build_pre_drywall" | "major_renovation" | "retrofit_existing" | "inherited_home";
export type BudgetBand = "under25k" | "k25to75" | "k75to150" | "k150plus" | "unstated";
export type KeypadSpec = "open" | "basalte";
export type LegacySystem = "none" | "appleHome" | "matter" | "control4" | "crestron" | "savant" | "lutron";
export type PathKind = "wired" | "matter" | "hybrid";
export type Light = "proceed" | "consider" | "defer";
export type PackageTier = "Good" | "Better" | "Best";
export type ControlBrand = "Control4" | "Crestron" | "Savant";

export interface Copy {
  en: string;
  zh: string;
}

export interface Intake {
  sqft: SqftBand;
  stage: BuildStage;
  rackRoom: boolean;
  budget: BudgetBand;
  cinema: boolean;
  multiRoomAudio: boolean;
  shades: boolean;
  pool: boolean;
  hvacZones: boolean;
  legacy: LegacySystem;
  children?: boolean;
  pets?: boolean;
  largeGarden?: boolean;
  elderCare?: boolean;
  simpleAlarmOnly?: boolean;
  multiBuilding?: boolean;
  outdoorLiving?: boolean;
  hospitality?: boolean;
  energyPriority?: boolean;
  keypad?: KeypadSpec;
  drywallUnconfirmed?: boolean;
}

export interface PathScore {
  kind: PathKind;
  score: number;
  light: Light;
  reasons: Copy[];
}

export interface AdaptationResult {
  paths: PathScore[];
  primary: PathKind;
  prewireWindow: boolean;
  retailGuardrail: boolean;
  residentialModelApplies: boolean;
  scopeNote: Copy | null;
  briefNotes: Copy[];
  disclaimer: Copy;
  redLines: Copy[];
}

export interface LayerCard {
  name: Copy;
  detail: Copy;
  tier: "E1" | "E2";
  url: string;
}

export interface TopologyPlan {
  packageTier: PackageTier;
  lightingBase: string;
  controlBrand: ControlBrand;
  voiceLayer: string | null;
  layers: LayerCard[];
  subsystemCategories: string[];
  fusionHint: Copy;
  prewireWindow: boolean;
  specificationWithheld: boolean;
}

export interface CostBucket {
  id: string;
  label: Copy;
  lowPct: number;
  highPct: number;
  dollarLow: number;
  dollarHigh: number;
  barShare: number;
}

export interface BudgetReport {
  totalLow: number;
  totalHigh: number;
  estateBand: boolean;
  amountsWithheld: boolean;
  buckets: CostBucket[];
  programmingShare: Copy;
  programmingHoursLow: number;
  programmingHoursHigh: number;
  hourlyRateLow: number;
  hourlyRateHigh: number;
  laborComposite: Copy;
  questions: Copy[];
  disclaimer: Copy;
  sources: { label: string; url: string; tier: "E2" | "E3" }[];
}

export interface QuoteInput {
  id: string;
  dealerName: string;
  isSample: boolean;
  controlBrand: string;
  lightingBrand: string;
  hardware: number;
  prewire: number;
  labor: number;
  programmingCost: number;
  programmingHours: number;
  hourlyRate: number;
  rackNetwork: number;
  annualSubscription: number;
  subscriptionMandatory: boolean;
  handoverAccepted: boolean;
  warrantyMonths: number;
}

export interface QuoteWarning {
  code: string;
  severity: "high" | "medium";
  message: Copy;
}

export interface QuoteColumn {
  id: string;
  dealerName: string;
  isSample: boolean;
  total: number;
  warnings: QuoteWarning[];
}

export interface QuoteComparison {
  columns: QuoteColumn[];
  portfolioNotes: Copy[];
  expectedHoursLow: number;
  expectedHoursHigh: number;
}

export interface HandoverItem {
  id: string;
  brand: "Control4" | "Crestron" | "Savant" | "Lutron";
  text: Copy;
  tier: "E1" | "E2";
  sourceName: string;
  url: string;
}

export interface AdvisorDocument {
  id: string;
  title: string;
  text: string;
  tier: string;
  url: string;
}

export interface AdvisorReply {
  refused: boolean;
  unknown: boolean;
  text: Copy;
  citations: { id: string; title: string; tier: string; url: string }[];
}

export const VERIFIED_ON = "2026-10-21";

export const BUDGET_DISCLAIMER: Copy = {
  en: "Bands come from trade press and integrator articles reviewed on 2026-10-21. They are not a manufacturer MSRP. A licensed integrator's site quote controls.",
  zh: "区间来自 2026-10-21 复核过的行业媒体与服务商公开口径，不是厂商官方标价。最终以持证集成商现场勘测报价为准。",
};

export const HEURISTIC_DISCLAIMER: Copy = {
  en: "This score is a heuristic based on CEDIA category patterns. It is not a manufacturer certification.",
  zh: "本评分是依据 CEDIA 品类结构整理的启发式模型，不是厂商官方认证。",
};

export const RED_LINES: Copy[] = [
  {
    en: "This app does not give step-by-step instructions for line-voltage wiring, panel changes, or opening electrical equipment.",
    zh: "本 App 不提供市电接线、配电箱改动或打开电气设备的分步做法。",
  },
  {
    en: "Line-voltage work belongs to a locally licensed electrician. Low-voltage work still follows local rules and the manufacturer, and is done by a qualified integrator.",
    zh: "市电作业属于当地持证电工。低电压工作也要遵守地方法规和制造商说明，由合格集成商完成。",
  },
  {
    en: "Composer Pro, Configure Pro, and Savant dealer tools stay on the dealer. This app does not describe bypasses.",
    zh: "Composer Pro、Configure Pro 与 Savant 经销商工具只属于授权经销商。本 App 不说明任何绕过方式。",
  },
];
