import Foundation

public enum BudgetEngine {
    private static let base: [ControlBrand: (Int, Int)] = [
        .control4: (50_000, 120_000),
        .savant: (70_000, 160_000),
        .crestron: (80_000, 180_000),
    ]
    private static let sqft: [SqftBand: Double] = [
        .under3000: 0.55, .ft3000to5000: 0.72, .ft5000to8000: 1, .over8000: 1.35,
    ]
    private static let tierFactor: [PackageTier: Double] = [.good: 0.78, .better: 1, .best: 1.32]
    private static let stageFactor: [BuildStage: Double] = [
        .newBuildPreDrywall: 1, .majorRenovation: 0.96, .retrofitExisting: 0.84, .inheritedHome: 0.78,
    ]
    private static let hours: [SqftBand: (Int, Int)] = [
        .under3000: (24, 60), .ft3000to5000: (48, 90), .ft5000to8000: (80, 140), .over8000: (120, 200),
    ]

    public static let questions: [Copy] = [
        Copy(en: "How many programming hours are included?", zh: "包含多少编程小时？"),
        Copy(en: "What is the change-order rate after those hours are used?", zh: "小时用完之后，变更单的单价是多少？"),
        Copy(en: "Are the rack, UPS, and network switch their own lines?", zh: "机柜、UPS 和网络交换机是否单独列项？"),
        Copy(en: "Is Connect, Essentials, or Assist mandatory, and who sends the bill?", zh: "Connect、Essentials 或 Assist 是否强制，账单谁来出？"),
        Copy(en: "What does year-two service include that year-one warranty does not?", zh: "第二年服务比第一年质保多了什么？"),
        Copy(en: "Which project files, passwords, and admin accounts transfer at the final payment?", zh: "尾款时移交哪些工程文件、密码和管理员账号？"),
        Copy(en: "If this is Crestron, is it Crestron Home or SIMPL, and does the uncompiled source transfer?", zh: "如果是 Crestron，这是 Crestron Home 还是 SIMPL？未编译源码交不交？"),
        Copy(en: "If this is Control4, will OvrC ownership move to the household and will a customer.control4.com login be created?", zh: "如果是 Control4，OvrC 归属会转到业主名下吗？会建立 customer.control4.com 登录吗？"),
        Copy(en: "Are travel, lifts, and drywall patching included or extra?", zh: "差旅、升降设备和墙面修补是包含还是另计？"),
        Copy(en: "What is excluded, including line-voltage electrical, finishes, and the internet service?", zh: "哪些不包括？例如市电、饰面和宽带服务。"),
    ]

    public static func expectedProgrammingHours(_ input: Intake, tier: PackageTier) -> (low: Int, high: Int) {
        let base = hours[input.sqft] ?? (80, 140)
        let mul = tier == .good ? 0.75 : tier == .best ? 1.3 : 1
        return (Int((Double(base.0) * mul).rounded()), Int((Double(base.1) * mul).rounded()))
    }

