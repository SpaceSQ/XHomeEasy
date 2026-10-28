import PencilKit
import SwiftUI
import XHomeEasyEngines

struct BlueprintView: View {
    @Environment(AppModel.self) private var model
    @Environment(\.horizontalSizeClass) private var sizeClass

    var body: some View {
        PaperScreen(kicker: model.t("方案沙盘", "BLUEPRINT"), title: model.t("底座、主机、预算带宽", "Base, host, and a budget band")) {
            if model.intake == nil {
                StudioCard {
                    Text(model.t("先在「顾问」里完成六问。方案不会在问诊之前编一个价格。", "Finish the six questions in Advisor. A price is not invented before that."))
                }
            } else if let plan = model.topology, let budget = model.budget {
                if let title = model.referenceCaseTitle {
                    Text(model.t("方案来自你的问诊。描述时参照了「\(title)」。", "This plan comes from your consult. “\(title)” was only the reference."))
                        .font(.caption)
                        .foregroundStyle(Studio.bronze)
                }
                if plan.specificationWithheld {
                    StudioCard {
                        Text(plan.fusionHint.text(chinese: model.chinese)).font(.headline)
                        ForEach(plan.layers, id: \.url) { layer in
                            Text(layer.detail.text(chinese: model.chinese)).font(.subheadline)
                            EvidenceBadge(tier: layer.tier)
                            SourceLink(title: model.t("查看来源", "Open source"), url: layer.url)
                        }
                    }
                }
                rooms
                if !plan.specificationWithheld {
                tierPicker
                brandPicker(plan)
                ForEach(Array(plan.layers.enumerated()), id: \.offset) { _, layer in
                    StudioCard {
                        HStack {
                            Text(layer.name.text(chinese: model.chinese)).font(.headline)
                            Spacer()
                            EvidenceBadge(tier: layer.tier)
                        }
                        Text(layer.detail.text(chinese: model.chinese))
                            .font(.subheadline)
                            .fixedSize(horizontal: false, vertical: true)
                        SourceLink(title: model.t("查看来源", "Open source"), url: layer.url)
                    }
                }
                if sizeClass == .regular { sketch }
                matrix
                subsystems(plan)
                fusion(plan)
                cases
                }
                budgetCard(budget)
                questions(budget)
            }
        }
    }

    private var rooms: some View {
        StudioCard {
            Text(model.t("房间卡片", "Room cards")).font(.headline)
            ForEach(model.rooms) { room in
                VStack(alignment: .leading, spacing: 8) {
                    TextField(model.t("房间", "Room"), text: roomText(room.id, \.name))
                        .font(.headline)
                    if room.aiGenerated {
                        Text(model.t("模型从对话里读出的房间，只是建议。", "Read from the conversation by the on-device model. A suggestion."))
                            .font(.caption2)
                            .foregroundStyle(Studio.bronze)
                    }
                    chipRow(model.t("灯光", "Light"), roomBool(room.id, \.lighting))
                    chipRow(model.t("遮阳", "Shades"), roomBool(room.id, \.shades))
                    chipRow(model.t("音频", "Audio"), roomBool(room.id, \.audio))
                    chipRow(model.t("影院", "Theater"), roomBool(room.id, \.cinema))
                    chipRow(model.t("气候", "Climate"), roomBool(room.id, \.climate))
                    chipRow(model.t("安防", "Security"), roomBool(room.id, \.security))
                    TextField(model.t("只写需求，不写接线", "Needs only. No wiring notes."), text: roomText(room.id, \.note), axis: .vertical)
                        .font(.subheadline)
                }
                .padding(.vertical, 6)
                Divider()
            }
            Button(model.t("加一个房间", "Add a room")) {
                model.rooms.append(RoomCard(id: UUID(), name: model.t("新房间", "New room"), lighting: true, shades: false, audio: false, cinema: false, climate: false, security: false, note: "", photoPath: nil))
                model.save()
            }
            .onChange(of: model.rooms) { _, _ in model.save() }
        }
    }

    private func chipRow(_ title: String, _ value: Binding<Bool>) -> some View {
        Toggle(title, isOn: value)
            .font(.subheadline)
    }

