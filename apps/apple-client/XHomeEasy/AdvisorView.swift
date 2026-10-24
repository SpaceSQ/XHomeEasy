import SwiftUI
import XHomeEasyEngines

struct AdvisorView: View {
    @Environment(AppModel.self) private var model
    @State private var question = ""
    @State private var radarAnchor = ""
    @State private var showGuide = false

    private var radarQuery: String {
        let live = question.trimmingCharacters(in: .whitespacesAndNewlines)
        return live.isEmpty ? radarAnchor : live
    }

    var body: some View {
        PaperScreen(kicker: "X HOME EASY", title: model.t("九十秒，先判断路径", "Ninety seconds to choose a path")) {
            StudioCard {
                Text(model.t(
                    "给不懂专业集成的别墅业主和设计师：这座房子该走有线、零售 Matter，还是混合。排序看匹配和证据，不看佣金。",
                    "For a villa owner or designer who is not an integrator: wired, retail Matter, or a hybrid. Rank by fit and evidence, not by commission."
                ))
                .foregroundStyle(Studio.ink)
                SourceLink(title: model.t("CEDIA 2026：美国住宅科技专业集成约 338 亿美元", "CEDIA 2026: about $33.8B U.S. residential technology integration"), url: "https://www.cepro.com/news/cedia-research-pegs-u-s-residential-tech-market-at-33-8-billion-with-ai-and-skilled-labor-defining-the-year-ahead/628665/")
                EvidenceBadge(tier: "E2")
            }
            Button {
                showGuide = true
            } label: {
                Label(model.t("参照案例，描述我家", "Describe my house from an example"), systemImage: "text.book.closed")
            }
            .buttonStyle(.bordered)
            .tint(Studio.ink)
            .keyboardShortcut("g", modifiers: .command)
            installedSystem
            if model.consult.step < 6 {
                wizard
            } else if let result = model.adaptation {
                resultView(result)
            }
            advisor
        }
        .sheet(isPresented: $showGuide) {
            CaseGuideSheet()
                .environment(model)
        }
    }

    private var installedSystem: some View {
        StudioCard {
            Text(model.t("已有品牌或协议", "A brand or protocol already in the house"))
                .font(.headline)
            Text(model.t("输入名字就会在本机匹配。有线存量会给出桥接建议；无线品牌会说明它不在本 App 的建议范围内。", "A name is matched on this iPhone. A legacy wired system gets a bridge note. A wireless brand is marked as outside this app's advice."))
                .font(.footnote)
                .foregroundStyle(Studio.mist)
            TextField(model.t("例如 X10、SPAN、Matter", "For example: X10, SPAN, Matter"), text: installedNote, axis: .vertical)
                .textFieldStyle(.roundedBorder)
            RadarStack(text: model.consult.installedSystemNote ?? "")
        }
    }

    private var installedNote: Binding<String> {
        Binding(
            get: { model.consult.installedSystemNote ?? "" },
            set: {
                model.consult.installedSystemNote = $0
                model.save()
            }
        )
    }

    private var wizard: some View {
        StudioCard {
            Text(model.t("第 \(model.consult.step + 1) 问，共 6 问", "Question \(model.consult.step + 1) of 6"))
                .font(.caption.weight(.semibold))
                .foregroundStyle(Studio.bronze)
            questionBody
            if model.consult.step == 4 {
                Button(model.t("继续", "Continue")) { model.advanceConsult() }
                    .buttonStyle(.borderedProminent)
                    .tint(Studio.ink)
            }
        }
    }

