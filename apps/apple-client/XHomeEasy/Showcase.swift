import SwiftUI
import XHomeEasyEngines

struct RoomSeed: Sendable {
    var name: String
    var shades = false
    var audio = false
    var cinema = false
    var climate = false
    var security = false
    var note: String
}

struct ShowcaseCase: Identifiable, Sendable {
    let id: String
    let title: String
    let who: String
    let assumptions: String
    let intake: Intake
    let tier: PackageTier
    let points: [String]
    let rooms: [RoomSeed]

    func makeRooms() -> [RoomCard] {
        rooms.map {
            RoomCard(id: UUID(), name: $0.name, lighting: true, shades: $0.shades, audio: $0.audio, cinema: $0.cinema, climate: $0.climate, security: $0.security, note: $0.note, photoPath: nil)
        }
    }
}

enum ShowcaseLibrary {
    static let all: [ShowcaseCase] = [family, elders, estate, hotel, designer]

    static let family = ShowcaseCase(
        id: "family-600",
        title: "新购 600㎡ 别墅",
        who: "中年夫妇，两个孩子，两条狗，花园约 1,500㎡。",
        assumptions: "600㎡ 约等于 6,460 平方英尺，落在 5,000–8,000 档。预算没有报出，所以不显示金额。干墙是否已封，按“还要确认”处理。",
        intake: Intake(sqft: .ft5000to8000, stage: .newBuildPreDrywall, rackRoom: false, budget: .unstated, cinema: false, multiRoomAudio: true, shades: true, pool: false, hvacZones: true, legacy: .none, children: true, pets: true, largeGarden: true, outdoorLiving: true, drywallUnconfirmed: true),
        tier: .better,
        points: [
            "先问总包：干墙封了没有。没封才有布线窗口；封了就把问诊改成改造。",
            "控制层先读 Control4，照明遮阳底座用 Lutron。这是常见工程组合，不是购买命令。",
            "孩子房要有夜间路径和门的状态提醒。系统不代替大人看孩子。",
            "两条狗：出门、回家和庭院门的提醒要避免把狗关在里面或放出去。到现场试，不在这里写做法。",
            "1,500㎡ 花园单独成区。低电压控制可以进主机；景观市电灯具找持证电工。",
            "还没有弱电间。指定主机之前先定一个可维护的柜子位置。",
            "金额等业主选定预算档再出现。在那之前用十个价格问题问集成商。",
        ],
        rooms: [
            seed("门厅与庭院门", security: true, note: "孩子与狗的进出提醒"),
            seed("起居室", shades: true, audio: true, climate: true, note: "家庭活动，不要做成影院"),
            seed("孩子房 A", audio: true, note: "夜间路径"),
            seed("孩子房 B", audio: true, note: "夜间路径"),
            seed("主卧", shades: true, audio: true, climate: true, note: ""),
            seed("厨房", audio: true, note: ""),
            seed("花园", audio: true, security: true, note: "约 1,500㎡，室外分区，市电灯具不在本 App 范围内"),
        ]
    )

    static let elders = ShowcaseCase(
        id: "elders-300",
        title: "入住 30 年的 300㎡ 旧别墅",
        who: "两位老人装修。要安防、适老监护和更舒适的空调。现在只有一套简单红外报警。",
        assumptions: "300㎡ 约 3,230 平方英尺，落在 3,000–5,000 档。已入住，按改造而不是开墙新建。预算未报，不显示金额。",
        intake: Intake(sqft: .ft3000to5000, stage: .retrofitExisting, rackRoom: false, budget: .unstated, cinema: false, multiRoomAudio: false, shades: false, pool: false, hvacZones: true, legacy: .none, elderCare: true, simpleAlarmOnly: true),
        tier: .better,
        points: [
            "主路径是混合：可靠的灯光、暖通和安防进专业系统，不要为了布线拆开每面墙。",
            "红外报警不是专业监控主机。集成商先现场查看，再决定留用或更换。不要自行拆除带电报警。",
            "安防卡片优先看有公开驱动的 Resideo / Alarm.com 路径，而不是把广告写成事实。",
            "适老是夜间灯光、稳定室温和专业值守。本 App 不把它说成医疗器械，也不诊断。",
            "空调按温区写进需求，端接仍由持证暖通和电工完成。",
            "旧房子多半没有标准弱电间。先找一个能上锁、能散热的位置。",
        ],
        rooms: [
            seed("起居", climate: true, security: true, note: "原红外报警所在区域，先勘查"),
            seed("主卧", climate: true, security: true, note: "夜间灯光路径"),
            seed("卫生间", note: "只记录夜间照明需求，不写电气改造"),
            seed("厨房", note: ""),
            seed("入口", security: true, note: "替换或保留旧报警，由集成商判断"),
        ]
    )

