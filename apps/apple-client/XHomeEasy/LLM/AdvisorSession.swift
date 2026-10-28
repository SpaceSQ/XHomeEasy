import Foundation
import XHomeEasyEngines

struct AdvisorTurn: Sendable {
    var text: String
    var citations: [AdvisorCitation]
    var aiGenerated: Bool
    var design: DesignApplication?
}

/// Local prose when a weight is loaded. The fixed advisor remains the fallback and the citation source.
@MainActor
enum AdvisorSession {
    static func reply(query: String, chinese: Bool, documents: [AdvisorDocument], history: [ChatLine], slots: HouseSlotState) async -> AdvisorTurn {
        AppLanguage.resolved = chinese ? .zh : .en
        let engine = AdvisorEngine.reply(query: query, documents: documents)
        if engine.refused {
            return AdvisorTurn(text: engine.text.text(chinese: chinese), citations: [], aiGenerated: false, design: nil)
        }
        let design = await extraction(for: query, slots: slots)
        let controller = LocalLLMController.shared
        let long = query.count >= 160
        guard controller.runtimeReady, long || engine.unknown else {
            return AdvisorTurn(text: engine.text.text(chinese: chinese), citations: engine.citations, aiGenerated: false, design: design)
        }
        do {
            let prior = history.suffix(6).map { line in
                ChatTurn(role: line.isUser ? .user : .assistant, content: line.text)
            }
            var turns = Array(prior)
            if turns.last?.role != .user || turns.last?.content != query {
                turns.append(ChatTurn(role: .user, content: query))
            }
            let raw = try await controller.complete(
                system: chatSystem(chinese: chinese, notes: notes(engine: engine, documents: documents)),
                turns: turns,
                maxTokens: 320,
                temperature: 0.6
            )
            let cleaned = raw.trimmingCharacters(in: .whitespacesAndNewlines)
            if cleaned.isEmpty || AdvisorEngine.isSafetyViolation(cleaned) {
                return AdvisorTurn(text: engine.text.text(chinese: chinese), citations: engine.citations, aiGenerated: false, design: design)
            }
            return AdvisorTurn(text: cleaned, citations: engine.citations, aiGenerated: true, design: design)
        } catch {
            return AdvisorTurn(text: engine.text.text(chinese: chinese), citations: engine.citations, aiGenerated: false, design: design)
        }
    }

    private static func extraction(for query: String, slots: HouseSlotState) async -> DesignApplication? {
        guard DesignExtract.shouldExtract(query) else { return nil }
        let base = DesignExtract.read(query)
        let controller = LocalLLMController.shared
        guard controller.runtimeReady else {
            let applied = DesignExtract.apply(facts: base, onto: slots, fromModel: false)
            return applied.filledSlots.isEmpty && applied.addedRooms.isEmpty ? nil : applied
        }
        do {
            let raw = try await controller.complete(
                system: extractionSystem,
                turns: [ChatTurn(role: .user, content: query)],
                maxTokens: 480,
                temperature: 0.1
            )
            guard let parsed = DesignExtract.parseModelJSON(raw) else {
                let applied = DesignExtract.apply(facts: base, onto: slots, fromModel: false)
                return applied.filledSlots.isEmpty && applied.addedRooms.isEmpty ? nil : applied
            }
            let merged = DesignExtract.merge(base: base, model: parsed)
            let usedModel = !merged.filledSlots.isEmpty || !merged.disagreements.isEmpty
            return DesignExtract.apply(facts: merged.facts, onto: slots, disagreements: merged.disagreements, fromModel: usedModel)
        } catch {
            let applied = DesignExtract.apply(facts: base, onto: slots, fromModel: false)
            return applied.filledSlots.isEmpty && applied.addedRooms.isEmpty ? nil : applied
        }
    }

    private static func notes(engine: AdvisorReply, documents: [AdvisorDocument]) -> String {
        var lines: [String] = []
        if !engine.unknown {
            lines.append("Sourced advisor note, English: \(engine.text.en)")
            lines.append("Sourced advisor note, Chinese: \(engine.text.zh)")
        }
        for citation in engine.citations.prefix(4) {
            guard let document = documents.first(where: { $0.id == citation.id }) else { continue }
            let body = String(document.text.prefix(500))
            lines.append("[\(document.tier)] \(document.title): \(body)")
        }
        if lines.isEmpty {
            return "The offline library has no sourced card for this. Do not invent a specification, a price, or a brand ranking."
        }
        return lines.joined(separator: "\n\n")
    }

    private static func chatSystem(chinese: Bool, notes: String) -> String {
        let language = chinese ? "Chinese" : "English"
        return """
        You are X Home Easy, an advisor for a North American luxury wired home. The control hosts in view are Control4, Crestron, and Savant. Lighting is often Lutron. You suggest only.
        Reply in \(language), in plain sentences. Do not open with a stock phrase, and do not describe yourself as an assistant.
        Never give DIY mains wiring, breaker-panel landing steps, load-center work, or a dealer-software bypass.
        Do not invent a specification, an exact price, or an installer rating. When notes are attached, stay inside them. If they do not cover the question, say the offline library has no sourced answer and you will not guess a specification.
        A control suggestion is not an order.
        Notes:
        \(notes)
        """
    }

    private static let extractionSystem = """
    You extract a North American luxury wired-home brief for Control4, Crestron, Savant, and Lutron planning.
    Reply with one JSON object and no other text. Use null when the text does not say it. Do not invent numbers, prices, brands, or rooms.
    Fields: sqft (under3000|ft3000to5000|ft5000to8000|over8000|null), areaSqft (number|null), areaSqm (number|null), stage (new_build_pre_drywall|major_renovation|retrofit_existing|inherited_home|null), rackRoom (boolean|null), budget (under25k|k25to75|k75to150|k150plus|unstated|null), cinema, multiRoomAudio, shades, pool, hvacZones, children, pets, largeGarden, elderCare, simpleAlarmOnly, multiBuilding, outdoorLiving, hospitality, energyPriority, drywallUnconfirmed (boolean|null), legacy (none|appleHome|matter|control4|crestron|savant|lutron|null), preferredControl (Control4|Crestron|Savant|null), keypad (open|basalte|null), city, state, zip (no street address), rooms (array of {name, lighting, shades, audio, cinema, climate, security, note}), constraints (short strings).
    legacy is a system already in the house. preferredControl is only what they ask to consider. Do not include wiring steps, panel schedules, dealer-tool bypasses, exact bids, or installer ratings.
    """
}
