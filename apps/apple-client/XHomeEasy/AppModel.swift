import AuthenticationServices
import Foundation
import SwiftData
import XHomeEasyEngines

@Model
final class EstateProject {
    var ownerID: String = ""
    var payload: String
    var updatedAt: Date

    init(ownerID: String, payload: String, updatedAt: Date = .now) {
        self.ownerID = ownerID
        self.payload = payload
        self.updatedAt = updatedAt
    }
}

struct AppleProfile: Codable, Equatable {
    var userID: String
    var fullName: String
    var email: String
}

struct AppleDirectory: Codable {
    var activeUserID: String? = nil
    var profiles: [String: AppleProfile] = [:]
}

struct RoomCard: Codable, Identifiable, Hashable {
    var id: UUID
    var name: String
    var lighting: Bool
    var shades: Bool
    var audio: Bool
    var cinema: Bool
    var climate: Bool
    var security: Bool
    var note: String
    var photoPath: String?
    var aiGenerated: Bool

    private enum CodingKeys: String, CodingKey {
        case id, name, lighting, shades, audio, cinema, climate, security, note, photoPath, aiGenerated
    }

    init(id: UUID, name: String, lighting: Bool, shades: Bool, audio: Bool, cinema: Bool, climate: Bool, security: Bool, note: String, photoPath: String?, aiGenerated: Bool = false) {
        self.id = id
        self.name = name
        self.lighting = lighting
        self.shades = shades
        self.audio = audio
        self.cinema = cinema
        self.climate = climate
        self.security = security
        self.note = note
        self.photoPath = photoPath
        self.aiGenerated = aiGenerated
    }

    init(from decoder: Decoder) throws {
        let box = try decoder.container(keyedBy: CodingKeys.self)
        id = try box.decode(UUID.self, forKey: .id)
        name = try box.decode(String.self, forKey: .name)
        lighting = try box.decode(Bool.self, forKey: .lighting)
        shades = try box.decode(Bool.self, forKey: .shades)
        audio = try box.decode(Bool.self, forKey: .audio)
        cinema = try box.decode(Bool.self, forKey: .cinema)
        climate = try box.decode(Bool.self, forKey: .climate)
        security = try box.decode(Bool.self, forKey: .security)
        note = try box.decode(String.self, forKey: .note)
        photoPath = try box.decodeIfPresent(String.self, forKey: .photoPath)
        aiGenerated = try box.decodeIfPresent(Bool.self, forKey: .aiGenerated) ?? false
    }

    func encode(to encoder: Encoder) throws {
        var box = encoder.container(keyedBy: CodingKeys.self)
        try box.encode(id, forKey: .id)
        try box.encode(name, forKey: .name)
        try box.encode(lighting, forKey: .lighting)
        try box.encode(shades, forKey: .shades)
        try box.encode(audio, forKey: .audio)
        try box.encode(cinema, forKey: .cinema)
        try box.encode(climate, forKey: .climate)
        try box.encode(security, forKey: .security)
        try box.encode(note, forKey: .note)
        try box.encodeIfPresent(photoPath, forKey: .photoPath)
        try box.encode(aiGenerated, forKey: .aiGenerated)
    }

    static func starter() -> [RoomCard] {
        [
            RoomCard(id: UUID(), name: "门厅 · Entry", lighting: true, shades: false, audio: false, cinema: false, climate: false, security: true, note: "", photoPath: nil),
            RoomCard(id: UUID(), name: "起居室 · Great Room", lighting: true, shades: true, audio: true, cinema: false, climate: true, security: false, note: "", photoPath: nil),
            RoomCard(id: UUID(), name: "主卧 · Primary Suite", lighting: true, shades: true, audio: true, cinema: false, climate: true, security: false, note: "", photoPath: nil),
            RoomCard(id: UUID(), name: "厨房 · Kitchen", lighting: true, shades: false, audio: true, cinema: false, climate: false, security: false, note: "", photoPath: nil),
            RoomCard(id: UUID(), name: "影院 · Theater", lighting: true, shades: true, audio: true, cinema: true, climate: true, security: false, note: "", photoPath: nil),
            RoomCard(id: UUID(), name: "露台 · Terrace", lighting: true, shades: false, audio: true, cinema: false, climate: false, security: true, note: "", photoPath: nil),
        ]
    }
}