    public static func calculate(_ input: Intake, tier: PackageTier, brand: ControlBrand) -> BudgetReport {
        if input.hospitality || input.budget == .unstated {
            return BudgetReport(
                totalLow: 0,
                totalHigh: 0,
                estateBand: false,
                amountsWithheld: true,
                buckets: [],
                programmingShare: Copy(en: "Programming is often described as 15–25% and about $100–$250 per hour when a residential project has a stated band. No dollars are shown until that band exists.", zh: "住宅项目在已选择预算档时，编程常见为 15%–25%，工时费常见每小时 100–250 美元。没有预算档之前，不显示金额。"),
                programmingHoursLow: 0,
                programmingHoursHigh: 0,
                hourlyRateLow: 100,
                hourlyRateHigh: 250,
                laborComposite: Copy(en: "Labor, programming, and rack finish are often described as 30–55% of a residential ticket. That percentage is not applied to a hotel, and not to a house with no budget.", zh: "人工、编程和机柜收边在住宅票价里常见占 30%–55%。这个比例不用于酒店，也不用于还没预算的住宅。"),
                questions: questions,
                disclaimer: input.hospitality
                    ? Copy(en: "The published house bands are not a guest-room price. Do not multiply a villa range by the number of keys.", zh: "已公开的住宅区间不是客房单价。不要用别墅带宽乘以房间数。")
                    : Copy(en: "No budget was stated, so there is no dollar band. The ten questions below are still the right ones to ask.", zh: "没有填写预算，所以没有金额带宽。下面十个问题仍然该问。"),
                sources: [BudgetSource(label: "homeautomation.us.com luxury planning", url: "https://homeautomation.us.com/planning/luxury-smart-home/", tier: "E3")]
            )
        }
        let estateBand = brand == .crestron && input.sqft == .over8000 && tier == .best
        let band = base[brand] ?? (50_000, 120_000)
        let factor = (sqft[input.sqft] ?? 1) * (tierFactor[tier] ?? 1) * (stageFactor[input.stage] ?? 1)
        let totalLow = estateBand ? 300_000 : round1k(Double(band.0) * factor)
        let totalHigh = estateBand ? 500_000 : round1k(Double(band.1) * factor)
        let specs: [(String, Copy, Double, Double, Double)] = [
            ("prewire", Copy(en: "Structured wiring and low-voltage infrastructure", zh: "结构化布线与弱电基础设施"), 0.15, 0.20, 0.175),
            ("lighting", Copy(en: "Lighting control and shades", zh: "照明控制与电动遮阳"), 0.20, 0.25, 0.225),
            ("av", Copy(en: "Distributed audio and theater", zh: "分布式音频与家庭影院"), 0.20, 0.30, 0.25),
            ("control", Copy(en: "Control hardware and programming", zh: "控制平台硬件与编程调试"), 0.15, 0.20, 0.175),
            ("aux", Copy(en: "Security, network, HVAC, and pool", zh: "安防、网络、暖通与泳池"), 0.10, 0.20, 0.15),
        ]
        let midSum = specs.reduce(0.0) { $0 + $1.4 }
        let hourBand = expectedProgrammingHours(input, tier: tier)
        let buckets = specs.map { spec in
            CostBucket(
                id: spec.0,
                label: spec.1,
                lowPct: spec.2,
                highPct: spec.3,
                dollarLow: round1k(Double(totalLow) * spec.2),
                dollarHigh: round1k(Double(totalHigh) * spec.3),
                barShare: spec.4 / midSum
            )
        }
        let disclaimer = estateBand
            ? Copy(
                en: "This estate band ($300k–$500k+) is the published custom Crestron / SIMPL / large-matrix magnitude, not a quote. " + EvidenceCopy.budgetDisclaimer.en,
                zh: "这个庄园区间（30 万至 50 万美元以上）是公开材料里的 Crestron 定制 / SIMPL / 大型矩阵量级，不是报价。" + EvidenceCopy.budgetDisclaimer.zh
            )
            : EvidenceCopy.budgetDisclaimer
        return BudgetReport(
            totalLow: totalLow,
            totalHigh: totalHigh,
            estateBand: estateBand,
            amountsWithheld: false,
            buckets: buckets,
            programmingShare: Copy(
                en: "Programming and commissioning are often described as 15–25% of the project, at about $100–$250 per hour. Whole-home work is often described as 80–200 hours before this house's size adjustment. Ask for the included hours.",
                zh: "编程与调试在公开口径里常见为项目的 15%–25%，工时费常见每小时 100–250 美元。整屋在按面积修正前，常见说法是 80–200 小时。一定问清包含多少小时。"
            ),
            programmingHoursLow: hourBand.low,
            programmingHoursHigh: hourBand.high,
            hourlyRateLow: 100,
            hourlyRateHigh: 250,
            laborComposite: Copy(
                en: "Labor, programming, and rack finish-out together are often described as 30–55% of the ticket. That is a trade-press magnitude, not a national average.",
                zh: "人工、编程和机柜收边合计，公开口径常见占总价 30%–55%。这是媒体量级，不是全国官方均值。"
            ),
            questions: questions,
            disclaimer: disclaimer,
            sources: [
                BudgetSource(label: "homeautomation.us.com luxury planning", url: "https://homeautomation.us.com/planning/luxury-smart-home/", tier: "E3"),
                BudgetSource(label: "CE Pro on CEDIA 2026", url: "https://www.cepro.com/news/cedia-research-pegs-u-s-residential-tech-market-at-33-8-billion-with-ai-and-skilled-labor-defining-the-year-ahead/628665/", tier: "E2"),
                BudgetSource(label: "Crestron cost article, South Florida", url: "https://www.geeksfl.com/blog/crestron-smart-home-cost-south-florida/", tier: "E3"),
            ]
        )
    }

    private static func round1k(_ value: Double) -> Int {
        Int((value / 1000).rounded()) * 1000
    }
}
