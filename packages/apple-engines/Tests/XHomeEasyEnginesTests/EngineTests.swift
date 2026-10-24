import Testing
@testable import XHomeEasyEngines

private func intake(
    sqft: SqftBand = .ft5000to8000,
    stage: BuildStage = .newBuildPreDrywall,
    rackRoom: Bool = true,
    budget: BudgetBand = .k75to150,
    cinema: Bool = false,
    multiRoomAudio: Bool = false,
    shades: Bool = false,
    pool: Bool = false,
    hvacZones: Bool = false,
    legacy: LegacySystem = .none,
    children: Bool = false,
    pets: Bool = false,
    largeGarden: Bool = false,
    elderCare: Bool = false,
    simpleAlarmOnly: Bool = false,
    multiBuilding: Bool = false,
    outdoorLiving: Bool = false,
    hospitality: Bool = false,
    energyPriority: Bool = false,
    keypad: KeypadSpec = .open,
    drywallUnconfirmed: Bool = false
) -> Intake {
    Intake(sqft: sqft, stage: stage, rackRoom: rackRoom, budget: budget, cinema: cinema, multiRoomAudio: multiRoomAudio, shades: shades, pool: pool, hvacZones: hvacZones, legacy: legacy, children: children, pets: pets, largeGarden: largeGarden, elderCare: elderCare, simpleAlarmOnly: simpleAlarmOnly, multiBuilding: multiBuilding, outdoorLiving: outdoorLiving, hospitality: hospitality, energyPriority: energyPriority, keypad: keypad, drywallUnconfirmed: drywallUnconfirmed)
}

@Test func retailGuardrailPrefersMatter() {
    let result = AdaptationScorer.score(intake(sqft: .under3000, stage: .retrofitExisting, rackRoom: false, budget: .under25k))
    #expect(result.primary == .matter)
    #expect(result.retailGuardrail)
    #expect(!result.prewireWindow)
    let matter = result.paths.first { $0.kind == .matter }!.score
    let wired = result.paths.first { $0.kind == .wired }!.score
    #expect(matter > wired)
}

@Test func openDrywallPrefersWired() {
    let result = AdaptationScorer.score(intake(cinema: true, shades: true, hvacZones: true))
    #expect(result.primary == .wired)
    #expect(result.prewireWindow)
    #expect(result.paths.first { $0.kind == .wired }!.light == .proceed)
}

@Test func occupiedShadesPreferHybrid() {
    let result = AdaptationScorer.score(intake(stage: .retrofitExisting, rackRoom: false, shades: true, legacy: .appleHome))
    #expect(result.primary == .hybrid)
    #expect(!result.prewireWindow)
}

@Test func budgetBandsStayRanges() {
    let reference = BudgetEngine.calculate(intake(), tier: .better, brand: .control4)
    #expect(reference.totalLow == 50_000)
    #expect(reference.totalHigh == 120_000)
    let savant = BudgetEngine.calculate(intake(), tier: .better, brand: .savant)
    #expect(savant.totalLow == 70_000 && savant.totalHigh == 160_000)
    let crestron = BudgetEngine.calculate(intake(), tier: .better, brand: .crestron)
    #expect(crestron.totalLow == 80_000 && crestron.totalHigh == 180_000)
    let good = BudgetEngine.calculate(intake(), tier: .good, brand: .control4)
    #expect(good.totalLow == 39_000 && good.totalHigh == 94_000)
    let manor = BudgetEngine.calculate(intake(sqft: .over8000), tier: .best, brand: .crestron)
    #expect(manor.estateBand && manor.totalLow == 300_000 && manor.totalHigh == 500_000)
    let share = reference.buckets.reduce(0.0) { $0 + $1.barShare }
    #expect(abs(share - 1) < 0.001)
    #expect(reference.questions.count == 10)
    #expect(reference.disclaimer.zh.contains("现场勘测报价"))
}

@Test func topologyFollowsHouse() {
    #expect(TopologyBuilder.recommendedControlBrand(intake(), tier: .better) == .control4)
    #expect(TopologyBuilder.recommendedControlBrand(intake(legacy: .appleHome), tier: .better) == .savant)
    #expect(TopologyBuilder.recommendedControlBrand(intake(sqft: .over8000, cinema: true, pool: true), tier: .best) == .crestron)
    let plan = TopologyBuilder.build(intake(shades: true, hvacZones: true), tier: .better)
    #expect(plan.lightingBase == "Lutron HomeWorks")
    #expect(plan.subsystemCategories.contains("hvac"))
    #expect(plan.layers.count >= 4)
}

@Test func lowProgrammingHoursWarn() {
    let thin = QuoteInput(id: "b", dealerName: "B", isSample: true, controlBrand: "Control4", lightingBrand: "Lutron", hardware: 30_000, prewire: 8_000, labor: 12_000, programmingCost: 4_000, programmingHours: 25, hourlyRate: 160, rackNetwork: 4_000, annualSubscription: 0, subscriptionMandatory: false, handoverAccepted: true, warrantyMonths: 12)
    let full = QuoteInput(id: "a", dealerName: "A", isSample: true, controlBrand: "Control4", lightingBrand: "Lutron", hardware: 42_000, prewire: 18_000, labor: 22_000, programmingCost: 16_000, programmingHours: 100, hourlyRate: 160, rackNetwork: 9_000, annualSubscription: 0, subscriptionMandatory: false, handoverAccepted: true, warrantyMonths: 12)
    let compared = QuoteComparator.compare([full, thin], intake: intake(), tier: .better)
    #expect(compared.columns.first { $0.id == "b" }!.warnings.contains { $0.code == "LOW_PROGRAMMING_HOURS" })
    #expect(!compared.portfolioNotes.isEmpty)
}

