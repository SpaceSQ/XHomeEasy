import Foundation

public enum QuoteComparator {
    public static func total(_ quote: QuoteInput) -> Double {
        quote.hardware + quote.prewire + quote.labor + quote.programmingCost + quote.rackNetwork
    }

    public static func compare(_ quotes: [QuoteInput], intake: Intake, tier: PackageTier) -> QuoteComparison {
        let expected = BudgetEngine.expectedProgrammingHours(intake, tier: tier)
        let columns = quotes.map { quote in
            QuoteColumn(
                id: quote.id,
                dealerName: quote.dealerName,
                isSample: quote.isSample,
                total: total(quote),
                warnings: warnings(quote, hourFloor: expected.low)
            )
        }
        var notes: [Copy] = []
        if columns.count >= 2 {
            let sorted = columns.sorted { $0.total < $1.total }
            let lowest = sorted[0]
            let next = sorted[1]
            if let quote = quotes.first(where: { $0.id == lowest.id }), next.total > 0, quote.programmingHours < Double(expected.low) {
                let gap = Int((1 - lowest.total / next.total) * 100)
                notes.append(Copy(
                    en: "\(lowest.dealerName) is about \(gap)% under the next total, but lists \(Int(quote.programmingHours)) programming hours. This house's reference band is \(expected.low)–\(expected.high) hours. A low hour count is a common source of later change orders.",
                    zh: "\(lowest.dealerName) 的总价大约比下一家低 \(gap)%，但编程只列了 \(Int(quote.programmingHours)) 小时。这座房子的参考带宽是 \(expected.low)–\(expected.high) 小时。工时偏低，是后期变更单的常见来源。"
                ))
            }
        }
        if quotes.contains(where: \.isSample) {
            notes.append(Copy(
                en: "Rows marked Sample are illustrations of the alignment rules. They are not bids from any integrator.",
                zh: "标成“示例”的行只用来演示对齐规则，不是任何集成商的报价。"
            ))
        }
        return QuoteComparison(columns: columns, portfolioNotes: notes, expectedHoursLow: expected.low, expectedHoursHigh: expected.high)
    }

    private static func warnings(_ quote: QuoteInput, hourFloor: Int) -> [QuoteWarning] {
        var warnings: [QuoteWarning] = []
        if quote.programmingHours < Double(hourFloor) * 0.7 {
            warnings.append(QuoteWarning(
                code: "LOW_PROGRAMMING_HOURS",
                severity: "high",
                message: Copy(
                    en: "\(Int(quote.programmingHours)) programming hours sit under this house's reference floor of about \(hourFloor) hours.",
                    zh: "编程 \(Int(quote.programmingHours)) 小时，低于这座房子大约 \(hourFloor) 小时的参考下限。"
                )
            ))
        }
        if quote.hourlyRate < 100 || quote.hourlyRate > 250 {
            warnings.append(QuoteWarning(
                code: "RATE_OUTSIDE_BAND",
                severity: "medium",
                message: Copy(en: "The hourly rate is outside the published $100–$250 example band. Ask what the rate includes.", zh: "小时单价落在公开举例的 100–250 美元之外。问清这个单价包含什么。")
            ))
        }
        if !quote.handoverAccepted {
            warnings.append(QuoteWarning(
                code: "HANDOVER_DECLINED",
                severity: "high",
                message: Copy(en: "This bid does not accept the handover clauses. Do not treat it as ready to sign.", zh: "这份报价没有接受移交条款。不要把它当成可以签约的版本。")
            ))
        }
        if quote.subscriptionMandatory {
            warnings.append(QuoteWarning(
                code: "SUBSCRIPTION_MANDATORY",
                severity: "medium",
                message: Copy(en: "A remote subscription is marked mandatory. Ask who bills it in year two, and whether the house works without it.", zh: "远程订阅被标成强制。问清第二年谁收费，以及没有订阅时房子还能控制什么。")
            ))
        }
        if quote.warrantyMonths < 12 {
            warnings.append(QuoteWarning(
                code: "SHORT_WARRANTY",
                severity: "medium",
                message: Copy(en: "Warranty is under 12 months. Ask when the clock starts: shipment, power-on, or training day.", zh: "质保短于 12 个月。问清从发货、上电还是培训日开始计算。")
            ))
        }
        return warnings
    }
}
