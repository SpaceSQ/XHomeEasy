import type { Copy } from "./types.ts";

export const WIRELESS_BOUNDARY: Copy = {
  en: "This app advises on wired systems led by Control4, Crestron, Savant, and Lutron. Wireless smart-home products are outside the advice this app gives.",
  zh: "本 APP 重点提供以 Control4、Crestron、Savant、Lutron 四大品牌为主的有线智能家居方案建议与辅助决策，无线智能家居不在本 APP 建议范围内",
};

export const LINE_VOLTAGE_BOUNDARY: Copy = {
  en: "Topology planning only. A licensed electrician has to do the work.",
  zh: "仅限拓扑规划，须由持证电工施工",
};

export const RADAR_PRICE_DISCLAIMER: Copy = {
  en: "Ranges come from integrator and trade-press figures checked on 2026-10-21, not a manufacturer MSRP. A licensed local integrator's site survey sets the price.",
  zh: "数据源自服务商/媒体公开口径（2026-10-21 核实），非厂商官方 MSRP，最终以本地持证集成商现场勘测报价为准",
};

export interface RadarSource {
  url: string;
  note: string;
  fetchedOn: string;
}

export interface RadarRecord {
  id: string;
  kind: "wired" | "wireless";
  section: string;
  brandOrProtocolName: string;
  triggerKeywords: string[];
  operatingCompany: string;
  foundedYearAndStatus: string;
  statusEnum: string;
  protocolCharacteristics: string;
  pros: string[];
  cons: string[];
  mainProducts: string[];
  applicationAreas: string[];
  priceRangeAndModel: string;
  actionAdvice: string;
  fourGiantBridge: string;
  redirectTargets: string[];
  redirectScript: string;
  evidenceTier: "E1" | "E2" | "E3" | "E4";
  sources: RadarSource[];
  lineVoltageBoundary: boolean;
}

export interface RadarIndex {
  keywords: Record<string, string[]>;
}

export interface RadarHit {
  id: string;
  keyword: string;
  index: number;
  record: RadarRecord;
}

const expressionCache = new Map<string, RegExp | null>();

export function foldRadarText(value: string): string {
  return value.normalize("NFKD").replace(/\p{M}/gu, "").toLowerCase();
}

export function lineVoltageFromNames(name: string, keywords: readonly string[]): boolean {
  const blob = foldRadarText(`${name} ${keywords.join(" ")}`);
  if (/(?<![a-z0-9])span(?![a-z0-9])|span\.io/.test(blob)) return true;
  if (/leviton/.test(blob) && /load center/.test(blob)) return true;
  return /electrical panel|smart panel|load center|transfer switch|配电箱|配电盘/.test(blob);
}

export function requiresLicensedElectrician(record: RadarRecord): boolean {
  return record.lineVoltageBoundary || lineVoltageFromNames(record.brandOrProtocolName, record.triggerKeywords);
}

function piecesOf(keyword: string): string[] {
  return foldRadarText(keyword).split(/[^a-z0-9]+/).filter(Boolean).flatMap((token) => {
    const parts = token.match(/[a-z]+|[0-9]+/g);
    return parts ?? [];
  });
}

function expressionFor(keyword: string): RegExp | null {
  const key = foldRadarText(keyword);
  if (expressionCache.has(key)) return expressionCache.get(key) ?? null;
  const pieces = piecesOf(key);
  if (pieces.length === 0 || key.length < 2) {
    expressionCache.set(key, null);
    return null;
  }
  const body = pieces.map((piece) => piece.replace(/[.*+?^${}()|[\]\\]/g, "\\$&")).join("[-_.&@+/\\s]*");
  const expression = new RegExp(`(?<![a-z0-9])${body}(?![a-z0-9])`, "u");
  expressionCache.set(key, expression);
  return expression;
}

export function scanRadar(text: string, index: RadarIndex, records: readonly RadarRecord[]): RadarHit[] {
  const haystack = foldRadarText(text);
  if (haystack.trim().length < 2) return [];
  const byID = new Map(records.map((record) => [record.id, record]));
  const found = new Map<string, RadarHit>();
  const keywords = Object.keys(index.keywords).sort((left, right) => right.length - left.length);
  for (const keyword of keywords) {
    const expression = expressionFor(keyword);
    const match = expression?.exec(haystack);
    if (!match || match.index === undefined) continue;
    for (const id of index.keywords[keyword] ?? []) {
      const record = byID.get(id);
      if (!record) continue;
      const previous = found.get(id);
      if (
        !previous
        || match.index < previous.index
        || (match.index === previous.index && keyword.length > previous.keyword.length)
      ) {
        found.set(id, { id, keyword, index: match.index, record });
      }
    }
  }
  return [...found.values()].sort((left, right) => left.index - right.index || left.id.localeCompare(right.id));
}