struct ConsultDraft: Codable, Hashable {
    var sqft: SqftBand?
    var stage: BuildStage?
    var rackRoom: Bool?
    var budget: BudgetBand?
    var cinema = false
    var multiRoomAudio = false
    var shades = false
    var pool = false
    var hvacZones = false
    var legacy: LegacySystem?
    var children = false
    var pets = false
    var largeGarden = false
    var elderCare = false
    var simpleAlarmOnly = false
    var multiBuilding = false
    var outdoorLiving = false
    var hospitality = false
    var energyPriority = false
    var keypad: KeypadSpec = .open
    var drywallUnconfirmed = false
    var step = 0
    var installedSystemNote: String?

    var intake: Intake? {
        guard let sqft, let stage, let rackRoom, let budget, let legacy else { return nil }
        return Intake(
            sqft: sqft,
            stage: stage,
            rackRoom: rackRoom,
            budget: budget,
            cinema: cinema,
            multiRoomAudio: multiRoomAudio,
            shades: shades,
            pool: pool,
            hvacZones: hvacZones,
            legacy: legacy,
            children: children,
            pets: pets,
            largeGarden: largeGarden,
            elderCare: elderCare,
            simpleAlarmOnly: simpleAlarmOnly,
            multiBuilding: multiBuilding,
            outdoorLiving: outdoorLiving,
            hospitality: hospitality,
            energyPriority: energyPriority,
            keypad: keypad,
            drywallUnconfirmed: drywallUnconfirmed
        )
    }
}

enum DealStatus: String, Codable {
    case draft, published, quoting, awarded, handoverComplete
}

struct ChatLine: Codable, Identifiable, Hashable {
    var id: UUID
    var isUser: Bool
    var text: String
    var citations: [AdvisorCitation]
    var aiGenerated: Bool

    private enum CodingKeys: String, CodingKey {
        case id, isUser, text, citations, aiGenerated
    }

    init(id: UUID, isUser: Bool, text: String, citations: [AdvisorCitation], aiGenerated: Bool = false) {
        self.id = id
        self.isUser = isUser
        self.text = text
        self.citations = citations
        self.aiGenerated = aiGenerated
    }

    init(from decoder: Decoder) throws {
        let box = try decoder.container(keyedBy: CodingKeys.self)
        id = try box.decode(UUID.self, forKey: .id)
        isUser = try box.decode(Bool.self, forKey: .isUser)
        text = try box.decode(String.self, forKey: .text)
        citations = try box.decodeIfPresent([AdvisorCitation].self, forKey: .citations) ?? []
        aiGenerated = try box.decodeIfPresent(Bool.self, forKey: .aiGenerated) ?? false
    }

    func encode(to encoder: Encoder) throws {
        var box = encoder.container(keyedBy: CodingKeys.self)
        try box.encode(id, forKey: .id)
        try box.encode(isUser, forKey: .isUser)
        try box.encode(text, forKey: .text)
        try box.encode(citations, forKey: .citations)
        try box.encode(aiGenerated, forKey: .aiGenerated)
    }
}

struct LegacyRetrofitItem: Codable, Identifiable, Hashable {
    var id: String
    var name: String
    var advice: String
    var bridge: String
    var tier: String
    var sourceURL: String
    var lineVoltage: Bool
}

struct ProjectSnapshot: Codable {
    var chinese: Bool
    var consult: ConsultDraft
    var rooms: [RoomCard]
    var tier: PackageTier
    var controlOverride: ControlBrand?
    var city: String
    var state: String
    var zip: String
    var quotes: [QuoteInput]
    var checkedHandover: [String]
    var handoverUnderstood: Bool
    var selectedQuoteID: String?
    var status: DealStatus
    var stageDone: [String]
    var subscriptionChecks: [String]
    var inheritedChecks: [String]
    var chat: [ChatLine]
    var claimInterests: [String]
    var legacyRetrofits: [LegacyRetrofitItem]?
    var aiFilledSlots: [String]? = nil
    var designConstraints: [String]? = nil
    var designDisagreements: [String]? = nil
    var designFromModel: Bool? = nil
}