    static let estate = ShowcaseCase(
        id: "estate-2000",
        title: "超过 2,000㎡ 的多幢庄园",
        who: "庄园主要最完整的系统，户外花园和露台要有照明和影音。",
        assumptions: "2,000㎡ 约 21,500 平方英尺，超过 8,000 平方英尺档。预算未报，因此不套用 30–50 万美元的庄园金额。档位用 Best，只表示范围，不是报价。",
        intake: Intake(sqft: .over8000, stage: .newBuildPreDrywall, rackRoom: true, budget: .unstated, cinema: true, multiRoomAudio: true, shades: true, pool: false, hvacZones: true, legacy: .none, largeGarden: true, multiBuilding: true, outdoorLiving: true, drywallUnconfirmed: true),
        tier: .best,
        points: [
            "多幢住宅先读 Crestron。一台主机还是多台，要在勘测后决定。",
            "照明和遮阳仍把 Lutron 当作常见底座。户外不是把室内面板拿到花园里。",
            "露台和花园的影音要单独列防雨设备与分区。本页不写喇叭怎么接线。",
            "Josh.ai 只是 Best 档里可选的本地语音层，不是必须购买的第四套系统。",
            "干墙窗口同样要先确认。庄园若已封板，这条提醒作废。",
            "金额等预算档选定。不要把媒体里的庄园区间当成这份委托的合同价。",
        ],
        rooms: [
            seed("主宅起居", shades: true, audio: true, climate: true, note: ""),
            seed("主宅影音", shades: true, audio: true, cinema: true, climate: true, note: "室内影音"),
            seed("客房楼", audio: true, climate: true, security: true, note: "第二幢，单独分区"),
            seed("露台", audio: true, note: "室外影音与照明"),
            seed("花园", audio: true, security: true, note: "景观照明的市电部分由电工负责"),
        ]
    )

    static let hotel = ShowcaseCase(
        id: "hotel-300",
        title: "五星级酒店，300 多间客房",
        who: "要稳定、好看，客人用自己的 iPhone / iPad，并希望有语音。",
        assumptions: "这不是别墅。住宅带宽、业主 RFQ 和三家住宅经销商都不适用。",
        intake: Intake(sqft: .over8000, stage: .newBuildPreDrywall, rackRoom: true, budget: .unstated, cinema: false, multiRoomAudio: true, shades: true, pool: false, hvacZones: true, legacy: .appleHome, hospitality: true),
        tier: .best,
        points: [
            "先写两种房型：标准间和套房。三百多间是房型复制和运维，不是三百份家装。",
            "稳定性来自商业客房工程和ongoing服务合同，不是把一座豪宅方案放大。",
            "客人自带苹果设备要写成需求，交给酒店集成商确认有没有公开接入。Apple Home 不是酒店主机。",
            "语音要问清：是否留在房间、听到什么、谁能关掉。本 App 不指定品牌。",
            "面板颜值按房型出样板，在样板间验收，再复制。",
            "不要把 5–12 万美元的住宅区间乘以 300。",
        ],
        rooms: [
            seed("标准客房样板", shades: true, audio: true, climate: true, note: "房型，不是某一间的门牌"),
            seed("套房样板", shades: true, audio: true, climate: true, note: "第二种房型"),
            seed("后勤与机房", security: true, note: "酒店工程范围，不是家庭弱电间"),
        ]
    )