    @ViewBuilder private var questionBody: some View {
        switch model.consult.step {
        case 0:
            option(model.t("约 280㎡ 以下 / 3,000 平方英尺以下", "Under about 280 m² / 3,000 ft²"), model.consult.sqft == .under3000) { pick { $0.sqft = .under3000 } }
            option(model.t("约 280–460㎡ / 3,000–5,000 平方英尺", "About 280–460 m² / 3,000–5,000 ft²"), model.consult.sqft == .ft3000to5000) { pick { $0.sqft = .ft3000to5000 } }
            option(model.t("约 460–740㎡ / 5,000–8,000 平方英尺", "About 460–740 m² / 5,000–8,000 ft²"), model.consult.sqft == .ft5000to8000) { pick { $0.sqft = .ft5000to8000 } }
            option(model.t("约 740㎡ 以上 / 8,000 平方英尺以上", "Over about 740 m² / 8,000 ft²"), model.consult.sqft == .over8000) { pick { $0.sqft = .over8000 } }
        case 1:
            option(model.t("新建，干墙还没封", "New build, drywall still open"), model.consult.stage == .newBuildPreDrywall) { pick { $0.stage = .newBuildPreDrywall } }
            option(model.t("整屋大翻新", "Major renovation"), model.consult.stage == .majorRenovation) { pick { $0.stage = .majorRenovation } }
            option(model.t("已入住，局部改造", "Occupied retrofit"), model.consult.stage == .retrofitExisting) { pick { $0.stage = .retrofitExisting } }
            option(model.t("接手已有专业系统", "Inherited professional system"), model.consult.stage == .inheritedHome) { pick { $0.stage = .inheritedHome } }
        case 2:
            option(model.t("有独立弱电间或机柜间", "There is a dedicated low-voltage room"), model.consult.rackRoom == true) { pick { $0.rackRoom = true } }
            option(model.t("还没有，要先找地方", "Not yet. A place still has to be found"), model.consult.rackRoom == false) { pick { $0.rackRoom = false } }
        case 3:
            option(model.t("预算还没定", "Budget not stated yet"), model.consult.budget == .unstated) { pick { $0.budget = .unstated } }
            option(model.t("2.5 万美元以下", "Under $25k"), model.consult.budget == .under25k) { pick { $0.budget = .under25k } }
            option(model.t("2.5 万–7.5 万", "$25k–$75k"), model.consult.budget == .k25to75) { pick { $0.budget = .k25to75 } }
            option(model.t("7.5 万–15 万", "$75k–$150k"), model.consult.budget == .k75to150) { pick { $0.budget = .k75to150 } }
            option(model.t("15 万美元以上", "$150k and above"), model.consult.budget == .k150plus) { pick { $0.budget = .k150plus } }
        case 4:
            toggle(model.t("独立影院", "Dedicated theater"), model.consult.cinema) { model.consult.cinema.toggle(); model.save() }
            toggle(model.t("多房间音频", "Multi-room audio"), model.consult.multiRoomAudio) { model.consult.multiRoomAudio.toggle(); model.save() }
            toggle(model.t("全屋电动遮阳", "Whole-home shades"), model.consult.shades) { model.consult.shades.toggle(); model.save() }
            toggle(model.t("泳池或庭院", "Pool or landscape"), model.consult.pool) { model.consult.pool.toggle(); model.save() }
            toggle(model.t("多个暖通温区", "Several HVAC zones"), model.consult.hvacZones) { model.consult.hvacZones.toggle(); model.save() }
            toggle(model.t("有孩子", "Children at home"), model.consult.children) { model.consult.children.toggle(); model.save() }
            toggle(model.t("有宠物", "Pets"), model.consult.pets) { model.consult.pets.toggle(); model.save() }
            toggle(model.t("大花园或露台影音照明", "Large garden or outdoor light and sound"), model.consult.largeGarden) {
                model.consult.largeGarden.toggle()
                model.consult.outdoorLiving = model.consult.largeGarden
                model.save()
            }
            toggle(model.t("适老与健康监护", "Aging in place"), model.consult.elderCare) { model.consult.elderCare.toggle(); model.save() }
            toggle(model.t("只有简单红外报警", "Only a simple infrared alarm"), model.consult.simpleAlarmOnly) { model.consult.simpleAlarmOnly.toggle(); model.save() }
            toggle(model.t("多幢住宅", "More than one residence"), model.consult.multiBuilding) { model.consult.multiBuilding.toggle(); model.save() }
            toggle(model.t("这是酒店客房，不是别墅", "This is a hotel, not a house"), model.consult.hospitality) { model.consult.hospitality.toggle(); model.save() }
            toggle(model.t("低碳 / 能源管理是目标", "Low-carbon energy management matters"), model.consult.energyPriority) { model.consult.energyPriority.toggle(); model.save() }
            toggle(model.t("墙面已指定巴萨面板", "Basalte keypads are specified"), model.consult.keypad == .basalte) { model.consult.keypad = model.consult.keypad == .basalte ? .open : .basalte; model.save() }
        default:
            option("Apple Home", model.consult.legacy == .appleHome) { pick { $0.legacy = .appleHome } }
            option("Matter", model.consult.legacy == .matter) { pick { $0.legacy = .matter } }
            option("Control4", model.consult.legacy == .control4) { pick { $0.legacy = .control4 } }
            option("Crestron", model.consult.legacy == .crestron) { pick { $0.legacy = .crestron } }
            option("Savant", model.consult.legacy == .savant) { pick { $0.legacy = .savant } }
            option("Lutron", model.consult.legacy == .lutron) { pick { $0.legacy = .lutron } }
            option(model.t("都还没有", "None of these yet"), model.consult.legacy == LegacySystem.none) { pick { $0.legacy = LegacySystem.none } }
        }
    }