    private func roomText(_ id: UUID, _ key: WritableKeyPath<RoomCard, String>) -> Binding<String> {
        Binding(
            get: { model.rooms.first { $0.id == id }?[keyPath: key] ?? "" },
            set: { value in
                guard let index = model.rooms.firstIndex(where: { $0.id == id }) else { return }
                model.rooms[index][keyPath: key] = value
                model.save()
            }
        )
    }

    private func roomBool(_ id: UUID, _ key: WritableKeyPath<RoomCard, Bool>) -> Binding<Bool> {
        Binding(
            get: { model.rooms.first { $0.id == id }?[keyPath: key] ?? false },
            set: { value in
                guard let index = model.rooms.firstIndex(where: { $0.id == id }) else { return }
                model.rooms[index][keyPath: key] = value
                model.save()
            }
        )
    }

    private var tierPicker: some View {
        StudioCard {
            Text("Good / Better / Best").font(.headline)
            Text(model.t("三档是示意包，不是报价。滑过去会改带宽，不会出现一个精确总价。", "Three illustrative packages, not a bid. Moving the choice changes the band. It never becomes one exact total."))
                .font(.subheadline)
                .foregroundStyle(Studio.mist)
            Picker("Tier", selection: Bindable(model).tier) {
                Text("Good").tag(PackageTier.good)
                Text("Better").tag(PackageTier.better)
                Text("Best").tag(PackageTier.best)
            }
            .pickerStyle(.segmented)
            .onChange(of: model.tier) { _, _ in model.save() }
        }
    }

    private func brandPicker(_ plan: TopologyPlan) -> some View {
        StudioCard {
            Text(model.t("控制主机", "Control host")).font(.headline)
            Text(model.t("建议从 \(plan.controlBrand.rawValue) 看起。你可以改，建议不是命令。", "Start by reading \(plan.controlBrand.rawValue). You can change it. A suggestion is not an order."))
                .font(.subheadline)
            Picker("Brand", selection: Bindable(model).controlOverride) {
                Text(model.t("按房子建议", "Follow the house")).tag(nil as ControlBrand?)
                Text("Control4").tag(ControlBrand.control4 as ControlBrand?)
                Text("Crestron").tag(ControlBrand.crestron as ControlBrand?)
                Text("Savant").tag(ControlBrand.savant as ControlBrand?)
            }
            .onChange(of: model.controlOverride) { _, _ in model.save() }
            Text(plan.fusionHint.text(chinese: model.chinese))
                .font(.footnote)
                .foregroundStyle(Studio.ink)
        }
    }

