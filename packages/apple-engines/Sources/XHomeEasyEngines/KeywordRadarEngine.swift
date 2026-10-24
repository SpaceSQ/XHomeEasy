import Foundation

public struct RadarSource: Codable, Sendable, Hashable {
    public var url: String
    public var note: String
    public var fetchedOn: String

    public init(url: String, note: String, fetchedOn: String) {
        self.url = url
        self.note = note
        self.fetchedOn = fetchedOn
    }
}

public struct RadarRecord: Codable, Identifiable, Sendable, Hashable {
    public var id: String
    public var kind: String
    public var section: String
    public var brandOrProtocolName: String
    public var triggerKeywords: [String]
    public var operatingCompany: String
    public var foundedYearAndStatus: String
    public var statusEnum: String
    public var protocolCharacteristics: String
    public var pros: [String]
    public var cons: [String]
    public var mainProducts: [String]
    public var applicationAreas: [String]
    public var priceRangeAndModel: String
    public var actionAdvice: String
    public var fourGiantBridge: String
    public var redirectTargets: [String]
    public var redirectScript: String
    public var evidenceTier: String
    public var sources: [RadarSource]
    public var lineVoltageBoundary: Bool

    public init(
        id: String,
        kind: String,
        section: String,
        brandOrProtocolName: String,
        triggerKeywords: [String],
        operatingCompany: String,
        foundedYearAndStatus: String,
        statusEnum: String,
        protocolCharacteristics: String,
        pros: [String],
        cons: [String],
        mainProducts: [String],
        applicationAreas: [String],
        priceRangeAndModel: String,
        actionAdvice: String,
        fourGiantBridge: String,
        redirectTargets: [String],
        redirectScript: String,
        evidenceTier: String,
        sources: [RadarSource],
        lineVoltageBoundary: Bool
    ) {
        self.id = id
        self.kind = kind
        self.section = section
        self.brandOrProtocolName = brandOrProtocolName
        self.triggerKeywords = triggerKeywords
        self.operatingCompany = operatingCompany
        self.foundedYearAndStatus = foundedYearAndStatus
        self.statusEnum = statusEnum
        self.protocolCharacteristics = protocolCharacteristics
        self.pros = pros
        self.cons = cons
        self.mainProducts = mainProducts
        self.applicationAreas = applicationAreas
        self.priceRangeAndModel = priceRangeAndModel
        self.actionAdvice = actionAdvice
        self.fourGiantBridge = fourGiantBridge
        self.redirectTargets = redirectTargets
        self.redirectScript = redirectScript
        self.evidenceTier = evidenceTier
        self.sources = sources
        self.lineVoltageBoundary = lineVoltageBoundary
    }

    public var isWireless: Bool { kind == "wireless" || id.hasPrefix("WL") }
}

public struct KeywordRadarIndex: Codable, Sendable, Hashable {
    public var keywords: [String: [String]]

    public init(keywords: [String: [String]]) {
        self.keywords = keywords
    }
}

public struct RadarHit: Identifiable, Sendable, Hashable {
    public var id: String { record.id }
    public var keyword: String
    public var record: RadarRecord

    public init(keyword: String, record: RadarRecord) {
        self.keyword = keyword
        self.record = record
    }
}

public enum KeywordRadarCopy {
    public static let wirelessBoundary = Copy(
        en: "This app advises on wired systems led by Control4, Crestron, Savant, and Lutron. Wireless smart-home products are outside the advice this app gives.",
        zh: "本 APP 重点提供以 Control4、Crestron、Savant、Lutron 四大品牌为主的有线智能家居方案建议与辅助决策，无线智能家居不在本 APP 建议范围内"
    )
    public static let lineVoltageBoundary = Copy(
        en: "Topology planning only. A licensed electrician has to do the work.",
        zh: "仅限拓扑规划，须由持证电工施工"
    )
    public static let priceDisclaimer = Copy(
        en: "Ranges come from integrator and trade-press figures checked on 2026-10-21, not a manufacturer MSRP. A licensed local integrator's site survey sets the price.",
        zh: "数据源自服务商/媒体公开口径（2026-10-21 核实），非厂商官方 MSRP，最终以本地持证集成商现场勘测报价为准"
    )
}