@MainActor
@Observable
final class AppModel {
    var chinese = false
    var consult = ConsultDraft()
    var rooms = RoomCard.starter()
    var tier: PackageTier = .better
    var controlOverride: ControlBrand?
    var city = ""
    var stateCode = "CA"
    var zip = ""
    var quotes: [QuoteInput] = []
    var checkedHandover: Set<String> = []
    var handoverUnderstood = false
    var selectedQuoteID: String?
    var status: DealStatus = .draft
    var stageDone: Set<String> = []
    var subscriptionChecks: Set<String> = []
    var inheritedChecks: Set<String> = []
    var chat: [ChatLine] = []
    var claimInterests: Set<String> = []
    var aiFilledSlots: [String] = []
    var designConstraints: [String] = []
    var designDisagreements: [String] = []
    var designFromModel = false
    var advisorBusy = false
    var hiddenDemoIDs: Set<String> = []
    var activeDemoID: String?
    var referenceCaseID: String?
    var studioTab: StudioTab = .advisor
    var sketch = Data()
    var library: Library?
    var libraryError: String?
    var radarMatcher: RadarMatcher?
    var legacyRetrofits: [LegacyRetrofitItem]?
    var rfqURL: URL?
    var directory = AppleDirectory()
    var accountReady = false
    var cover: AppCover?
    var dockTick = 0
    var authError: String?

    var signedIn: Bool { directory.activeUserID != nil }

    var currentProfile: AppleProfile? {
        guard let id = directory.activeUserID else { return nil }
        return directory.profiles[id]
    }

    private var context: ModelContext?
    private var attached = false
    private static let directoryKey = "xhomeeasy.appleDirectory"
    private static let deviceChineseKey = "xhomeeasy.deviceChinese"
    private static let hiddenDemoKey = "xhomeeasy.hiddenDemoIDs"
    private static let referenceCaseKey = "xhomeeasy.referenceCaseID"

    private func setReference(_ id: String?) {
        referenceCaseID = id
        guard let userID = directory.activeUserID else { return }
        let key = Self.referenceCaseKey + "." + userID
        if let id {
            UserDefaults.standard.set(id, forKey: key)
        } else {
            UserDefaults.standard.removeObject(forKey: key)
        }
    }

    func completeSignIn(userID: String, fullName: String, email: String) {
        var profile = directory.profiles[userID] ?? AppleProfile(userID: userID, fullName: "", email: "")
        if !fullName.isEmpty { profile.fullName = fullName }
        if !email.isEmpty { profile.email = email }
        directory.profiles[userID] = profile
        directory.activeUserID = userID
        persistDirectory()
        loadAccountData()
        authError = nil
    }

    func signOut() {
        save()
        directory.activeUserID = nil
        persistDirectory()
        clearWorkingCopy()
        cover = nil
        studioTab = .advisor
        dockTick += 1
    }

    func deleteAccount() {
        guard let userID = directory.activeUserID, let context else { return }
        for room in rooms {
            if let path = room.photoPath {
                try? FileManager.default.removeItem(atPath: path)
            }
        }
        let rows = (try? context.fetch(FetchDescriptor<EstateProject>())) ?? []
        for row in rows where row.ownerID == userID {
            context.delete(row)
        }
        try? context.save()
        directory.profiles[userID] = nil
        directory.activeUserID = nil
        persistDirectory()
        UserDefaults.standard.removeObject(forKey: Self.hiddenDemoKey + "." + userID)
        UserDefaults.standard.removeObject(forKey: Self.referenceCaseKey + "." + userID)
        clearWorkingCopy()
        chinese = false
        UserDefaults.standard.set(false, forKey: Self.deviceChineseKey)
        WebsiteAccountStore.clear()
        WebsiteSession.clear()
        cover = nil
        studioTab = .advisor
        dockTick += 1
    }

    func openHome() {
        if signedIn { save() }
        studioTab = .advisor
        cover = nil
        dockTick += 1
    }

    func openSettings() {
        if signedIn { save() }
        cover = .settings
        dockTick += 1
    }

    func openHelp() {
        cover = .help
        dockTick += 1
    }

