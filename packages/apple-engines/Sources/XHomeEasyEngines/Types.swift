import Foundation

public struct Copy: Codable, Sendable, Hashable {
    public var en: String
    public var zh: String
    public init(en: String, zh: String) {
        self.en = en
        self.zh = zh
    }
    public func text(chinese: Bool) -> String { chinese ? zh : en }
}

public enum SqftBand: String, Codable, Sendable, CaseIterable {
    case under3000, ft3000to5000, ft5000to8000, over8000
}

public enum BuildStage: String, Codable, Sendable, CaseIterable {
    case newBuildPreDrywall = "new_build_pre_drywall"
    case majorRenovation = "major_renovation"
    case retrofitExisting = "retrofit_existing"
    case inheritedHome = "inherited_home"
}

public enum BudgetBand: String, Codable, Sendable, CaseIterable {
    case under25k, k25to75, k75to150, k150plus, unstated
}

public enum KeypadSpec: String, Codable, Sendable, CaseIterable {
    case open, basalte
}

public enum LegacySystem: String, Codable, Sendable, CaseIterable {
    case none, appleHome, matter, control4, crestron, savant, lutron
}

public enum PathKind: String, Codable, Sendable, CaseIterable {
    case wired, matter, hybrid
}

public enum SignalLight: String, Codable, Sendable {
    case proceed, consider, deferPath = "defer"
}

public enum PackageTier: String, Codable, Sendable, CaseIterable {
    case good = "Good"
    case better = "Better"
    case best = "Best"
}

public enum ControlBrand: String, Codable, Sendable, CaseIterable {
    case control4 = "Control4"
    case crestron = "Crestron"
    case savant = "Savant"
}

public struct Intake: Codable, Sendable, Hashable {
    public var sqft: SqftBand
    public var stage: BuildStage
    public var rackRoom: Bool
    public var budget: BudgetBand
    public var cinema: Bool
    public var multiRoomAudio: Bool
    public var shades: Bool
    public var pool: Bool
    public var hvacZones: Bool
    public var legacy: LegacySystem
    public var children: Bool
    public var pets: Bool
    public var largeGarden: Bool
    public var elderCare: Bool
    public var simpleAlarmOnly: Bool
    public var multiBuilding: Bool
    public var outdoorLiving: Bool
    public var hospitality: Bool
    public var energyPriority: Bool
    public var keypad: KeypadSpec
    public var drywallUnconfirmed: Bool

    public init(
        sqft: SqftBand,
        stage: BuildStage,
        rackRoom: Bool,
        budget: BudgetBand,
        cinema: Bool,
        multiRoomAudio: Bool,
        shades: Bool,
        pool: Bool,
        hvacZones: Bool,
        legacy: LegacySystem,
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
    ) {
        self.sqft = sqft
        self.stage = stage
        self.rackRoom = rackRoom
        self.budget = budget
        self.cinema = cinema
        self.multiRoomAudio = multiRoomAudio
        self.shades = shades
        self.pool = pool
        self.hvacZones = hvacZones
        self.legacy = legacy
        self.children = children
        self.pets = pets
        self.largeGarden = largeGarden
        self.elderCare = elderCare
        self.simpleAlarmOnly = simpleAlarmOnly
        self.multiBuilding = multiBuilding
        self.outdoorLiving = outdoorLiving
        self.hospitality = hospitality
        self.energyPriority = energyPriority
        self.keypad = keypad
        self.drywallUnconfirmed = drywallUnconfirmed
    }
}

public struct PathScore: Sendable, Hashable {
    public var kind: PathKind
    public var score: Int
    public var light: SignalLight
    public var reasons: [Copy]
}

public struct AdaptationResult: Sendable {
    public var paths: [PathScore]
    public var primary: PathKind
    public var prewireWindow: Bool
    public var retailGuardrail: Bool
    public var residentialModelApplies: Bool
    public var scopeNote: Copy?
    public var briefNotes: [Copy]
    public var disclaimer: Copy
    public var redLines: [Copy]
}

public struct LayerCard: Sendable, Hashable {
    public var name: Copy
    public var detail: Copy
    public var tier: String
    public var url: String
}

public struct TopologyPlan: Sendable {
    public var packageTier: PackageTier
    public var lightingBase: String
    public var controlBrand: ControlBrand
    public var voiceLayer: String?
    public var layers: [LayerCard]
    public var subsystemCategories: [String]
    public var fusionHint: Copy
    public var prewireWindow: Bool
    public var specificationWithheld: Bool
}

public struct CostBucket: Sendable, Hashable {
    public var id: String
    public var label: Copy
    public var lowPct: Double
    public var highPct: Double
    public var dollarLow: Int
    public var dollarHigh: Int
    public var barShare: Double
}

public struct BudgetSource: Sendable, Hashable {
    public var label: String
    public var url: String
    public var tier: String
}

public struct BudgetReport: Sendable {
    public var totalLow: Int
    public var totalHigh: Int
    public var estateBand: Bool
    public var amountsWithheld: Bool
    public var buckets: [CostBucket]
    public var programmingShare: Copy
    public var programmingHoursLow: Int
    public var programmingHoursHigh: Int
    public var hourlyRateLow: Int
    public var hourlyRateHigh: Int
    public var laborComposite: Copy
    public var questions: [Copy]
    public var disclaimer: Copy
    public var sources: [BudgetSource]
}