public final class RadarMatcher: @unchecked Sendable {
    private struct Needle {
        var keyword: String
        var ids: [String]
        var expression: NSRegularExpression
    }

    private let needles: [Needle]
    private let records: [String: RadarRecord]

    public init(index: KeywordRadarIndex, records: [RadarRecord]) {
        self.records = Dictionary(uniqueKeysWithValues: records.map { ($0.id, $0) })
        let keywords = index.keywords.keys.sorted { $0.count > $1.count }
        needles = keywords.compactMap { keyword in
            guard let pattern = Self.pattern(for: keyword),
                  let expression = try? NSRegularExpression(pattern: pattern) else { return nil }
            return Needle(keyword: keyword, ids: index.keywords[keyword] ?? [], expression: expression)
        }
    }

    public func scan(_ text: String) -> [RadarHit] {
        let haystack = Self.fold(text)
        guard haystack.trimmingCharacters(in: .whitespacesAndNewlines).count >= 2 else { return [] }
        let nsHaystack = haystack as NSString
        let range = NSRange(location: 0, length: nsHaystack.length)
        var found: [String: (keyword: String, location: Int, record: RadarRecord)] = [:]
        for needle in needles {
            guard let match = needle.expression.firstMatch(in: haystack, range: range) else { continue }
            for id in needle.ids {
                guard let record = records[id] else { continue }
                if let previous = found[id] {
                    let earlier = match.range.location < previous.location
                    let sameSpotLonger = match.range.location == previous.location && needle.keyword.count > previous.keyword.count
                    if !earlier && !sameSpotLonger { continue }
                }
                found[id] = (needle.keyword, match.range.location, record)
            }
        }
        return found.values.sorted {
            if $0.location != $1.location { return $0.location < $1.location }
            return $0.record.id < $1.record.id
        }.map { RadarHit(keyword: $0.keyword, record: $0.record) }
    }

    static func fold(_ value: String) -> String {
        value.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: Locale(identifier: "en_US_POSIX")).lowercased()
    }

    static func pattern(for keyword: String) -> String? {
        let pieces = fold(keyword).split { !$0.isLetter && !$0.isNumber }.flatMap { token -> [String] in
            let text = String(token)
            var parts: [String] = []
            var current = ""
            var digits = false
            for scalar in text.unicodeScalars {
                let number = CharacterSet.decimalDigits.contains(scalar)
                if current.isEmpty {
                    digits = number
                    current.append(Character(scalar))
                } else if number == digits {
                    current.append(Character(scalar))
                } else {
                    parts.append(current)
                    current = String(Character(scalar))
                    digits = number
                }
            }
            if !current.isEmpty { parts.append(current) }
            return parts
        }
        guard !pieces.isEmpty, fold(keyword).count >= 2 else { return nil }
        let body = pieces.map { NSRegularExpression.escapedPattern(for: $0) }.joined(separator: "[-_.&@+/\\s]*")
        return "(?<![A-Za-z0-9])\(body)(?![A-Za-z0-9])"
    }
}

public enum KeywordRadarEngine {
    public static func scan(text: String, index: KeywordRadarIndex, records: [RadarRecord]) -> [RadarHit] {
        RadarMatcher(index: index, records: records).scan(text)
    }

    public static func lineVoltageFromNames(_ name: String, keywords: [String]) -> Bool {
        let blob = RadarMatcher.fold("\(name) \(keywords.joined(separator: " "))")
        if blob.range(of: #"(?<![a-z0-9])span(?![a-z0-9])|span\.io"#, options: .regularExpression) != nil { return true }
        if blob.contains("leviton") && blob.contains("load center") { return true }
        return blob.contains("electrical panel")
            || blob.contains("smart panel")
            || blob.contains("load center")
            || blob.contains("transfer switch")
            || blob.contains("配电箱")
            || blob.contains("配电盘")
    }

    public static func requiresLicensedElectrician(_ record: RadarRecord) -> Bool {
        record.lineVoltageBoundary || lineVoltageFromNames(record.brandOrProtocolName, keywords: record.triggerKeywords)
    }
}