    private func loadAccountData() {
        guard let userID = directory.activeUserID else { return }
        let hiddenKey = Self.hiddenDemoKey + "." + userID
        if let stored = UserDefaults.standard.stringArray(forKey: hiddenKey) {
            hiddenDemoIDs = Set(stored)
        } else if let legacy = UserDefaults.standard.stringArray(forKey: Self.hiddenDemoKey) {
            hiddenDemoIDs = Set(legacy)
        } else {
            hiddenDemoIDs = []
        }
        referenceCaseID = UserDefaults.standard.string(forKey: Self.referenceCaseKey + "." + userID)
            ?? UserDefaults.standard.string(forKey: Self.referenceCaseKey)
        guard let context else { return }
        let rows = (try? context.fetch(FetchDescriptor<EstateProject>())) ?? []
        if let row = rows.first(where: { $0.ownerID == userID }),
           let snapshot = decode(row.payload) {
            apply(snapshot)
        } else if rows.count == 1, rows[0].ownerID.isEmpty, let snapshot = decode(rows[0].payload) {
            rows[0].ownerID = userID
            try? context.save()
            apply(snapshot)
        } else {
            clearWorkingCopy()
        }
    }

    private func refreshCredential() {
        guard let userID = directory.activeUserID else { return }
        ASAuthorizationAppleIDProvider().getCredentialState(forUserID: userID) { state, _ in
            Task { @MainActor in
                if state != .authorized, self.directory.activeUserID == userID {
                    self.signOut()
                }
            }
        }
    }

    private func clearWorkingCopy() {
        consult = ConsultDraft()
        rooms = RoomCard.starter()
        tier = .better
        controlOverride = nil
        city = ""
        stateCode = "CA"
        zip = ""
        quotes = []
        checkedHandover = []
        handoverUnderstood = false
        selectedQuoteID = nil
        status = .draft
        stageDone = []
        subscriptionChecks = []
        inheritedChecks = []
        chat = []
        claimInterests = []
        aiFilledSlots = []
        designConstraints = []
        designDisagreements = []
        designFromModel = false
        advisorBusy = false
        hiddenDemoIDs = []
        activeDemoID = nil
        referenceCaseID = nil
        sketch = Data()
        rfqURL = nil
        legacyRetrofits = nil
    }

    private func decode(_ payload: String) -> ProjectSnapshot? {
        guard let data = payload.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(ProjectSnapshot.self, from: data)
    }

    private func persistDirectory() {
        if let data = try? JSONEncoder().encode(directory) {
            UserDefaults.standard.set(data, forKey: Self.directoryKey)
        }
    }

    private static func readDirectory() -> AppleDirectory {
        guard let data = UserDefaults.standard.data(forKey: directoryKey),
              let directory = try? JSONDecoder().decode(AppleDirectory.self, from: data) else {
            return AppleDirectory()
        }
        return directory
    }

    func t(_ zh: String, _ en: String) -> String { chinese ? zh : en }

    var intake: Intake? { consult.intake }

    var adaptation: AdaptationResult? {
        guard let intake else { return nil }
        return AdaptationScorer.score(intake)
    }

    var topology: TopologyPlan? {
        guard let intake else { return nil }
        return TopologyBuilder.build(intake, tier: tier, controlOverride: controlOverride)
    }

    var budget: BudgetReport? {
        guard let intake, let topology else { return nil }
        return BudgetEngine.calculate(intake, tier: tier, brand: topology.controlBrand)
    }

    var handoverBrands: [String] {
        guard let topology, let intake else { return ["Lutron"] }
        if intake.hospitality { return [] }
        if intake.keypad == .basalte { return [topology.controlBrand.rawValue] }
        return [topology.controlBrand.rawValue, "Lutron"]
    }

    var handoverItems: [HandoverItem] { HandoverGuard.items(for: handoverBrands) }

    var handoverReady: Bool {
        if intake?.hospitality == true { return false }
        return HandoverGuard.isComplete(brands: handoverBrands, checkedIds: checkedHandover)
    }

    var comparison: QuoteComparison? {
        guard let intake, !quotes.isEmpty else { return nil }
        return QuoteComparator.compare(quotes, intake: intake, tier: tier)
    }

    func attach(_ context: ModelContext) {
        guard !attached else { return }
        attached = true
        self.context = context
        if UserDefaults.standard.object(forKey: Self.deviceChineseKey) != nil {
            chinese = UserDefaults.standard.bool(forKey: Self.deviceChineseKey)
        }
        directory = Self.readDirectory()
        loadLibrary()
        if directory.activeUserID != nil {
            loadAccountData()
            refreshCredential()
        }
        accountReady = true
    }

