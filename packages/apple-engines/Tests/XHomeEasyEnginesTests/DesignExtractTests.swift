import Testing
@testable import XHomeEasyEngines

private let house = """
New build in Austin, TX 78701. About 6,500 square feet, drywall still open, dedicated rack room. \
Budget around $90,000. We want Savant. Existing system is none. A theater, whole-home shades, and Lutron lighting. \
Primary suite needs shades and audio. Great room needs lighting and audio.
"""

@Test func fixedReaderKeepsItsNumbersWhenTheModelDisagrees() {
    let base = DesignExtract.read(house)
    #expect(base.sqft == .ft5000to8000)
    #expect(base.budget == .k75to150)
    #expect(base.stage == .newBuildPreDrywall)
    #expect(base.rackRoom == true)
    #expect(base.legacy == LegacySystem.none)
    #expect(base.preferredControl == .savant)
    #expect(base.city == "Austin")
    #expect(base.state == "TX")
    #expect(base.zip == "78701")
    #expect(base.cinema == true)
    #expect(base.shades == true)
    #expect(base.constraints.contains("Lutron named"))
    let model = DesignExtract.parseModelJSON("""
    {"sqft":"under3000","budget":"under25k","shades":true,"pool":true,"rooms":[{"name":"Guest Suite","shades":true}]}
    """)
    #expect(model != nil)
    let merged = DesignExtract.merge(base: base, model: model!)
    #expect(merged.facts.sqft == .ft5000to8000)
    #expect(merged.facts.budget == .k75to150)
    #expect(merged.disagreements.contains("sqft"))
    #expect(merged.disagreements.contains("budget"))
    #expect(merged.facts.pool == true)
    #expect(merged.filledSlots.contains("pool"))
    #expect(merged.facts.rooms.contains { $0.name == "Primary Suite" })
}

@Test func modelFillsSlotsTheReaderLeftEmpty() {
    let base = DesignExtract.read("A listed villa. We care about blinds and heating, and we do not want to pull our own wires.")
    #expect(base.shades == true)
    #expect(base.hvacZones == true)
    #expect(base.sqft == nil)
    let model = DesignExtract.parseModelJSON("""
    {"stage":"major_renovation","sqft":"ft3000to5000","city":"Austin","state":"Texas","rooms":[{"name":"Dining Room","lighting":true,"audio":true}],"constraints":["listed building"]}
    """)
    let merged = DesignExtract.merge(base: base, model: model!)
    #expect(merged.facts.stage == .majorRenovation)
    #expect(merged.facts.sqft == .ft3000to5000)
    #expect(merged.facts.shades == true)
    #expect(merged.facts.city == "Austin")
    #expect(merged.facts.state == "TX")
    #expect(merged.facts.rooms == [ExtractedRoom(name: "Dining Room", lighting: true, audio: true)])
    #expect(merged.facts.constraints.contains("listed building"))
    let applied = DesignExtract.apply(facts: merged.facts, onto: HouseSlotState(roomNames: ["影院 · Theater"]), disagreements: merged.disagreements, fromModel: true)
    #expect(applied.slots.stage == .majorRenovation)
    #expect(applied.slots.shades == true)
    #expect(applied.addedRooms.contains { $0.name == "Dining Room" })
    #expect(applied.slots.city == "Austin")
    #expect(applied.slots.stateCode == "TX")
    #expect(applied.fromModel)
}

@Test func wizardChoiceAndExistingRoomStay() {
    let facts = DesignExtract.read(house)
    var slots = HouseSlotState(sqft: .over8000, roomNames: ["主卧 · Primary Suite"], step: 2)
    slots.featureChoicesLocked = true
    let applied = DesignExtract.apply(facts: facts, onto: slots, fromModel: true)
    #expect(applied.slots.sqft == .over8000)
    #expect(applied.addedRooms.contains { $0.name == "Guest Suite" } == false)
    #expect(applied.enrichedRooms.contains { DesignExtract.sameRoom($0.name, "Primary Suite") })
    #expect(applied.slots.cinema == false)
    #expect(applied.slots.city == "Austin")
    #expect(applied.slots.controlOverride == .savant)
}

@Test func questionsAreNotTreatedAsAHouseDescription() {
    let question = "How does a Control4 owner change dealer?"
    #expect(!DesignExtract.shouldExtract(question))
    let facts = DesignExtract.read(question)
    #expect(facts.legacy == nil)
    #expect(facts.preferredControl == nil)
    #expect(facts.sqft == nil)
    #expect(DesignExtract.parseModelJSON("I am not sure yet.") == nil)
    #expect(DesignExtract.shouldExtract(house))
}

@Test func finishedConsultDoesNotFlipFeatureFlags() {
    let model = WiredDesignFacts(cinema: true, shades: true, legacy: .control4)
    let slots = HouseSlotState(sqft: .ft5000to8000, stage: .newBuildPreDrywall, rackRoom: true, budget: .k75to150, legacy: LegacySystem.none, featureChoicesLocked: true, step: 6)
    let applied = DesignExtract.apply(facts: model, onto: slots)
    #expect(applied.slots.cinema == false)
    #expect(applied.slots.legacy == LegacySystem.none)
    #expect(applied.slots.step == 6)
}
