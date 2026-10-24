import Testing
@testable import XHomeEasyEngines

private func record(
    id: String,
    kind: String,
    name: String,
    keywords: [String],
    lineVoltage: Bool = false
) -> RadarRecord {
    RadarRecord(
        id: id,
        kind: kind,
        section: "fixture",
        brandOrProtocolName: name,
        triggerKeywords: keywords,
        operatingCompany: "Fixture",
        foundedYearAndStatus: "2000 · ACTIVE_NICHE",
        statusEnum: "ACTIVE_NICHE",
        protocolCharacteristics: "Fixture protocol",
        pros: ["a"],
        cons: ["b"],
        mainProducts: ["module"],
        applicationAreas: ["villa"],
        priceRangeAndModel: "USD $1–$2 range",
        actionAdvice: "Bridge toward the four wired platforms.",
        fourGiantBridge: "Lutron or Control4",
        redirectTargets: kind == "wireless" ? ["MHomeEasy", "AHomeEasy"] : [],
        redirectScript: kind == "wireless" ? "无线" : "",
        evidenceTier: "E2",
        sources: [RadarSource(url: "https://example.com/source", note: "fixture", fetchedOn: "2026-10-24")],
        lineVoltageBoundary: lineVoltage
    )
}

private let index = KeywordRadarIndex(keywords: [
    "x10": ["NW001"],
    "x-10": ["NW001"],
    "span": ["NW069"],
    "span.io": ["NW069"],
    "leviton load center": ["NW074"],
    "omnipro": ["NW005"],
    "matter": ["WL001"],
    "matter over thread": ["WL001"],
    "ring alarm": ["NW100", "WL091"],
    "caséta": ["WL027"],
])

private let records = [
    record(id: "NW001", kind: "wired", name: "X10", keywords: ["x10", "x-10"]),
    record(id: "NW069", kind: "wired", name: "SPAN Smart Electrical Panel", keywords: ["span", "span.io"]),
    record(id: "NW074", kind: "wired", name: "Leviton Smart Load Center", keywords: ["leviton load center"]),
    record(id: "NW005", kind: "wired", name: "Leviton HAI OmniPro II", keywords: ["omnipro"]),
    record(id: "WL001", kind: "wireless", name: "Matter", keywords: ["matter", "matter over thread"]),
    record(id: "WL027", kind: "wireless", name: "Caséta", keywords: ["caséta"]),
    record(id: "NW100", kind: "wired", name: "Ring Alarm Pro", keywords: ["ring alarm"]),
    record(id: "WL091", kind: "wireless", name: "Ring Alarm", keywords: ["ring alarm"]),
]

private func ids(_ text: String) -> [String] {
    KeywordRadarEngine.scan(text: text, index: index, records: records).map(\.record.id)
}

@Test func radarMatchesKeywordsWithoutMovingBrands() {
    #expect(ids("家里还有一套 X-10") == ["NW001"])
    #expect(ids("SPAN panel") == ["NW069"])
    #expect(ids("a spanish villa") == [])
    #expect(ids("Matter over Thread") == ["WL001"])
    #expect(ids("Caseta switch") == ["WL027"])
    #expect(ids("ring alarm").contains("NW100"))
    #expect(ids("ring alarm").contains("WL091"))
    #expect(ids("").isEmpty)
    #expect(KeywordRadarCopy.wirelessBoundary.zh.contains("无线智能家居不在本 APP 建议范围内"))
    #expect(KeywordRadarCopy.lineVoltageBoundary.zh == "仅限拓扑规划，须由持证电工施工")
}

@Test func lineVoltageStaysOnPanels() {
    let span = records.first { $0.id == "NW069" }!
    let panel = records.first { $0.id == "NW074" }!
    let hai = records.first { $0.id == "NW005" }!
    let x10 = records.first { $0.id == "NW001" }!
    #expect(KeywordRadarEngine.requiresLicensedElectrician(span))
    #expect(KeywordRadarEngine.requiresLicensedElectrician(panel))
    #expect(!KeywordRadarEngine.requiresLicensedElectrician(hai))
    #expect(!KeywordRadarEngine.requiresLicensedElectrician(x10))
}