    func loadLibrary() {
        do {
            let loaded = try LibraryLoader.load()
            library = loaded
            radarMatcher = RadarMatcher(index: loaded.radarIndex, records: loaded.radarRecords)
            libraryError = nil
        } catch {
            library = nil
            radarMatcher = nil
            libraryError = error.localizedDescription
        }
    }

    func save() {
        guard let context, let userID = directory.activeUserID else { return }
        UserDefaults.standard.set(chinese, forKey: Self.deviceChineseKey)
        let snapshot = ProjectSnapshot(
            chinese: chinese,
            consult: consult,
            rooms: rooms,
            tier: tier,
            controlOverride: controlOverride,
            city: city,
            state: stateCode,
            zip: zip,
            quotes: quotes,
            checkedHandover: Array(checkedHandover),
            handoverUnderstood: handoverUnderstood,
            selectedQuoteID: selectedQuoteID,
            status: status,
            stageDone: Array(stageDone),
            subscriptionChecks: Array(subscriptionChecks),
            inheritedChecks: Array(inheritedChecks),
            chat: chat,
            claimInterests: Array(claimInterests),
            legacyRetrofits: legacyRetrofits,
            aiFilledSlots: aiFilledSlots,
            designConstraints: designConstraints,
            designDisagreements: designDisagreements,
            designFromModel: designFromModel
        )
        guard let data = try? JSONEncoder().encode(snapshot), let text = String(data: data, encoding: .utf8) else { return }
        let rows = (try? context.fetch(FetchDescriptor<EstateProject>())) ?? []
        if let row = rows.first(where: { $0.ownerID == userID }) {
            row.payload = text
            row.updatedAt = .now
        } else {
            context.insert(EstateProject(ownerID: userID, payload: text))
        }
        try? context.save()
        UserDefaults.standard.set(Array(hiddenDemoIDs), forKey: Self.hiddenDemoKey + "." + userID)
    }

    func apply(_ snapshot: ProjectSnapshot) {
        chinese = snapshot.chinese
        consult = snapshot.consult
        rooms = snapshot.rooms
        tier = snapshot.tier
        controlOverride = snapshot.controlOverride
        city = snapshot.city
        stateCode = snapshot.state
        zip = snapshot.zip
        quotes = snapshot.quotes
        checkedHandover = Set(snapshot.checkedHandover)
        handoverUnderstood = snapshot.handoverUnderstood
        selectedQuoteID = snapshot.selectedQuoteID
        status = snapshot.status
        stageDone = Set(snapshot.stageDone)
        subscriptionChecks = Set(snapshot.subscriptionChecks)
        inheritedChecks = Set(snapshot.inheritedChecks)
        chat = snapshot.chat
        claimInterests = Set(snapshot.claimInterests)
        legacyRetrofits = snapshot.legacyRetrofits
        aiFilledSlots = snapshot.aiFilledSlots ?? []
        designConstraints = snapshot.designConstraints ?? []
        designDisagreements = snapshot.designDisagreements ?? []
        designFromModel = snapshot.designFromModel ?? false
    }

    func hideDemo(_ id: String) {
        hiddenDemoIDs.insert(id)
        if activeDemoID == id { activeDemoID = nil }
        if referenceCaseID == id { setReference(nil) }
        if let userID = directory.activeUserID {
            UserDefaults.standard.set(Array(hiddenDemoIDs), forKey: Self.hiddenDemoKey + "." + userID)
        }
    }

    func restoreDemos() {
        hiddenDemoIDs = []
        if let userID = directory.activeUserID {
            UserDefaults.standard.removeObject(forKey: Self.hiddenDemoKey + "." + userID)
        }
    }

    var referenceCaseTitle: String? {
        ShowcaseLibrary.all.first { $0.id == referenceCaseID }?.title
    }

    func applyReference(_ sample: ShowcaseCase, draft: ConsultDraft, note: String, useCaseRooms: Bool) {
        var next = draft
        next.step = 6
        consult = next
        if useCaseRooms {
            rooms = sample.makeRooms()
        }
        let trimmed = note.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmed.isEmpty {
            rooms.append(RoomCard(id: UUID(), name: t("我的想法", "My note"), lighting: false, shades: false, audio: false, cinema: false, climate: false, security: false, note: trimmed, photoPath: nil))
        }
        controlOverride = nil
        quotes = []
        checkedHandover = []
        handoverUnderstood = false
        selectedQuoteID = nil
        status = .draft
        activeDemoID = nil
        setReference(sample.id)
        studioTab = .advisor
        save()
    }