    static let designer = ShowcaseCase(
        id: "designer-basalte",
        title: "年轻设计师的小别墅",
        who: "在意低碳，要好看的墙面开关，并指定了巴萨面板。",
        assumptions: "面积按约 220㎡、3,000 平方英尺以下的情景假设，因为原文没有给出平方米。预算未报，不显示金额。",
        intake: Intake(sqft: .under3000, stage: .newBuildPreDrywall, rackRoom: false, budget: .unstated, cinema: false, multiRoomAudio: true, shades: true, pool: false, hvacZones: true, legacy: .none, energyPriority: true, keypad: .basalte, drywallUnconfirmed: true),
        tier: .better,
        points: [
            "墙面按业主指定的巴萨，不改写成 Lutron。KNX 协会 House BE 案例里，Basalte Sentido 和 Control4 界面一起出现。",
            "所以控制层先读 Control4，而不是为了能源故事换成 Savant。",
            "Savant Power 是 Savant 公开的能源能力。没有公开证据说它直接驱动巴萨面板，集成商必须单独确认。",
            "巴萨面板本身不产生零碳。低碳要落到可抄的负荷、暖通日程和谁提供能耗数据。",
            "小房子仍然是专业面板，不是零售 Matter 套装。主路径因此偏向有线，但分数不会装成庄园。",
            "Lutron 只在业主改口时才回到底座选项。",
        ],
        rooms: [
            seed("起居", shades: true, audio: true, climate: true, note: "巴萨面板样板墙"),
            seed("工作室", audio: true, climate: true, note: "能耗要能按区看，不承诺零碳"),
            seed("主卧", shades: true, climate: true, note: ""),
        ]
    )
}

private func seed(_ name: String, shades: Bool = false, audio: Bool = false, cinema: Bool = false, climate: Bool = false, security: Bool = false, note: String) -> RoomSeed {
    RoomSeed(name: name, shades: shades, audio: audio, cinema: cinema, climate: climate, security: security, note: note)
}

struct CaseGuideSheet: View {
    @Environment(AppModel.self) private var model
    @Environment(\.dismiss) private var dismiss
    @State private var picked: ShowcaseCase?
    @State private var phase = 0
    @State private var draft = ConsultDraft()
    @State private var note = ""
    @State private var useCaseRooms = false
    @State private var reading: ShowcaseCase?

