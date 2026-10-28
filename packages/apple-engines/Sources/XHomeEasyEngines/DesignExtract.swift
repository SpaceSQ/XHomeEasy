import Foundation

/// A room named in free text. Flags are suggestions for the existing room cards.
public struct ExtractedRoom: Sendable, Equatable, Hashable {
    public var name: String
    public var lighting: Bool
    public var shades: Bool
    public var audio: Bool
    public var cinema: Bool
    public var climate: Bool
    public var security: Bool
    public var note: String

    public init(name: String, lighting: Bool = false, shades: Bool = false, audio: Bool = false, cinema: Bool = false, climate: Bool = false, security: Bool = false, note: String = "") {
        self.name = name
        self.lighting = lighting
        self.shades = shades
        self.audio = audio
        self.cinema = cinema
        self.climate = climate
        self.security = security
        self.note = note
    }
}

/// Structured wired-home facts. Nil means the text did not say it.
public struct WiredDesignFacts: Sendable, Equatable {
    public var sqft: SqftBand?
    public var stage: BuildStage?
    public var rackRoom: Bool?
    public var budget: BudgetBand?
    public var cinema: Bool?
    public var multiRoomAudio: Bool?
    public var shades: Bool?
    public var pool: Bool?
    public var hvacZones: Bool?
    public var legacy: LegacySystem?
    public var children: Bool?
    public var pets: Bool?
    public var largeGarden: Bool?
    public var elderCare: Bool?
    public var simpleAlarmOnly: Bool?
    public var multiBuilding: Bool?
    public var outdoorLiving: Bool?
    public var hospitality: Bool?
    public var energyPriority: Bool?
    public var keypad: KeypadSpec?
    public var drywallUnconfirmed: Bool?
    public var preferredControl: ControlBrand?
    public var city: String?
    public var state: String?
    public var zip: String?
    public var rooms: [ExtractedRoom]
    public var constraints: [String]

    public init(
        sqft: SqftBand? = nil,
        stage: BuildStage? = nil,
        rackRoom: Bool? = nil,
        budget: BudgetBand? = nil,
        cinema: Bool? = nil,
        multiRoomAudio: Bool? = nil,
        shades: Bool? = nil,
        pool: Bool? = nil,
        hvacZones: Bool? = nil,
        legacy: LegacySystem? = nil,
        children: Bool? = nil,
        pets: Bool? = nil,
        largeGarden: Bool? = nil,
        elderCare: Bool? = nil,
        simpleAlarmOnly: Bool? = nil,
        multiBuilding: Bool? = nil,
        outdoorLiving: Bool? = nil,
        hospitality: Bool? = nil,
        energyPriority: Bool? = nil,
        keypad: KeypadSpec? = nil,
        drywallUnconfirmed: Bool? = nil,
        preferredControl: ControlBrand? = nil,
        city: String? = nil,
        state: String? = nil,
        zip: String? = nil,
        rooms: [ExtractedRoom] = [],
        constraints: [String] = []
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
        self.preferredControl = preferredControl
        self.city = city
        self.state = state
        self.zip = zip
        self.rooms = rooms
        self.constraints = constraints
    }
}

/// Consult and location slots the wizard may already have filled.
public struct HouseSlotState: Sendable, Equatable {
    public var sqft: SqftBand?
    public var stage: BuildStage?
    public var rackRoom: Bool?
    public var budget: BudgetBand?
    public var cinema: Bool
    public var multiRoomAudio: Bool
    public var shades: Bool
    public var pool: Bool
    public var hvacZones: Bool
    public var legacy: LegacySystem?
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
    public var featureChoicesLocked: Bool
    public var city: String
    public var stateCode: String
    public var zip: String
    public var controlOverride: ControlBrand?
    public var roomNames: [String]
    public var step: Int