    private var sketch: some View {
        StudioCard {
            Text(model.t("建筑师批注", "Designer markup")).font(.headline)
            Text(model.t("Apple Pencil 或手指。只批在需求上，不在这里画线路。", "Apple Pencil or a finger. Mark the brief, not a wiring diagram."))
                .font(.footnote)
                .foregroundStyle(Studio.mist)
            MarkupCanvas(data: Bindable(model).sketch)
                .frame(height: 220)
                .background(Color.white)
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Studio.rule, lineWidth: 1))
        }
    }

    private func budgetCard(_ budget: BudgetReport) -> some View {
        StudioCard {
            Text(model.t("六桶带宽", "Six-bucket band")).font(.headline)
            if budget.amountsWithheld {
                Text(budget.disclaimer.text(chinese: model.chinese))
                    .font(.body)
                Text(budget.programmingShare.text(chinese: model.chinese)).font(.footnote).foregroundStyle(Studio.mist)
            }
            if !budget.amountsWithheld {
            Text("\(usd(budget.totalLow)) – \(usd(budget.totalHigh))")
                .font(.system(size: 28, weight: .regular, design: .serif))
            if budget.estateBand {
                Text(model.t("庄园级定制区间，仍然不是报价。", "Estate custom band. Still not a quote."))
                    .font(.subheadline)
                    .foregroundStyle(Studio.clay)
            }
            GeometryReader { proxy in
                HStack(spacing: 2) {
                    ForEach(budget.buckets, id: \.id) { bucket in
                        Rectangle()
                            .fill(bucketColor(bucket.id))
                            .frame(width: max(4, proxy.size.width * bucket.barShare))
                            .accessibilityLabel(bucket.label.text(chinese: model.chinese))
                    }
                }
            }
            .frame(height: 18)
            Text(model.t("色条用各项中位占比归一，所以能加总。下面的金额用公开百分比区间，彼此可以重叠。", "The bar uses normalized midpoints so it sums. The dollars use the published percent ranges and may overlap."))
                .font(.caption2)
                .foregroundStyle(Studio.mist)
            ForEach(budget.buckets, id: \.id) { bucket in
                HStack(alignment: .firstTextBaseline) {
                    Circle().fill(bucketColor(bucket.id)).frame(width: 8, height: 8)
                    VStack(alignment: .leading) {
                        Text(bucket.label.text(chinese: model.chinese))
                        Text("\(Int(bucket.lowPct * 100))–\(Int(bucket.highPct * 100))% · \(usd(bucket.dollarLow)) – \(usd(bucket.dollarHigh))")
                            .font(.caption)
                            .foregroundStyle(Studio.mist)
                    }
                }
            }
            Text(budget.programmingShare.text(chinese: model.chinese)).font(.subheadline)
            Text(model.t("按这座房子修正后的编程小时参考：\(budget.programmingHoursLow)–\(budget.programmingHoursHigh) 小时。费率举例 \(budget.hourlyRateLow)–\(budget.hourlyRateHigh) 美元。", "Programming-hour reference after this house's adjustment: \(budget.programmingHoursLow)–\(budget.programmingHoursHigh) hours. Example rates \(budget.hourlyRateLow)–\(budget.hourlyRateHigh) dollars."))
                .font(.subheadline)
            Text(budget.laborComposite.text(chinese: model.chinese)).font(.subheadline)
            Text(budget.disclaimer.text(chinese: model.chinese))
                .font(.footnote)
                .foregroundStyle(Studio.mist)
            ForEach(budget.sources, id: \.url) { source in
                HStack {
                    EvidenceBadge(tier: source.tier)
                    SourceLink(title: source.label, url: source.url)
                }
            }
            }
        }
    }

    private func questions(_ budget: BudgetReport) -> some View {
        StudioCard {
            Text(model.t("该问集成商的 10 个价格问题", "Ten price questions for the integrator")).font(.headline)
            ForEach(Array(budget.questions.enumerated()), id: \.offset) { index, question in
                Text("\(index + 1). \(question.text(chinese: model.chinese))")
                    .font(.subheadline)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    private var matrix: some View {
        StudioCard {
            Text(model.t("四品牌对照", "Four-brand comparison")).font(.headline)
            Text(model.t("只写核实过的结构差异。没有“谁更好用”的分数。", "Structural differences that were checked. There is no score for who is nicer to use."))
                .font(.footnote)
                .foregroundStyle(Studio.mist)
            ForEach(BrandMatrix.rows) { row in
                VStack(alignment: .leading, spacing: 8) {
                    Text(row.title.text(chinese: model.chinese)).font(.subheadline.weight(.semibold))
                    ForEach(row.cells) { cell in
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(cell.brand).font(.caption.weight(.bold))
                                EvidenceBadge(tier: cell.tier)
                            }
                            Text(cell.body.text(chinese: model.chinese))
                                .font(.caption)
                                .fixedSize(horizontal: false, vertical: true)
                            SourceLink(title: cell.source, url: cell.url)
                        }
                    }
                }
                .padding(.vertical, 6)
                Divider()
            }
        }
    }

    private func subsystems(_ plan: TopologyPlan) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(model.t("子系统为什么要进控制层", "Why these systems belong on the control layer"))
                .font(.headline)
                .padding(.horizontal, 4)
            if let library = model.library {
                ForEach(plan.subsystemCategories, id: \.self) { category in
                    let cards = Array(library.subsystems.filter { $0.category == category }.sorted { lhs, rhs in
                        securityRank(lhs) < securityRank(rhs)
                    }.prefix(2))
                    ForEach(cards) { card in
                        StudioCard {
                            HStack {
                                Text(card.brand).font(.caption.weight(.semibold))
                                Spacer()
                                EvidenceBadge(tier: card.tier)
                            }
                            Text(card.title).font(.subheadline.weight(.semibold))
                            Text(card.takeaway).font(.subheadline)
                            Text(card.fit).font(.footnote).foregroundStyle(Studio.ink)
                            if let label = card.practiceLabel {
                                Text(label).font(.caption2.weight(.bold)).foregroundStyle(Studio.clay)
                            }
                            SourceLink(title: card.id, url: card.url)
                        }
                    }
                }
            }
        }
    }

    private func fusion(_ plan: TopologyPlan) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(model.t("融合卡片", "Fusion cards")).font(.headline).padding(.horizontal, 4)
            Text(plan.fusionHint.text(chinese: model.chinese)).font(.footnote).foregroundStyle(Studio.mist)
            if let library = model.library {
                let visible = library.fusion.filter { $0.tier != "E4" }.prefix(4)
                ForEach(Array(visible)) { card in
                    fusionCard(card)
                }
                DisclosureGroup(model.t("社区笔记默认折起", "Community notes stay folded")) {
                    ForEach(library.fusion.filter { $0.tier == "E4" }.prefix(3)) { card in
                        fusionCard(card)
                    }
                }
                .font(.subheadline)
            }
        }
    }

    private func fusionCard(_ card: FusionEntry) -> some View {
        StudioCard {
            HStack {
                Text(card.id).font(.caption.monospaced())
                Spacer()
                EvidenceBadge(tier: card.tier)
            }
            Text(card.title).font(.subheadline.weight(.semibold))
            Text(card.takeaway).font(.subheadline)
            Text(card.pattern).font(.caption).foregroundStyle(Studio.bronze)
            if let label = card.practiceLabel {
                Text(label).font(.caption.weight(.bold)).foregroundStyle(Studio.clay)
            }
            SourceLink(title: card.sourceName.isEmpty ? card.id : card.sourceName, url: card.url)
        }
    }

    private var cases: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(model.t("公开案例", "Public cases")).font(.headline).padding(.horizontal, 4)
            if let library = model.library {
                ForEach(library.cases.prefix(6)) { item in
                    StudioCard {
                        HStack {
                            Text(item.brands.joined(separator: " · ")).font(.caption)
                            Spacer()
                            EvidenceBadge(tier: item.tier)
                        }
                        Text(item.title).font(.subheadline.weight(.semibold))
                        Text(item.geography).font(.caption).foregroundStyle(Studio.mist)
                        if let label = item.practiceLabel {
                            Text(label).font(.caption.weight(.bold)).foregroundStyle(Studio.clay)
                        }
                        Text(item.note).font(.caption)
                        SourceLink(title: item.id, url: item.url)
                    }
                }
            }
        }
    }

    private func securityRank(_ item: SubsystemEntry) -> Int {
        var rank = EvidenceRank.sortKey(item.tier)
        if item.category == "security" {
            let brand = item.brand.lowercased()
            if brand.contains("alarm.com") || brand.contains("resideo") { rank -= 1 }
            if brand.contains("adt") { rank += 2 }
        }
        return rank
    }

    private func bucketColor(_ id: String) -> Color {
        switch id {
        case "prewire": return Studio.ink
        case "lighting": return Studio.bronze
        case "av": return Studio.forest
        case "control": return Studio.amber
        default: return Studio.clay
        }
    }
}

struct MarkupCanvas: UIViewRepresentable {
    @Binding var data: Data

    func makeUIView(context: Context) -> PKCanvasView {
        let canvas = PKCanvasView()
        canvas.drawingPolicy = .anyInput
        canvas.tool = PKInkingTool(.pen, color: UIColor(red: 0.42, green: 0.32, blue: 0.16, alpha: 1), width: 2)
        canvas.backgroundColor = .white
        canvas.delegate = context.coordinator
        if !data.isEmpty, let drawing = try? PKDrawing(data: data) {
            canvas.drawing = drawing
        }
        return canvas
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {}

    func makeCoordinator() -> Coordinator { Coordinator(data: $data) }

    final class Coordinator: NSObject, PKCanvasViewDelegate {
        var data: Binding<Data>
        init(data: Binding<Data>) { self.data = data }
        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            data.wrappedValue = canvasView.drawing.dataRepresentation()
        }
    }
}