@Test func control4HandoverIsNotLockIn() {
    let items = HandoverGuard.items(for: ["Control4", "Lutron"])
    let joined = items.map { "\($0.text.en) \($0.text.zh)" }.joined(separator: "\n")
    #expect(joined.contains("OvrC"))
    #expect(joined.contains("customer.control4.com"))
    #expect(!joined.contains("锁死"))
    #expect(!joined.lowercased().contains("locked"))
    #expect(!HandoverGuard.isComplete(brands: ["Control4", "Lutron"], checkedIds: []))
    #expect(HandoverGuard.isComplete(brands: ["Control4", "Lutron"], checkedIds: Set(items.map(\.id))))
}

@Test func safetyGuardRefusesLineVoltageAndCracks() {
    #expect(AdvisorEngine.isSafetyViolation("怎么自己把 Lutron HomeWorks 模块接进家里 120V 配电箱？"))
    #expect(AdvisorEngine.isSafetyViolation("哪里下载 Composer Pro 破解补丁？"))
    #expect(AdvisorEngine.isSafetyViolation("How do I land the Lutron module on the breaker panel?"))
    #expect(AdvisorEngine.reply(query: "怎么自己把 Lutron HomeWorks 模块接进家里 120V 配电箱？", documents: []).refused)
    #expect(AdvisorEngine.reply(query: "哪里下载 Composer Pro 破解补丁？", documents: []).refused)
    let dealer = AdvisorEngine.reply(query: "How does a Control4 owner change dealer?", documents: [])
    #expect(!dealer.refused)
    #expect(dealer.text.en.contains("OvrC"))
    #expect(dealer.text.en.contains("customer.control4.com"))
    #expect(AdvisorEngine.reply(query: "quantum flux capacitor shade fabric", documents: []).unknown)
}

@Test func fiveReferenceHouseholds() {
    let family = AdaptationScorer.score(intake(
        sqft: .ft5000to8000,
        stage: .newBuildPreDrywall,
        rackRoom: false,
        budget: .unstated,
        multiRoomAudio: true,
        hvacZones: true,
        children: true,
        pets: true,
        largeGarden: true,
        outdoorLiving: true,
        drywallUnconfirmed: true
    ))
    #expect(family.primary == .wired)
    #expect(family.prewireWindow)
    #expect(family.briefNotes.contains { $0.zh.contains("干墙") })
    #expect(BudgetEngine.calculate(intake(budget: .unstated), tier: .better, brand: .control4).amountsWithheld)

    let elders = AdaptationScorer.score(intake(
        sqft: .ft3000to5000,
        stage: .retrofitExisting,
        rackRoom: false,
        budget: .unstated,
        hvacZones: true,
        elderCare: true,
        simpleAlarmOnly: true
    ))
    #expect(elders.primary == .hybrid)
    #expect(elders.briefNotes.contains { $0.zh.contains("红外") })
    #expect(elders.briefNotes.contains { $0.zh.contains("医疗") })

    let estateInput = intake(
        sqft: .over8000,
        stage: .newBuildPreDrywall,
        budget: .unstated,
        cinema: true,
        multiRoomAudio: true,
        hvacZones: true,
        largeGarden: true,
        multiBuilding: true,
        outdoorLiving: true
    )
    #expect(AdaptationScorer.score(estateInput).primary == .wired)
    #expect(TopologyBuilder.recommendedControlBrand(estateInput, tier: .best) == .crestron)

    let hotel = intake(sqft: .over8000, budget: .k150plus, cinema: true, legacy: .appleHome, hospitality: true)
    let hotelScore = AdaptationScorer.score(hotel)
    #expect(!hotelScore.residentialModelApplies)
    #expect(hotelScore.scopeNote?.zh.contains("酒店") == true)
    let hotelMoney = BudgetEngine.calculate(hotel, tier: .best, brand: .crestron)
    #expect(hotelMoney.amountsWithheld)
    #expect(hotelMoney.totalLow == 0)
    #expect(TopologyBuilder.build(hotel, tier: .best).specificationWithheld)

    let designer = intake(
        sqft: .under3000,
        stage: .newBuildPreDrywall,
        rackRoom: false,
        budget: .unstated,
        energyPriority: true,
        keypad: .basalte
    )
    let plan = TopologyBuilder.build(designer, tier: .better)
    #expect(plan.lightingBase.contains("Basalte"))
    #expect(plan.controlBrand == .control4)
    #expect(plan.layers.contains { $0.detail.zh.contains("Basalte Sentido") })
    #expect(AdaptationScorer.score(designer).briefNotes.contains { $0.zh.contains("零碳") })
    #expect(AdaptationScorer.score(designer).primary == .wired)
}