    func resetConsult() {
        activeDemoID = nil
        setReference(nil)
        consult = ConsultDraft()
        handoverUnderstood = false
        status = .draft
        aiFilledSlots = []
        designConstraints = []
        designDisagreements = []
        designFromModel = false
        save()
    }

    func advanceConsult() {
        consult.step = min(consult.step + 1, 6)
        if consult.step == 6 { status = .draft }
        save()
    }

    func radarHits(for text: String) -> [RadarHit] {
        radarMatcher?.scan(text) ?? []
    }

    func containsLegacy(_ id: String) -> Bool {
        legacyRetrofits?.contains { $0.id == id } ?? false
    }

    func addLegacyRetrofit(_ record: RadarRecord) {
        guard record.kind == "wired" else { return }
        var items = legacyRetrofits ?? []
        guard !items.contains(where: { $0.id == record.id }) else { return }
        items.append(LegacyRetrofitItem(
            id: record.id,
            name: record.brandOrProtocolName,
            advice: record.actionAdvice,
            bridge: record.fourGiantBridge,
            tier: record.evidenceTier,
            sourceURL: record.sources.first?.url ?? "",
            lineVoltage: KeywordRadarEngine.requiresLicensedElectrician(record)
        ))
        legacyRetrofits = items
        save()
    }

    func removeLegacyRetrofit(_ id: String) {
        let items = (legacyRetrofits ?? []).filter { $0.id != id }
        legacyRetrofits = items.isEmpty ? nil : items
        save()
    }

    func ask(_ query: String) {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, !advisorBusy else { return }
        chat.append(ChatLine(id: UUID(), isUser: true, text: trimmed, citations: []))
        advisorBusy = true
        let documents = advisorDocuments()
        let history = chat
        let slots = houseSlots()
        let chinese = self.chinese
        Task {
            let turn = await AdvisorSession.reply(query: trimmed, chinese: chinese, documents: documents, history: history, slots: slots)
            advisorBusy = false
            chat.append(ChatLine(id: UUID(), isUser: false, text: turn.text, citations: turn.citations, aiGenerated: turn.aiGenerated))
            if let design = turn.design {
                applyDesign(design)
            }
            save()
        }
    }

    private func houseSlots() -> HouseSlotState {
        HouseSlotState(
            sqft: consult.sqft,
            stage: consult.stage,
            rackRoom: consult.rackRoom,
            budget: consult.budget,
            cinema: consult.cinema,
            multiRoomAudio: consult.multiRoomAudio,
            shades: consult.shades,
            pool: consult.pool,
            hvacZones: consult.hvacZones,
            legacy: consult.legacy,
            children: consult.children,
            pets: consult.pets,
            largeGarden: consult.largeGarden,
            elderCare: consult.elderCare,
            simpleAlarmOnly: consult.simpleAlarmOnly,
            multiBuilding: consult.multiBuilding,
            outdoorLiving: consult.outdoorLiving,
            hospitality: consult.hospitality,
            energyPriority: consult.energyPriority,
            keypad: consult.keypad,
            drywallUnconfirmed: consult.drywallUnconfirmed,
            featureChoicesLocked: consult.step >= 5,
            city: city,
            stateCode: stateCode,
            zip: zip,
            controlOverride: controlOverride,
            roomNames: rooms.map(\.name),
            step: consult.step
        )
    }