    private var visible: [ShowcaseCase] {
        ShowcaseLibrary.all.filter { !model.hiddenDemoIDs.contains($0.id) }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if phase == 0 || picked == nil {
                        picker
                    } else if let picked {
                        guide(picked)
                    }
                }
                .padding(20)
            }
            .background(Studio.paper)
            .navigationTitle(model.t("参照案例", "Use an example"))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(model.t("首页", "Home")) { model.openHome() }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(model.t("设置", "Settings")) { model.openSettings() }
                    Button(model.t("关闭", "Close")) { dismiss() }
                }
            }
            .onChange(of: model.dockTick) { _, _ in dismiss() }
        }
        .sheet(item: $reading) { sample in
            ShowcaseDetail(sample: sample)
                .environment(model)
        }
    }

    private var picker: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(model.t("选一个接近的例子。接下来每一步都改成你家的情况和功能，例子本身不会变成你的项目。", "Pick a close example. Each next step is about your house. The example does not become your project."))
                .font(.subheadline)
                .foregroundStyle(Studio.mist)
            if visible.isEmpty {
                Button(model.t("恢复五个案例", "Restore the five examples")) { model.restoreDemos() }
                    .buttonStyle(.bordered)
            } else {
                ForEach(visible) { sample in
                    VStack(alignment: .leading, spacing: 8) {
                        Button { begin(sample) } label: {
                            StudioCard {
                                Text(sample.title).font(.headline).foregroundStyle(Studio.ink)
                                Text(sample.who).font(.subheadline).foregroundStyle(Studio.mist).multilineTextAlignment(.leading)
                            }
                        }
                        .buttonStyle(.plain)
                        Button(model.t("从引导里移除", "Remove from the guide")) { model.hideDemo(sample.id) }
                            .font(.caption)
                            .foregroundStyle(Studio.clay)
                    }
                }
            }
            if !model.hiddenDemoIDs.isEmpty {
                Button(model.t("恢复已移除的案例", "Restore removed examples")) { model.restoreDemos() }
                    .font(.caption)
            }
        }
    }

    private func guide(_ sample: ShowcaseCase) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(model.t("第 \(phase) 步，共 4 步", "Step \(phase) of 4"))
                .font(.caption.weight(.semibold))
                .foregroundStyle(Studio.bronze)
            switch phase {
            case 1:
                Text(sample.who).font(.headline)
                Text(sample.assumptions).font(.footnote).foregroundStyle(Studio.mist)
                ForEach(Array(sample.points.prefix(3).enumerated()), id: \.offset) { index, point in
                    Text("\(index + 1). \(point)").font(.subheadline)
                }
                Button(model.t("先看这个案例的完整读法", "Read the full example")) { reading = sample }
                    .buttonStyle(.bordered)
                Button(model.t("开始写我家的情况", "Describe my house")) { phase = 2 }
                    .buttonStyle(.borderedProminent)
                    .tint(Studio.ink)
            case 2:
                Text(model.t("房子本身。案例只是对照，点选的是你家。", "The house itself. The example is the comparison. The selection is yours."))
                    .font(.subheadline)
                    .foregroundStyle(Studio.mist)
                Text(model.t("案例面积档：\(areaLabel(sample.intake.sqft))", "Example size: \(areaLabel(sample.intake.sqft))"))
                    .font(.caption).foregroundStyle(Studio.bronze)
                sizeChoices
                Text(model.t("案例工程阶段已预选，请改成你家的。", "The example’s stage is preselected. Change it to yours."))
                    .font(.caption).foregroundStyle(Studio.bronze)
                stageChoices
                rackChoices
                Text(model.t("预算可以保持“还没定”。", "The budget can stay unstated."))
                    .font(.caption).foregroundStyle(Studio.bronze)
                budgetChoices
                Button(model.t("下一步：功能需求", "Next: what you want")) { phase = 3 }
                    .buttonStyle(.borderedProminent)
                    .tint(Studio.ink)
            case 3:
                Text(model.t("功能需求。开关最初跟着案例，请关掉不属于你家的，打开你家要的。", "Needs start from the example. Turn off what is not yours, and turn on what is."))
                    .font(.subheadline)
                    .foregroundStyle(Studio.mist)
                needToggle(model.t("有孩子", "Children"), draft.children) { draft.children.toggle() }
                needToggle(model.t("有宠物", "Pets"), draft.pets) { draft.pets.toggle() }
                needToggle(model.t("大花园或露台", "Garden or terrace"), draft.largeGarden) {
                    draft.largeGarden.toggle()
                    draft.outdoorLiving = draft.largeGarden
                }
                needToggle(model.t("多房间音频", "Multi-room audio"), draft.multiRoomAudio) { draft.multiRoomAudio.toggle() }
                needToggle(model.t("遮阳", "Shades"), draft.shades) { draft.shades.toggle() }
                needToggle(model.t("影院", "Theater"), draft.cinema) { draft.cinema.toggle() }
                needToggle(model.t("多个暖通温区", "Several HVAC zones"), draft.hvacZones) { draft.hvacZones.toggle() }
                needToggle(model.t("适老与健康监护", "Aging in place"), draft.elderCare) { draft.elderCare.toggle() }
                needToggle(model.t("只有简单红外报警", "Only a simple infrared alarm"), draft.simpleAlarmOnly) { draft.simpleAlarmOnly.toggle() }
                needToggle(model.t("多幢住宅", "More than one residence"), draft.multiBuilding) { draft.multiBuilding.toggle() }
                needToggle(model.t("这是酒店客房", "This is a hotel"), draft.hospitality) { draft.hospitality.toggle() }
                needToggle(model.t("低碳 / 能源管理", "Low-carbon energy"), draft.energyPriority) { draft.energyPriority.toggle() }
                needToggle(model.t("墙面指定巴萨", "Basalte keypads"), draft.keypad == .basalte) {
                    draft.keypad = draft.keypad == .basalte ? .open : .basalte
                }
                Button(model.t("下一步：用自己的话", "Next: in your words")) { phase = 4 }
                    .buttonStyle(.borderedProminent)
                    .tint(Studio.ink)
            default:
                Text(model.t("用一两句话写下你家和这个案例不一样的地方。", "In a sentence or two, write how your house differs from the example."))
                    .font(.subheadline)
                TextField(model.t("例如：花园更小，但也有两条狗", "For example: a smaller garden, but two dogs as well"), text: $note, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                Toggle(model.t("把案例里的房间列表当作起点，我再改", "Start from this example’s room list, then I’ll edit it"), isOn: $useCaseRooms)
                Button(model.t("写入我的问诊", "Save into my consult")) {
                    model.applyReference(sample, draft: draft, note: note, useCaseRooms: useCaseRooms)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(Studio.ink)
            }
            if phase > 1 {
                Button(model.t("上一步", "Back")) { phase -= 1 }
                    .buttonStyle(.bordered)
            }
            Button(model.t("换一个案例", "Choose another example")) {
                picked = nil
                phase = 0
            }
            .font(.caption)
        }
    }

    private func begin(_ sample: ShowcaseCase) {
        var next = ConsultDraft()
        let house = sample.intake
        next.sqft = house.sqft
        next.stage = house.stage
        next.rackRoom = house.rackRoom
        next.budget = house.budget
        next.cinema = house.cinema
        next.multiRoomAudio = house.multiRoomAudio
        next.shades = house.shades
        next.pool = house.pool
        next.hvacZones = house.hvacZones
        next.legacy = house.legacy
        next.children = house.children
        next.pets = house.pets
        next.largeGarden = house.largeGarden
        next.elderCare = house.elderCare
        next.simpleAlarmOnly = house.simpleAlarmOnly
        next.multiBuilding = house.multiBuilding
        next.outdoorLiving = house.outdoorLiving
        next.hospitality = house.hospitality
        next.energyPriority = house.energyPriority
        next.keypad = house.keypad
        next.drywallUnconfirmed = house.drywallUnconfirmed
        draft = next
        picked = sample
        phase = 1
    }

    private var sizeChoices: some View {
        VStack(alignment: .leading, spacing: 8) {
            guideChoice(model.t("约 280㎡ 以下", "Under about 280 m²"), draft.sqft == .under3000) { draft.sqft = .under3000 }
            guideChoice(model.t("约 280–460㎡", "About 280–460 m²"), draft.sqft == .ft3000to5000) { draft.sqft = .ft3000to5000 }
            guideChoice(model.t("约 460–740㎡", "About 460–740 m²"), draft.sqft == .ft5000to8000) { draft.sqft = .ft5000to8000 }
            guideChoice(model.t("约 740㎡ 以上", "Over about 740 m²"), draft.sqft == .over8000) { draft.sqft = .over8000 }
        }
    }

    private var stageChoices: some View {
        VStack(alignment: .leading, spacing: 8) {
            guideChoice(model.t("新建，干墙还没封", "New build, drywall still open"), draft.stage == .newBuildPreDrywall) { draft.stage = .newBuildPreDrywall }
            guideChoice(model.t("整屋大翻新", "Major renovation"), draft.stage == .majorRenovation) { draft.stage = .majorRenovation }
            guideChoice(model.t("已入住，局部改造", "Occupied retrofit"), draft.stage == .retrofitExisting) { draft.stage = .retrofitExisting }
            guideChoice(model.t("接手已有专业系统", "Inherited professional system"), draft.stage == .inheritedHome) { draft.stage = .inheritedHome }
        }
    }

    private var rackChoices: some View {
        VStack(alignment: .leading, spacing: 8) {
            guideChoice(model.t("有独立弱电间", "There is a low-voltage room"), draft.rackRoom == true) { draft.rackRoom = true }
            guideChoice(model.t("还没有弱电间", "No low-voltage room yet"), draft.rackRoom == false) { draft.rackRoom = false }
        }
    }

    private var budgetChoices: some View {
        VStack(alignment: .leading, spacing: 8) {
            guideChoice(model.t("预算还没定", "Budget not stated"), draft.budget == .unstated) { draft.budget = .unstated }
            guideChoice(model.t("2.5 万美元以下", "Under $25k"), draft.budget == .under25k) { draft.budget = .under25k }
            guideChoice(model.t("2.5 万–7.5 万", "$25k–$75k"), draft.budget == .k25to75) { draft.budget = .k25to75 }
            guideChoice(model.t("7.5 万–15 万", "$75k–$150k"), draft.budget == .k75to150) { draft.budget = .k75to150 }
            guideChoice(model.t("15 万美元以上", "$150k and above"), draft.budget == .k150plus) { draft.budget = .k150plus }
        }
    }

    private func guideChoice(_ title: String, _ selected: Bool, _ action: @escaping () -> Void) -> some View {
        ChoiceButton(title: title, selected: selected, action: action)
    }

    private func needToggle(_ title: String, _ selected: Bool, _ action: @escaping () -> Void) -> some View {
        ChoiceButton(title: title, selected: selected, action: action)
    }

    private func areaLabel(_ band: SqftBand) -> String {
        switch band {
        case .under3000: return model.t("约 280㎡ 以下", "under about 280 m²")
        case .ft3000to5000: return model.t("约 280–460㎡", "about 280–460 m²")
        case .ft5000to8000: return model.t("约 460–740㎡", "about 460–740 m²")
        case .over8000: return model.t("约 740㎡ 以上", "over about 740 m²")
        }
    }
}