    public init(
        sqft: SqftBand? = nil,
        stage: BuildStage? = nil,
        rackRoom: Bool? = nil,
        budget: BudgetBand? = nil,
        cinema: Bool = false,
        multiRoomAudio: Bool = false,
        shades: Bool = false,
        pool: Bool = false,
        hvacZones: Bool = false,
        legacy: LegacySystem? = nil,
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
        drywallUnconfirmed: Bool = false,
        featureChoicesLocked: Bool = false,
        city: String = "",
        stateCode: String = "CA",
        zip: String = "",
        controlOverride: ControlBrand? = nil,
        roomNames: [String] = [],
        step: Int = 0
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
        self.featureChoicesLocked = featureChoicesLocked
        self.city = city
        self.stateCode = stateCode
        self.zip = zip
        self.controlOverride = controlOverride
        self.roomNames = roomNames
        self.step = step
    }
}

public struct DesignMerge: Sendable, Equatable {
    public var facts: WiredDesignFacts
    public var filledSlots: [String]
    public var disagreements: [String]
}

public struct DesignApplication: Sendable, Equatable {
    public var slots: HouseSlotState
    public var addedRooms: [ExtractedRoom]
    public var enrichedRooms: [ExtractedRoom]
    public var filledSlots: [String]
    public var disagreements: [String]
    public var constraints: [String]
    public var fromModel: Bool
}

/// Fixed reader plus a merge that keeps numbers the reader already found.
public enum DesignExtract {
    public static func shouldExtract(_ text: String) -> Bool {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmed.count >= 40 else { return false }
        if looksLikeQuestion(trimmed), trimmed.count < 220, firstNumber(in: trimmed, unit: true) == nil {
            return false
        }
        return hasDesignSignal(trimmed) || trimmed.count >= 120
    }

    /// Keyword read of one description. It does not invent a brand from a how-to question.
    public static func read(_ text: String) -> WiredDesignFacts {
        var facts = WiredDesignFacts()
        let lower = text.lowercased()
        func has(_ needles: [String]) -> Bool {
            needles.contains { needle in
                text.contains(needle) || lower.contains(needle.lowercased())
            }
        }

        if let sqft = squareFeet(in: text) {
            facts.sqft = band(sqft: sqft)
        }
        if has(["inherited professional", "inherited system", "接手已有", "接手"]) {
            facts.stage = .inheritedHome
        } else if has(["occupied retrofit", "retrofit", "已入住", "局部改造"]) {
            facts.stage = .retrofitExisting
        } else if has(["major renovation", "renovation", "remodel", "翻新"]) {
            facts.stage = .majorRenovation
        } else if has(["new build", "pre-drywall", "pre drywall", "drywall still open", "drywall is still open", "新建", "干墙还没"]) {
            facts.stage = .newBuildPreDrywall
        }
        if has(["no rack", "without a rack", "没有机柜", "没有弱电间"]) {
            facts.rackRoom = false
        } else if has(["rack room", "equipment rack", "弱电间", "机柜间", "low-voltage room", "dedicated rack"]) {
            facts.rackRoom = true
        }
        if has(["budget not stated", "budget isn't stated", "haven't decided on a budget", "预算还没定", "预算未定"]) {
            facts.budget = .unstated
        } else if let dollars = dollars(in: text) {
            facts.budget = band(dollars: dollars)
        }
        if has(["no theater", "no theatre", "without a theater", "不做影院"]) {
            facts.cinema = false
        } else if has(["theater", "theatre", "cinema", "影院", "家庭影院"]) {
            facts.cinema = true
        }
        if has(["multi-room audio", "multiroom audio", "whole-home audio", "whole home audio", "多房间音频"]) {
            facts.multiRoomAudio = true
        }
        if has(["shade", "shades", "blind", "blinds", "遮阳", "窗帘"]) {
            facts.shades = true
        }
        if has(["pool", "泳池"]) {
            facts.pool = true
        }
        if has(["hvac", "heating and cooling", "thermostat", "暖通", "温区", "heating"]) {
            facts.hvacZones = true
        }
        if has(["children", "kids", "孩子"]) { facts.children = true }
        if has(["pet", "pets", "dog", "宠物"]) { facts.pets = true }
        if has(["large garden", "garden", "landscape", "大花园", "花园"]) {
            facts.largeGarden = true
            facts.outdoorLiving = true
        }
        if has(["aging in place", "elder", "适老"]) { facts.elderCare = true }
        if has(["simple alarm", "infrared alarm only", "只有简单红外", "只有报警"]) { facts.simpleAlarmOnly = true }
        if has(["guest house", "casita", "two buildings", "more than one residence", "多幢", "另一栋"]) { facts.multiBuilding = true }
        if has(["outdoor living", "outdoor kitchen", "露台"]) { facts.outdoorLiving = true }
        if has(["hotel", "hospitality", "酒店"]) { facts.hospitality = true }
        if has(["energy management", "low-carbon", "low carbon", "低碳", "能源管理"]) { facts.energyPriority = true }
        if has(["basalte", "巴萨"]) { facts.keypad = .basalte }
        if has(["not sure if the drywall", "drywall unconfirmed", "不确定干墙", "干墙封了没有还不确定"]) {
            facts.drywallUnconfirmed = true
        }
        if has(["existing system is none", "no existing system", "none of these yet", "都还没有", "还没有系统", "还没有专业系统"]) {
            facts.legacy = LegacySystem.none
        } else {
            facts.legacy = cuedBrand(in: text, want: false).flatMap(legacy(from:))
        }
        facts.preferredControl = cuedBrand(in: text, want: true).flatMap(control(from:))
        let place = place(in: text)
        facts.city = place.city
        facts.state = place.state
        facts.zip = place.zip
        facts.rooms = rooms(in: text)
        if has(["lutron"]) { facts.constraints.append("Lutron named") }
        if has(["listed building", "historic", "文物", "保护建筑"]) { facts.constraints.append("listed or historic") }
        return facts
    }