    private func applyDesign(_ design: DesignApplication) {
        let slots = design.slots
        consult.sqft = slots.sqft
        consult.stage = slots.stage
        consult.rackRoom = slots.rackRoom
        consult.budget = slots.budget
        consult.cinema = slots.cinema
        consult.multiRoomAudio = slots.multiRoomAudio
        consult.shades = slots.shades
        consult.pool = slots.pool
        consult.hvacZones = slots.hvacZones
        consult.legacy = slots.legacy
        consult.children = slots.children
        consult.pets = slots.pets
        consult.largeGarden = slots.largeGarden
        consult.elderCare = slots.elderCare
        consult.simpleAlarmOnly = slots.simpleAlarmOnly
        consult.multiBuilding = slots.multiBuilding
        consult.outdoorLiving = slots.outdoorLiving
        consult.hospitality = slots.hospitality
        consult.energyPriority = slots.energyPriority
        consult.keypad = slots.keypad
        consult.drywallUnconfirmed = slots.drywallUnconfirmed
        consult.step = max(consult.step, slots.step)
        if (consult.installedSystemNote ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
           let legacy = slots.legacy, legacy != LegacySystem.none {
            consult.installedSystemNote = legacy.rawValue
        }
        if controlOverride == nil {
            controlOverride = slots.controlOverride
        }
        if city.trimmingCharacters(in: .whitespaces).isEmpty { city = slots.city }
        if zip.trimmingCharacters(in: .whitespaces).isEmpty, city == slots.city {
            if stateCode == "CA", !slots.stateCode.isEmpty { stateCode = slots.stateCode }
            zip = slots.zip
        }
        for room in design.enrichedRooms {
            guard let index = rooms.firstIndex(where: { $0.name == room.name }) else { continue }
            if room.lighting { rooms[index].lighting = true }
            if room.shades { rooms[index].shades = true }
            if room.audio { rooms[index].audio = true }
            if room.cinema { rooms[index].cinema = true }
            if room.climate { rooms[index].climate = true }
            if room.security { rooms[index].security = true }
            if rooms[index].note.isEmpty { rooms[index].note = room.note }
        }
        for room in design.addedRooms {
            rooms.append(RoomCard(
                id: UUID(),
                name: room.name,
                lighting: room.lighting,
                shades: room.shades,
                audio: room.audio,
                cinema: room.cinema,
                climate: room.climate,
                security: room.security,
                note: room.note,
                photoPath: nil,
                aiGenerated: true
            ))
        }
        for slot in design.filledSlots where !aiFilledSlots.contains(slot) {
            aiFilledSlots.append(slot)
        }
        for item in design.constraints where !designConstraints.contains(item) {
            designConstraints.append(item)
        }
        for item in design.disagreements where !designDisagreements.contains(item) {
            designDisagreements.append(item)
        }
        if design.fromModel { designFromModel = true }
    }

    func loadSampleQuotes() {
        guard intake != nil else { return }
        let brand = topology?.controlBrand.rawValue ?? "Control4"
        quotes = [
            QuoteInput(id: "sample-a", dealerName: "A · 示例", isSample: true, controlBrand: brand, lightingBrand: "Lutron", hardware: 42_000, prewire: 18_000, labor: 22_000, programmingCost: 16_000, programmingHours: 100, hourlyRate: 160, rackNetwork: 9_000, annualSubscription: 240, subscriptionMandatory: false, handoverAccepted: true, warrantyMonths: 12),
            QuoteInput(id: "sample-b", dealerName: "B · 示例", isSample: true, controlBrand: brand, lightingBrand: "Lutron", hardware: 30_000, prewire: 8_000, labor: 12_000, programmingCost: 4_000, programmingHours: 25, hourlyRate: 160, rackNetwork: 4_000, annualSubscription: 0, subscriptionMandatory: false, handoverAccepted: true, warrantyMonths: 12),
            QuoteInput(id: "sample-c", dealerName: "C · 示例", isSample: true, controlBrand: brand, lightingBrand: "Lutron", hardware: 50_000, prewire: 20_000, labor: 24_000, programmingCost: 22_000, programmingHours: 110, hourlyRate: 200, rackNetwork: 12_000, annualSubscription: 800, subscriptionMandatory: true, handoverAccepted: false, warrantyMonths: 12),
        ]
        status = .quoting
        save()
    }

    func refreshStatus() {
        if handoverUnderstood && handoverReady {
            status = .handoverComplete
        } else if selectedQuoteID != nil {
            status = .awarded
        } else if !quotes.isEmpty {
            status = .quoting
        } else if rfqURL != nil {
            status = .published
        }
    }

    private func advisorDocuments() -> [AdvisorDocument] {
        guard let library else { return [] }
        let fusionDocs = library.fusion.filter { $0.tier != "E4" }.prefix(80).map {
            AdvisorDocument(id: $0.id, title: $0.title, text: "\($0.takeaway) \($0.summary)", tier: $0.tier, url: $0.url)
        }
        let systemDocs = library.subsystems.prefix(80).map {
            AdvisorDocument(id: $0.id, title: $0.title, text: "\($0.fit) \($0.takeaway)", tier: $0.tier, url: $0.url)
        }
        return Array(fusionDocs) + Array(systemDocs)
    }
}