struct ShowcaseDetail: View {
    @Environment(AppModel.self) private var model
    @Environment(\.dismiss) private var dismiss
    let sample: ShowcaseCase

    var body: some View {
        let score = AdaptationScorer.score(sample.intake)
        let plan = TopologyBuilder.build(sample.intake, tier: sample.tier)
        let budget = BudgetEngine.calculate(sample.intake, tier: sample.tier, brand: plan.controlBrand)
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    Text(sample.who).font(.body)
                    Text(sample.assumptions).font(.footnote).foregroundStyle(Studio.mist)
                    StudioCard {
                        if score.residentialModelApplies {
                            Text(model.t("主路径", "Lead path")).font(.caption.weight(.semibold)).foregroundStyle(Studio.bronze)
                            HStack {
                                Text(pathName(score.primary)).font(.title3)
                                SignalMark(light: score.paths.first { $0.kind == score.primary }?.light ?? .consider, chinese: true)
                            }
                            Text(model.t("照明界面：\(plan.lightingBase)", "Lighting interface: \(plan.lightingBase)"))
                            Text(model.t("控制层读法：\(plan.controlBrand.rawValue)", "Control reading: \(plan.controlBrand.rawValue)"))
                            Text("Good / Better / Best · \(sample.tier.rawValue)")
                        } else if let note = score.scopeNote {
                            Text(note.zh).font(.headline)
                        }
                        if budget.amountsWithheld {
                            Text(budget.disclaimer.zh).font(.subheadline)
                        } else {
                            Text("\(usd(budget.totalLow)) – \(usd(budget.totalHigh))")
                                .font(.title3)
                            Text(budget.disclaimer.zh).font(.caption).foregroundStyle(Studio.mist)
                        }
                        Text(score.disclaimer.zh).font(.caption2).foregroundStyle(Studio.mist)
                    }
                    StudioCard {
                        Text(model.t("实施要点", "How to proceed")).font(.headline)
                        ForEach(Array(sample.points.enumerated()), id: \.offset) { index, point in
                            Text("\(index + 1). \(point)").font(.subheadline).fixedSize(horizontal: false, vertical: true)
                        }
                        ForEach(Array(score.briefNotes.enumerated()), id: \.offset) { _, note in
                            Text(note.zh).font(.footnote).foregroundStyle(Studio.ink)
                        }
                    }
                    Text(model.t("这是案例的读法，不是你的问诊。回到上一步，把面积、阶段和功能改成你家的。", "This is how the example reads. It is not your consult. Go back and change the size, stage, and needs to yours."))
                        .font(.footnote)
                        .foregroundStyle(Studio.mist)
                }
                .padding(20)
            }
            .background(Studio.paper)
            .navigationTitle(sample.title)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(model.t("首页", "Home")) { model.openHome() }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(model.t("设置", "Settings")) { model.openSettings() }
                    Button(model.t("关闭", "Close")) { dismiss() }
                }
            }
            .onChange(of: model.dockTick) { _, _ in dismiss() }
        }
    }

    private func pathName(_ kind: PathKind) -> String {
        switch kind {
        case .wired: return "专业有线"
        case .matter: return "零售 Matter / Apple Home"
        case .hybrid: return "有线 + 无线混合"
        }
    }
}