    public static func parseModelJSON(_ raw: String) -> WiredDesignFacts? {
        guard let start = raw.firstIndex(of: "{"), let end = raw.lastIndex(of: "}"), start < end else { return nil }
        let slice = String(raw[start...end])
        guard let data = slice.data(using: .utf8),
              let object = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return nil }
        var facts = WiredDesignFacts()
        facts.sqft = enumValue(SqftBand.self, object["sqft"]) ?? squareFeetValue(object["areaSqft"]).map(band(sqft:)) ?? squareFeetValue(object["areaSqm"]).map { band(sqft: $0 * 10.7639) }
        facts.stage = enumValue(BuildStage.self, object["stage"])
        facts.rackRoom = jsonBool(object["rackRoom"])
        facts.budget = enumValue(BudgetBand.self, object["budget"])
        facts.cinema = jsonBool(object["cinema"])
        facts.multiRoomAudio = jsonBool(object["multiRoomAudio"])
        facts.shades = jsonBool(object["shades"])
        facts.pool = jsonBool(object["pool"])
        facts.hvacZones = jsonBool(object["hvacZones"])
        facts.legacy = enumValue(LegacySystem.self, object["legacy"])
        facts.children = jsonBool(object["children"])
        facts.pets = jsonBool(object["pets"])
        facts.largeGarden = jsonBool(object["largeGarden"])
        facts.elderCare = jsonBool(object["elderCare"])
        facts.simpleAlarmOnly = jsonBool(object["simpleAlarmOnly"])
        facts.multiBuilding = jsonBool(object["multiBuilding"])
        facts.outdoorLiving = jsonBool(object["outdoorLiving"])
        facts.hospitality = jsonBool(object["hospitality"])
        facts.energyPriority = jsonBool(object["energyPriority"])
        facts.keypad = enumValue(KeypadSpec.self, object["keypad"])
        facts.drywallUnconfirmed = jsonBool(object["drywallUnconfirmed"])
        facts.preferredControl = enumValue(ControlBrand.self, object["preferredControl"])
        facts.city = clipped(object["city"])
        facts.state = clipped(object["state"]).map(stateCode)
        facts.zip = clipped(object["zip"])
        facts.rooms = jsonRooms(object["rooms"])
        facts.constraints = jsonStrings(object["constraints"])
        return facts
    }

    /// Numbers and choices the fixed reader already found stay. The model fills only what is still empty.
    public static func merge(base: WiredDesignFacts, model: WiredDesignFacts) -> DesignMerge {
        var facts = base
        var filled: [String] = []
        var disagreements: [String] = []
        func take<T: Equatable>(_ slot: String, _ key: WritableKeyPath<WiredDesignFacts, T?>) {
            guard let incoming = model[keyPath: key] else { return }
            if facts[keyPath: key] == nil {
                facts[keyPath: key] = incoming
                filled.append(slot)
            } else if facts[keyPath: key] != incoming {
                disagreements.append(slot)
            }
        }
        take("sqft", \.sqft)
        take("stage", \.stage)
        take("rackRoom", \.rackRoom)
        take("budget", \.budget)
        take("cinema", \.cinema)
        take("multiRoomAudio", \.multiRoomAudio)
        take("shades", \.shades)
        take("pool", \.pool)
        take("hvacZones", \.hvacZones)
        take("legacy", \.legacy)
        take("children", \.children)
        take("pets", \.pets)
        take("largeGarden", \.largeGarden)
        take("elderCare", \.elderCare)
        take("simpleAlarmOnly", \.simpleAlarmOnly)
        take("multiBuilding", \.multiBuilding)
        take("outdoorLiving", \.outdoorLiving)
        take("hospitality", \.hospitality)
        take("energyPriority", \.energyPriority)
        take("keypad", \.keypad)
        take("drywallUnconfirmed", \.drywallUnconfirmed)
        take("preferredControl", \.preferredControl)
        take("city", \.city)
        take("state", \.state)
        take("zip", \.zip)
        if facts.rooms.isEmpty, !model.rooms.isEmpty {
            facts.rooms = model.rooms
            filled.append("rooms")
        } else if !model.rooms.isEmpty, facts.rooms != model.rooms {
            disagreements.append("rooms")
        }
        if facts.constraints.isEmpty, !model.constraints.isEmpty {
            facts.constraints = model.constraints
            filled.append("constraints")
        }
        for item in model.constraints where !facts.constraints.contains(item) && !base.constraints.isEmpty {
            facts.constraints.append(item)
            filled.append("constraints")
        }
        return DesignMerge(facts: facts, filledSlots: filled, disagreements: disagreements)
    }

    /// Writes facts into empty wizard slots. A choice the person already made stays.
    public static func apply(facts: WiredDesignFacts, onto: HouseSlotState, disagreements: [String] = [], fromModel: Bool = false) -> DesignApplication {
        var slots = onto
        var filled: [String] = []
        func takeOptional<T: Equatable>(_ slot: String, _ current: inout T?, _ incoming: T?) {
            guard let incoming else { return }
            if current == nil {
                current = incoming
                filled.append(slot)
            }
        }
        takeOptional("sqft", &slots.sqft, facts.sqft)
        takeOptional("stage", &slots.stage, facts.stage)
        takeOptional("rackRoom", &slots.rackRoom, facts.rackRoom)
        takeOptional("budget", &slots.budget, facts.budget)
        takeOptional("legacy", &slots.legacy, facts.legacy)
        if !slots.featureChoicesLocked {
            func turnOn(_ slot: String, _ current: inout Bool, _ incoming: Bool?) {
                guard incoming == true, !current else { return }
                current = true
                filled.append(slot)
            }
            turnOn("cinema", &slots.cinema, facts.cinema)
            turnOn("multiRoomAudio", &slots.multiRoomAudio, facts.multiRoomAudio)
            turnOn("shades", &slots.shades, facts.shades)
            turnOn("pool", &slots.pool, facts.pool)
            turnOn("hvacZones", &slots.hvacZones, facts.hvacZones)
            turnOn("children", &slots.children, facts.children)
            turnOn("pets", &slots.pets, facts.pets)
            turnOn("largeGarden", &slots.largeGarden, facts.largeGarden)
            turnOn("elderCare", &slots.elderCare, facts.elderCare)
            turnOn("simpleAlarmOnly", &slots.simpleAlarmOnly, facts.simpleAlarmOnly)
            turnOn("multiBuilding", &slots.multiBuilding, facts.multiBuilding)
            turnOn("outdoorLiving", &slots.outdoorLiving, facts.outdoorLiving)
            turnOn("hospitality", &slots.hospitality, facts.hospitality)
            turnOn("energyPriority", &slots.energyPriority, facts.energyPriority)
            turnOn("drywallUnconfirmed", &slots.drywallUnconfirmed, facts.drywallUnconfirmed)
            if slots.keypad == .open, facts.keypad == .basalte {
                slots.keypad = .basalte
                filled.append("keypad")
            }
        }
        if slots.controlOverride == nil, let preferred = facts.preferredControl {
            slots.controlOverride = preferred
            filled.append("preferredControl")
        }
        let locationUntouched = slots.city.trimmingCharacters(in: .whitespaces).isEmpty && slots.zip.trimmingCharacters(in: .whitespaces).isEmpty
        if slots.city.trimmingCharacters(in: .whitespaces).isEmpty, let city = facts.city {
            slots.city = city
            filled.append("city")
        }
        if locationUntouched, let state = facts.state, !state.isEmpty {
            slots.stateCode = state
            filled.append("state")
        }
        if slots.zip.trimmingCharacters(in: .whitespaces).isEmpty, let zip = facts.zip {
            slots.zip = zip
            filled.append("zip")
        }
        var added: [ExtractedRoom] = []
        var enriched: [ExtractedRoom] = []
        for room in facts.rooms {
            if let existing = slots.roomNames.first(where: { sameRoom($0, room.name) }) {
                enriched.append(ExtractedRoom(name: existing, lighting: room.lighting, shades: room.shades, audio: room.audio, cinema: room.cinema, climate: room.climate, security: room.security, note: room.note))
            } else {
                added.append(room)
                slots.roomNames.append(room.name)
                filled.append("room:\(room.name)")
            }
        }
        if slots.sqft != nil, slots.stage != nil, slots.rackRoom != nil, slots.budget != nil, slots.legacy != nil {
            slots.step = 6
        } else {
            slots.step = advancedStep(slots, featuresFilled: filled.contains { featureSlots.contains($0) })
        }
        return DesignApplication(slots: slots, addedRooms: added, enrichedRooms: enriched, filledSlots: filled, disagreements: disagreements, constraints: facts.constraints, fromModel: fromModel)
    }

    public static func sameRoom(_ stored: String, _ incoming: String) -> Bool {
        !keys(stored).isDisjoint(with: keys(incoming))
    }

    private static let featureSlots: Set<String> = ["cinema", "multiRoomAudio", "shades", "pool", "hvacZones", "children", "pets", "largeGarden", "elderCare", "simpleAlarmOnly", "multiBuilding", "outdoorLiving", "hospitality", "energyPriority", "keypad", "drywallUnconfirmed"]

    private static func advancedStep(_ slots: HouseSlotState, featuresFilled: Bool) -> Int {
        var step = slots.step
        while step < 6 {
            switch step {
            case 0: if slots.sqft == nil { return step }
            case 1: if slots.stage == nil { return step }
            case 2: if slots.rackRoom == nil { return step }
            case 3: if slots.budget == nil { return step }
            case 4:
                if slots.legacy != nil || featuresFilled {
                    step = 5
                    continue
                }
                return step
            case 5: if slots.legacy == nil { return step }
            default: return step
            }
            step += 1
        }
        return 6
    }

    private static func looksLikeQuestion(_ text: String) -> Bool {
        let lower = text.lowercased()
        let prefixes = ["how ", "what ", "why ", "where ", "when ", "which ", "怎么", "如何", "为什么", "哪里", "什么"]
        return prefixes.contains { lower.hasPrefix($0) || text.hasPrefix($0) } || text.contains("?") || text.contains("？")
    }

    private static func hasDesignSignal(_ text: String) -> Bool {
        let lower = text.lowercased()
        let needles = ["sq ft", "sqft", "square feet", "平方", "budget", "预算", "theater", "影院", "shade", "遮阳", "rack", "机柜", "savant", "control4", "crestron", "lutron", "drywall", "干墙"]
        return needles.contains { lower.contains($0) || text.contains($0) } || firstNumber(in: text, unit: true) != nil
    }

    private static func band(sqft: Double) -> SqftBand {
        if sqft < 3_000 { return .under3000 }
        if sqft < 5_000 { return .ft3000to5000 }
        if sqft <= 8_000 { return .ft5000to8000 }
        return .over8000
    }

    private static func band(dollars: Double) -> BudgetBand {
        if dollars < 25_000 { return .under25k }
        if dollars < 75_000 { return .k25to75 }
        if dollars < 150_000 { return .k75to150 }
        return .k150plus
    }

    private static func squareFeet(in text: String) -> Double? {
        if let raw = firstCapture(#"(\d{1,3}(?:,\d{3})+|\d{3,6}(?:\.\d+)?)\s*(?:sq\.?\s*ft\.?|sqft|square\s+feet|ft²|ft2|平方英尺)"#, in: text) {
            return number(raw)
        }
        if let raw = firstCapture(#"(\d{2,5}(?:\.\d+)?)\s*(?:m²|m2|sqm|平方米|平米)"#, in: text), let meters = number(raw) {
            return meters * 10.7639
        }
        return nil
    }

    private static func dollars(in text: String) -> Double? {
        let window = text.lowercased()
        guard window.contains("budget") || window.contains("$") || text.contains("预算") || text.contains("美元") || window.contains(" usd") else { return nil }
        if let raw = firstCapture(#"\$\s*(\d{1,3}(?:,\d{3})+|\d{2,7})(?:\.\d+)?\s*([kK])?"#, in: text) {
            return scaled(raw, text: text, pattern: #"\$\s*(\d{1,3}(?:,\d{3})+|\d{2,7})(?:\.\d+)?\s*([kK])?"#)
        }
        if let raw = firstCapture(#"(\d{2,3})\s*[kK]\b"#, in: text), let value = number(raw) {
            return value * 1_000
        }
        if let raw = firstCapture(#"(\d+(?:\.\d+)?)\s*万美元"#, in: text), let value = number(raw) {
            return value * 10_000
        }
        return nil
    }

    private static func scaled(_ raw: String, text: String, pattern: String) -> Double? {
        guard let value = number(raw) else { return nil }
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return value }
        let range = NSRange(text.startIndex..., in: text)
        guard let match = regex.firstMatch(in: text, range: range), match.numberOfRanges > 2,
              let suffix = Range(match.range(at: 2), in: text) else { return value }
        return text[suffix].lowercased() == "k" ? value * 1_000 : value
    }

    private static func cuedBrand(in text: String, want: Bool) -> String? {
        let cues = want
            ? ["want", "prefer", "considering", "looking at", "we'd like", "we would like", "希望", "想用", "考虑"]
            : ["existing", "already", "current", "inherited", "已有", "现有", "现在用", "接手"]
        let brands = ["control4", "crestron", "savant", "lutron", "apple home", "matter"]
        var best: (brand: String, distance: Int)?
        for brand in brands {
            guard let brandRange = text.range(of: brand, options: [.caseInsensitive]) else { continue }
            for cue in cues {
                guard let cueRange = text.range(of: cue, options: [.caseInsensitive]) else { continue }
                let distance = abs(text.distance(from: cueRange.lowerBound, to: brandRange.lowerBound))
                guard distance < 40, !sentenceBreak(between: cueRange, and: brandRange, in: text) else { continue }
                if best == nil || distance < best!.distance {
                    best = (brand, distance)
                }
            }
        }
        return best?.brand
    }

    private static func sentenceBreak(between lhs: Range<String.Index>, and rhs: Range<String.Index>, in text: String) -> Bool {
        let lower = min(lhs.lowerBound, rhs.lowerBound)
        let upper = max(lhs.lowerBound, rhs.lowerBound)
        return text[lower..<upper].contains { "。.!?？".contains($0) }
    }

    private static func legacy(from brand: String) -> LegacySystem? {
        switch brand {
        case "control4": return .control4
        case "crestron": return .crestron
        case "savant": return .savant
        case "lutron": return .lutron
        case "apple home": return .appleHome
        case "matter": return .matter
        default: return nil
        }
    }

    private static func control(from brand: String) -> ControlBrand? {
        switch brand {
        case "control4": return .control4
        case "crestron": return .crestron
        case "savant": return .savant
        default: return nil
        }
    }

    private static func place(in text: String) -> (city: String?, state: String?, zip: String?) {
        let pattern = #"(?:in|at|near|位于)?\s*([A-Z][a-z]+(?:[ \t]+[A-Z][a-z]+)?)\s*,\s*(TX|Texas|CA|California|NY|New York|FL|Florida|IL|Illinois|WA|Washington|CO|Colorado|AZ|Arizona|MA|Massachusetts|GA|Georgia|NC|North Carolina|ON|Ontario|BC|British Columbia)"#
        var city: String?
        var state: String?
        if let regex = try? NSRegularExpression(pattern: pattern),
           let match = regex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text)),
           let cityRange = Range(match.range(at: 1), in: text),
           let stateRange = Range(match.range(at: 2), in: text) {
            city = String(text[cityRange])
            state = stateCode(String(text[stateRange]))
        }
        var zip: String?
        if let raw = firstCapture(#"\b(\d{5})(?:-\d{4})?\b"#, in: text), state != nil || text.lowercased().contains("zip") || text.contains("邮编") {
            zip = raw
        }
        return (city, state, zip)
    }

    private static func stateCode(_ value: String) -> String {
        let codes = [
            "texas": "TX", "tx": "TX", "california": "CA", "ca": "CA", "new york": "NY", "ny": "NY",
            "florida": "FL", "fl": "FL", "illinois": "IL", "il": "IL", "washington": "WA", "wa": "WA",
            "colorado": "CO", "co": "CO", "arizona": "AZ", "az": "AZ", "massachusetts": "MA", "ma": "MA",
            "georgia": "GA", "ga": "GA", "north carolina": "NC", "nc": "NC", "ontario": "ON", "on": "ON",
            "british columbia": "BC", "bc": "BC"
        ]
        return codes[value.lowercased()] ?? value.uppercased()
    }

    private static let roomCatalog: [(name: String, needles: [String])] = [
        ("Entry", ["entry", "foyer", "门厅"]),
        ("Great Room", ["great room", "living room", "起居室"]),
        ("Primary Suite", ["primary suite", "primary bedroom", "master bedroom", "主卧"]),
        ("Kitchen", ["kitchen", "厨房"]),
        ("Theater", ["theater", "theatre", "home theater", "影院", "家庭影院"]),
        ("Terrace", ["terrace", "patio", "露台"]),
        ("Dining Room", ["dining room", "餐厅"]),
        ("Guest Suite", ["guest suite", "guest room", "客房"]),
        ("Office", ["office", "study", "书房"]),
        ("Pool House", ["pool house", "泳池小屋"]),
        ("Outdoor Kitchen", ["outdoor kitchen", "室外厨房"])
    ]

    private static func rooms(in text: String) -> [ExtractedRoom] {
        let lower = text.lowercased()
        var found: [ExtractedRoom] = []
        for item in roomCatalog {
            guard let range = item.needles.compactMap({ needle -> Range<String.Index>? in
                lower.range(of: needle) ?? text.range(of: needle)
            }).first else { continue }
            let windowEnd = text.index(range.upperBound, offsetBy: 80, limitedBy: text.endIndex) ?? text.endIndex
            let window = String(text[range.lowerBound..<windowEnd]).lowercased()
            found.append(ExtractedRoom(
                name: item.name,
                lighting: window.contains("light"),
                shades: window.contains("shade") || window.contains("blind") || window.contains("遮阳"),
                audio: window.contains("audio") || window.contains("music") || window.contains("音频"),
                cinema: item.name == "Theater" || window.contains("cinema"),
                climate: window.contains("climate") || window.contains("hvac") || window.contains("气候"),
                security: window.contains("security") || window.contains("alarm") || window.contains("安防"),
                note: ""
            ))
        }
        return found
    }

    private static func keys(_ name: String) -> Set<String> {
        var result: Set<String> = []
        let pieces = name.split { $0 == "·" || $0 == "|" }.map { $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() }
        for piece in pieces where !piece.isEmpty {
            result.insert(piece)
            if let alias = roomAlias[piece] { result.insert(alias) }
        }
        let whole = name.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        result.insert(whole)
        if let alias = roomAlias[whole] { result.insert(alias) }
        return result
    }

    private static let roomAlias: [String: String] = [
        "entry": "entry", "foyer": "entry", "门厅": "entry",
        "great room": "great room", "living room": "great room", "起居室": "great room",
        "primary suite": "primary suite", "primary bedroom": "primary suite", "master bedroom": "primary suite", "主卧": "primary suite",
        "kitchen": "kitchen", "厨房": "kitchen",
        "theater": "theater", "theatre": "theater", "home theater": "theater", "影院": "theater", "家庭影院": "theater",
        "terrace": "terrace", "patio": "terrace", "露台": "terrace"
    ]

    private static func firstNumber(in text: String, unit: Bool) -> Double? {
        unit ? squareFeet(in: text) : nil
    }

    private static func firstCapture(_ pattern: String, in text: String) -> String? {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: [.caseInsensitive]) else { return nil }
        let range = NSRange(text.startIndex..., in: text)
        guard let match = regex.firstMatch(in: text, range: range), match.numberOfRanges > 1,
              let hit = Range(match.range(at: 1), in: text) else { return nil }
        return String(text[hit])
    }

    private static func number(_ raw: String) -> Double? {
        Double(raw.replacingOccurrences(of: ",", with: ""))
    }

    private static func jsonBool(_ value: Any?) -> Bool? {
        guard let number = value as? NSNumber else { return nil }
        guard CFGetTypeID(number) == CFBooleanGetTypeID() else { return nil }
        return number.boolValue
    }

    private static func squareFeetValue(_ value: Any?) -> Double? {
        if let number = value as? NSNumber, CFGetTypeID(number) != CFBooleanGetTypeID() {
            let amount = number.doubleValue
            return amount > 0 ? amount : nil
        }
        return nil
    }

    private static func clipped(_ value: Any?) -> String? {
        guard let text = value as? String else { return nil }
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, trimmed.count <= 80, !trimmed.contains("\n") else { return nil }
        return trimmed
    }

    private static func jsonStrings(_ value: Any?) -> [String] {
        guard let rows = value as? [Any] else { return [] }
        return rows.compactMap { item -> String? in
            guard let text = item as? String else { return nil }
            let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
            return trimmed.isEmpty ? nil : String(trimmed.prefix(80))
        }.prefix(12).map { $0 }
    }

    private static func jsonRooms(_ value: Any?) -> [ExtractedRoom] {
        guard let rows = value as? [Any] else { return [] }
        return rows.compactMap { item -> ExtractedRoom? in
            guard let row = item as? [String: Any], let name = clipped(row["name"]) else { return nil }
            let features = Set((row["features"] as? [Any] ?? []).compactMap { $0 as? String }.map { $0.lowercased() })
            func flag(_ key: String, _ words: [String]) -> Bool {
                if jsonBool(row[key]) == true { return true }
                return words.contains { features.contains($0) }
            }
            return ExtractedRoom(
                name: name,
                lighting: flag("lighting", ["lighting", "light"]),
                shades: flag("shades", ["shades", "shading", "blinds"]),
                audio: flag("audio", ["audio"]),
                cinema: flag("cinema", ["cinema", "theater"]),
                climate: flag("climate", ["climate", "hvac"]),
                security: flag("security", ["security"]),
                note: clipped(row["note"]) ?? ""
            )
        }.prefix(24).map { $0 }
    }

    private static func enumValue<T: RawRepresentable>(_ type: T.Type, _ value: Any?) -> T? where T.RawValue == String {
        guard let raw = value as? String else { return nil }
        let trimmed = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        if let parsed = T(rawValue: trimmed) { return parsed }
        if T.self == ControlBrand.self {
            switch trimmed.lowercased() {
            case "control4": return ControlBrand.control4 as? T
            case "crestron": return ControlBrand.crestron as? T
            case "savant": return ControlBrand.savant as? T
            default: break
            }
        }
        return T(rawValue: trimmed.lowercased())
    }
}