    private func option(_ title: String, _ selected: Bool, _ action: @escaping () -> Void) -> some View {
        ChoiceButton(title: title, selected: selected, action: action)
    }

    private func toggle(_ title: String, _ selected: Bool, _ action: @escaping () -> Void) -> some View {
        ChoiceButton(title: title, selected: selected, action: action)
    }

    private func pick(_ change: (inout ConsultDraft) -> Void) {
        change(&model.consult)
        model.advanceConsult()
    }

    private func resultView(_ result: AdaptationResult) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            if let title = model.referenceCaseTitle {
                Text(model.t("下面是你自己的答案。参照了「\(title)」。", "These are your answers, written with “\(title)” as the reference."))
                    .font(.footnote)
                    .foregroundStyle(Studio.bronze)
            }
            if !result.residentialModelApplies, let note = result.scopeNote {
                StudioCard {
                    Text(note.text(chinese: model.chinese)).font(.headline)
                    ForEach(Array(result.briefNotes.enumerated()), id: \.offset) { _, line in
                        Text(line.text(chinese: model.chinese)).font(.subheadline)
                    }
                }
            }
            if result.residentialModelApplies {
            Text(model.t("三条路径同时给出，不只亮一盏灯。", "All three paths stay visible. One light is not the whole answer."))
                .font(.subheadline)
                .foregroundStyle(Studio.mist)
            ForEach(result.paths, id: \.kind) { path in
                StudioCard {
                    HStack {
                        Text(pathName(path.kind)).font(.headline)
                        Spacer()
                        SignalMark(light: path.light, chinese: model.chinese)
                        Text("\(path.score)")
                            .font(.caption.monospacedDigit())
                            .foregroundStyle(Studio.mist)
                    }
                    if path.kind == result.primary {
                        Text(model.t("当前主路径", "Current lead path"))
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(Studio.forest)
                    }
                    ForEach(Array(path.reasons.enumerated()), id: \.offset) { _, reason in
                        Text(reason.text(chinese: model.chinese))
                            .font(.subheadline)
                            .foregroundStyle(Studio.ink)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            }
            if result.residentialModelApplies {
            ForEach(Array(result.briefNotes.enumerated()), id: \.offset) { _, note in
                Text(note.text(chinese: model.chinese))
                    .font(.footnote)
                    .foregroundStyle(Studio.ink)
            }
            }
            if result.prewireWindow {
                StudioCard {
                    Text(model.t("干墙封闭前的布线窗口", "Pre-wire window, before drywall"))
                        .font(.headline)
                    Text(model.t("现在还来得及跟总包冻结弱电路径。本页只提醒工期，不说明怎么穿线。", "There is still time to freeze low-voltage pathways with the builder. This is a schedule reminder, not a cable-pulling guide."))
                }
            }
            if result.retailGuardrail {
                StudioCard {
                    Text(model.t("零售优先的护栏", "Retail-first guardrail"))
                        .font(.headline)
                    Text(model.t("这个组合更接近 Matter 或 Apple Home，而不是整屋有线。避免被一次推销成机柜工程。", "This profile is closer to Matter or Apple Home than to a whole-home rack. Avoid being sold a rack project in one meeting."))
                }
            }
            StudioCard {
                Text(model.t("不适合自己动手的红线", "Do-not-DIY line"))
                    .font(.headline)
                ForEach(Array(result.redLines.enumerated()), id: \.offset) { _, line in
                    Text("· " + line.text(chinese: model.chinese))
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            Text(result.disclaimer.text(chinese: model.chinese))
                .font(.footnote)
                .foregroundStyle(Studio.mist)
            Button(model.t("重新问诊", "Start over")) { model.resetConsult() }
                .buttonStyle(.bordered)
        }
    }

    private func pathName(_ kind: PathKind) -> String {
        switch kind {
        case .wired: return model.t("专业有线集成", "Professional wired")
        case .matter: return model.t("零售 Matter / Apple Home", "Retail Matter / Apple Home")
        case .hybrid: return model.t("有线 + 无线混合", "Wired and wireless hybrid")
        }
    }

    private var advisor: some View {
        StudioCard {
            Text(model.t("本机顾问", "On-device advisor"))
                .font(.headline)
            Text(model.t(
                "你正在和本机顾问对话。回答带来源，或者承认不知道。这不是法律意见，也不是施工许可。",
                "You are talking to an on-device advisor. Answers cite a source or say they are unknown. This is not a legal opinion or a building permit."
            ))
            .font(.footnote)
            .foregroundStyle(Studio.mist)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    chip(model.t("Control4 怎么换集成商", "How does a Control4 owner change dealer?"))
                    chip(model.t("Savant 和 Control4 的区别", "Savant vs Control4 difference"))
                    chip(model.t("预算大概什么量级", "What budget band is published?"))
                    chip(model.t("怎么把模块接进 120V 配电箱", "How do I land a module on a 120V breaker panel?"))
                }
            }
            RadarStack(text: radarQuery)
            HStack {
                TextField(model.t("问一个有出处的问题", "Ask a sourced question"), text: $question)
                    .textFieldStyle(.roundedBorder)
                Button(model.t("发送", "Send")) {
                    let sent = question
                    model.ask(question)
                    radarAnchor = sent
                    question = ""
                }
                .buttonStyle(.borderedProminent)
                .tint(Studio.ink)
            }
            ForEach(model.chat) { line in
                VStack(alignment: .leading, spacing: 6) {
                    Text(line.isUser ? model.t("你", "You") : model.t("顾问", "Advisor"))
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(line.isUser ? Studio.mist : Studio.bronze)
                    Text(line.text)
                        .fixedSize(horizontal: false, vertical: true)
                    ForEach(line.citations) { citation in
                        HStack {
                            EvidenceBadge(tier: citation.tier)
                            SourceLink(title: citation.title, url: citation.url)
                        }
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }

    private func chip(_ text: String) -> some View {
        Button(text) {
            radarAnchor = text
            model.ask(text)
        }
            .font(.caption)
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background(Studio.paper)
            .overlay(Capsule().stroke(Studio.rule, lineWidth: 1))
            .clipShape(Capsule())
    }
}