public struct QuoteInput: Codable, Sendable, Hashable {
    public var id: String
    public var dealerName: String
    public var isSample: Bool
    public var controlBrand: String
    public var lightingBrand: String
    public var hardware: Double
    public var prewire: Double
    public var labor: Double
    public var programmingCost: Double
    public var programmingHours: Double
    public var hourlyRate: Double
    public var rackNetwork: Double
    public var annualSubscription: Double
    public var subscriptionMandatory: Bool
    public var handoverAccepted: Bool
    public var warrantyMonths: Int

    public init(
        id: String,
        dealerName: String,
        isSample: Bool,
        controlBrand: String,
        lightingBrand: String,
        hardware: Double,
        prewire: Double,
        labor: Double,
        programmingCost: Double,
        programmingHours: Double,
        hourlyRate: Double,
        rackNetwork: Double,
        annualSubscription: Double,
        subscriptionMandatory: Bool,
        handoverAccepted: Bool,
        warrantyMonths: Int
    ) {
        self.id = id
        self.dealerName = dealerName
        self.isSample = isSample
        self.controlBrand = controlBrand
        self.lightingBrand = lightingBrand
        self.hardware = hardware
        self.prewire = prewire
        self.labor = labor
        self.programmingCost = programmingCost
        self.programmingHours = programmingHours
        self.hourlyRate = hourlyRate
        self.rackNetwork = rackNetwork
        self.annualSubscription = annualSubscription
        self.subscriptionMandatory = subscriptionMandatory
        self.handoverAccepted = handoverAccepted
        self.warrantyMonths = warrantyMonths
    }
}

public struct QuoteWarning: Sendable, Hashable {
    public var code: String
    public var severity: String
    public var message: Copy
}

public struct QuoteColumn: Sendable, Hashable {
    public var id: String
    public var dealerName: String
    public var isSample: Bool
    public var total: Double
    public var warnings: [QuoteWarning]
}

public struct QuoteComparison: Sendable {
    public var columns: [QuoteColumn]
    public var portfolioNotes: [Copy]
    public var expectedHoursLow: Int
    public var expectedHoursHigh: Int
}

public struct HandoverItem: Sendable, Hashable, Identifiable {
    public var id: String
    public var brand: String
    public var text: Copy
    public var tier: String
    public var sourceName: String
    public var url: String
}

public struct AdvisorDocument: Sendable, Hashable {
    public var id: String
    public var title: String
    public var text: String
    public var tier: String
    public var url: String
    public init(id: String, title: String, text: String, tier: String, url: String) {
        self.id = id
        self.title = title
        self.text = text
        self.tier = tier
        self.url = url
    }
}

public struct AdvisorCitation: Codable, Sendable, Hashable, Identifiable {
    public var id: String
    public var title: String
    public var tier: String
    public var url: String
}

public struct AdvisorReply: Sendable {
    public var refused: Bool
    public var unknown: Bool
    public var text: Copy
    public var citations: [AdvisorCitation]
}

public enum EvidenceCopy {
    public static let verifiedOn = "2026-10-21"
    public static let budgetDisclaimer = Copy(
        en: "Bands come from trade press and integrator articles reviewed on 2026-10-21. They are not a manufacturer MSRP. A licensed integrator's site quote controls.",
        zh: "区间来自 2026-10-21 复核过的行业媒体与服务商公开口径，不是厂商官方标价。最终以持证集成商现场勘测报价为准。"
    )
    public static let heuristicDisclaimer = Copy(
        en: "This score is a heuristic based on CEDIA category patterns. It is not a manufacturer certification.",
        zh: "本评分是依据 CEDIA 品类结构整理的启发式模型，不是厂商官方认证。"
    )
    public static let redLines: [Copy] = [
        Copy(
            en: "This app does not give step-by-step instructions for line-voltage wiring, panel changes, or opening electrical equipment.",
            zh: "本 App 不提供市电接线、配电箱改动或打开电气设备的分步做法。"
        ),
        Copy(
            en: "Line-voltage work belongs to a locally licensed electrician. Low-voltage work still follows local rules and the manufacturer, and is done by a qualified integrator.",
            zh: "市电作业属于当地持证电工。低电压工作也要遵守地方法规和制造商说明，由合格集成商完成。"
        ),
        Copy(
            en: "Composer Pro, Configure Pro, and Savant dealer tools stay on the dealer. This app does not describe bypasses.",
            zh: "Composer Pro、Configure Pro 与 Savant 经销商工具只属于授权经销商。本 App 不说明任何绕过方式。"
        ),
    ]
}

public enum RegionPractice {
    public static func label(region: String?, geography: String? = nil) -> String? {
        let blob = "\(region ?? "") \(geography ?? "")".lowercased()
        let europe = ["europe", "united kingdom", " uk", "uk,", "england", "scotland", "glasgow", "france", "germany", "spain", "mallorca", "italy", "netherlands", "belgium", "sweden", "iceland", "switzerland", "portugal", "ireland", "lytham", "wiltshire"]
        let middleEast = ["middle", "dubai", "uae", "qatar", "saudi", "abu dhabi", "ae-"]
        if europe.contains(where: { blob.contains($0) }) { return "欧洲工程实践参考" }
        if middleEast.contains(where: { blob.contains($0) }) { return "中东工程实践参考" }
        return nil
    }
}
