import type { Copy, Intake, PackageTier, QuoteComparison, QuoteInput, QuoteWarning } from "./types.ts";
import { expectedProgrammingHours } from "./budget-calculator.ts";

const copy = (en: string, zh: string): Copy => ({ en, zh });

export function quoteTotal(quote: QuoteInput): number {
  return quote.hardware + quote.prewire + quote.labor + quote.programmingCost + quote.rackNetwork;
}

export function compareQuotes(quotes: QuoteInput[], intake: Intake, tier: PackageTier): QuoteComparison {
  const expected = expectedProgrammingHours(intake, tier);
  const columns = quotes.map((quote) => ({
    id: quote.id,
    dealerName: quote.dealerName,
    isSample: quote.isSample,
    total: quoteTotal(quote),
    warnings: warningsFor(quote, expected.low),
  }));
  const portfolioNotes: Copy[] = [];
  if (columns.length >= 2) {
    const sorted = [...columns].sort((a, b) => a.total - b.total);
    const lowest = sorted[0];
    const next = sorted[1];
    const lowestQuote = quotes.find((quote) => quote.id === lowest.id);
    if (lowestQuote && next.total > 0 && lowestQuote.programmingHours < expected.low) {
      const gap = Math.round((1 - lowest.total / next.total) * 100);
      portfolioNotes.push(copy(
        `${lowest.dealerName} is about ${gap}% under the next total, but lists ${lowestQuote.programmingHours} programming hours. This house's reference band is ${expected.low}–${expected.high} hours. A low hour count is a common source of later change orders.`,
        `${lowest.dealerName} 的总价大约比下一家低 ${gap}%，但编程只列了 ${lowestQuote.programmingHours} 小时。这座房子的参考带宽是 ${expected.low}–${expected.high} 小时。工时偏低，是后期变更单的常见来源。`,
      ));
    }
  }
  if (quotes.some((quote) => quote.isSample)) {
    portfolioNotes.push(copy(
      "Rows marked Sample are illustrations of the alignment rules. They are not bids from any integrator.",
      "标成“示例”的行只用来演示对齐规则，不是任何集成商的报价。",
    ));
  }
  return { columns, portfolioNotes, expectedHoursLow: expected.low, expectedHoursHigh: expected.high };
}

function warningsFor(quote: QuoteInput, hourFloor: number): QuoteWarning[] {
  const warnings: QuoteWarning[] = [];
  if (quote.programmingHours < hourFloor * 0.7) {
    warnings.push({
      code: "LOW_PROGRAMMING_HOURS",
      severity: "high",
      message: copy(
        `${quote.programmingHours} programming hours sit under this house's reference floor of about ${hourFloor} hours.`,
        `编程 ${quote.programmingHours} 小时，低于这座房子大约 ${hourFloor} 小时的参考下限。`,
      ),
    });
  }
  if (quote.hourlyRate < 100 || quote.hourlyRate > 250) {
    warnings.push({
      code: "RATE_OUTSIDE_BAND",
      severity: "medium",
      message: copy(
        `The hourly rate is outside the published $100–$250 example band. Ask what the rate includes.`,
        `小时单价落在公开举例的 100–250 美元之外。问清这个单价包含什么。`,
      ),
    });
  }
  if (!quote.handoverAccepted) {
    warnings.push({
      code: "HANDOVER_DECLINED",
      severity: "high",
      message: copy(
        "This bid does not accept the handover clauses. Do not treat it as ready to sign.",
        "这份报价没有接受移交条款。不要把它当成可以签约的版本。",
      ),
    });
  }
  if (quote.subscriptionMandatory) {
    warnings.push({
      code: "SUBSCRIPTION_MANDATORY",
      severity: "medium",
      message: copy(
        "A remote subscription is marked mandatory. Ask who bills it in year two, and whether the house works without it.",
        "远程订阅被标成强制。问清第二年谁收费，以及没有订阅时房子还能控制什么。",
      ),
    });
  }
  if (quote.warrantyMonths < 12) {
    warnings.push({
      code: "SHORT_WARRANTY",
      severity: "medium",
      message: copy(
        "Warranty is under 12 months. Ask when the clock starts: shipment, power-on, or training day.",
        "质保短于 12 个月。问清从发货、上电还是培训日开始计算。",
      ),
    });
  }
  return warnings;
}
