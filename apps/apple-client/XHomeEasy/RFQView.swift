import PDFKit
import SwiftUI
import UIKit
import XHomeEasyEngines

enum RFQPDF {
    @MainActor
    static func write(_ model: AppModel) throws -> URL {
        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 612, height: 792))
        let lines = lines(model)
        let data = renderer.pdfData { context in
            var y: CGFloat = 48
            func start() {
                context.beginPage()
                y = 48
            }
            start()
            for line in lines {
                let paragraph = NSMutableParagraphStyle()
                paragraph.lineBreakMode = .byWordWrapping
                let font = line.heading
                    ? UIFont(name: "TimesNewRomanPS-BoldMT", size: 16) ?? .boldSystemFont(ofSize: 16)
                    : UIFont.systemFont(ofSize: 11)
                let attributes: [NSAttributedString.Key: Any] = [
                    .font: font,
                    .paragraphStyle: paragraph,
                    .foregroundColor: UIColor(red: 0.055, green: 0.102, blue: 0.145, alpha: 1),
                ]
                let text = NSAttributedString(string: line.text, attributes: attributes)
                let box = text.boundingRect(with: CGSize(width: 516, height: 800), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
                if y + box.height > 740 {
                    start()
                }
                text.draw(in: CGRect(x: 48, y: y, width: 516, height: box.height + 4))
                y += box.height + (line.heading ? 12 : 6)
            }
        }
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("XHomeEasy-RFQ.pdf")
        try data.write(to: url, options: .atomic)
        return url
    }

    private struct Line {
        var text: String
        var heading: Bool
    }

    @MainActor
    private static func lines(_ model: AppModel) -> [Line] {
        var lines: [Line] = [
            Line(text: "X Home Easy · RFQ", heading: true),
            Line(text: model.t("标准化需求书。没有门牌号。这不是合同，也不是报价。", "A standard brief. No street address. This is not a contract and not a bid."), heading: false),
            Line(text: model.t("地点：\(model.city), \(model.stateCode) \(model.zip)", "Place: \(model.city), \(model.stateCode) \(model.zip)"), heading: false),
        ]
        if let intake = model.intake, let plan = model.topology, let budget = model.budget {
            lines.append(Line(text: model.t("档位 \(plan.packageTier.rawValue) · 照明 \(plan.lightingBase) · 主机 \(plan.controlBrand.rawValue)", "Package \(plan.packageTier.rawValue) · Lighting \(plan.lightingBase) · Host \(plan.controlBrand.rawValue)"), heading: false))
            lines.append(Line(text: model.t("预算带宽 \(usd(budget.totalLow)) – \(usd(budget.totalHigh))。\(budget.disclaimer.text(chinese: model.chinese))", "Budget band \(usd(budget.totalLow)) – \(usd(budget.totalHigh)). \(budget.disclaimer.text(chinese: model.chinese))"), heading: false))
            lines.append(Line(text: model.t("编程小时参考 \(budget.programmingHoursLow)–\(budget.programmingHoursHigh)。", "Programming-hour reference \(budget.programmingHoursLow)–\(budget.programmingHoursHigh)."), heading: false))
            lines.append(Line(text: model.t("房屋", "House"), heading: true))
            lines.append(Line(text: "\(intake.sqft.rawValue) · \(intake.stage.rawValue) · \(intake.budget.rawValue)", heading: false))
        }
        if model.designFromModel {
            lines.append(Line(text: model.t("部分字段由这台 iPhone 上的模型从对话读出，只是建议。路径分数和价格带宽仍由固定计算给出。", "Some fields were read by a model on this iPhone. They are suggestions. Path scores and price bands still come from the fixed calculator."), heading: false))
        }
        if !model.designConstraints.isEmpty {
            lines.append(Line(text: model.t("对话里的约束", "Constraints from the conversation"), heading: true))
            for item in model.designConstraints {
                lines.append(Line(text: item, heading: false))
            }
        }
        if let note = model.consult.installedSystemNote?.trimmingCharacters(in: .whitespacesAndNewlines), !note.isEmpty {
            lines.append(Line(text: model.t("业主提到的存量系统", "Systems the owner named"), heading: true))
            lines.append(Line(text: note, heading: false))
        }
        if let retrofits = model.legacyRetrofits, !retrofits.isEmpty {
            lines.append(Line(text: model.t("存量改造 / 桥接评估", "Legacy retrofit / bridge review"), heading: true))
            for item in retrofits {
                lines.append(Line(text: "[\(item.tier)] \(item.id) \(item.name)", heading: false))
                lines.append(Line(text: item.bridge, heading: false))
                lines.append(Line(text: item.advice, heading: false))
                if item.lineVoltage {
                    lines.append(Line(text: KeywordRadarCopy.lineVoltageBoundary.text(chinese: model.chinese), heading: false))
                }
                if !item.sourceURL.isEmpty {
                    lines.append(Line(text: item.sourceURL, heading: false))
                }
            }
        }
        lines.append(Line(text: model.t("房间", "Rooms"), heading: true))
        for room in model.rooms {
            let flags = [
                room.lighting ? model.t("灯光", "light") : nil,
                room.shades ? model.t("遮阳", "shades") : nil,
                room.audio ? model.t("音频", "audio") : nil,
                room.cinema ? model.t("影院", "theater") : nil,
                room.climate ? model.t("气候", "climate") : nil,
                room.security ? model.t("安防", "security") : nil,
            ].compactMap { $0 }.joined(separator: ", ")
            let mark = room.aiGenerated ? model.t("（模型读出）", " (read by the on-device model)") : ""
            lines.append(Line(text: "\(room.name): \(flags). \(room.note)\(mark)", heading: false))
        }
        lines.append(Line(text: model.t("必须回答的移交条款", "Handover clauses that need an answer"), heading: true))
        for item in model.handoverItems {
            lines.append(Line(text: "[\(item.tier)] \(item.text.text(chinese: model.chinese))", heading: false))
        }
        lines.append(Line(text: model.t("安全边界", "Safety boundary"), heading: true))
        for line in EvidenceCopy.redLines {
            lines.append(Line(text: line.text(chinese: model.chinese), heading: false))
        }
        lines.append(Line(text: model.t("核实日 2026-10-21。平台不担保集成商执照在此刻有效。", "Verified 2026-10-21. The platform does not guarantee that an integrator's license is valid today."), heading: false))
        return lines
    }
}

struct PDFKitPreview: UIViewRepresentable {
    let url: URL
    func makeUIView(context: Context) -> PDFView {
        let view = PDFView()
        view.autoScales = true
        view.document = PDFDocument(url: url)
        return view
    }
    func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.document = PDFDocument(url: url)
    }
}

struct RFQView: View {
    @Environment(AppModel.self) private var model
    @State private var showPDF = false

    var body: some View {
        PaperScreen(kicker: model.t("招标", "RFQ"), title: model.t("需求书、三家报价、移交门禁", "Brief, three bids, handover gate")) {
            if model.intake?.hospitality == true {
                StudioCard {
                    Text(model.t("酒店客房不要生成别墅业主 RFQ，也不要发给三家住宅集成商。", "Do not turn hotel rooms into a homeowner RFQ or send it to three residential integrators."))
                        .font(.headline)
                }
            }
            if model.intake?.keypad == .basalte {
                StudioCard {
                    Text(model.t("墙面按巴萨写进需求。Lutron 移交清单不自动套用。Basalte 的工程文件和面板清单要集成商另行写入合同。", "The brief names Basalte. The Lutron handover list is not applied automatically. Basalte project files and the keypad schedule belong in the integrator's contract."))
                        .font(.subheadline)
                }
            }
            StudioCard {
                Text(model.t("状态 \(statusName)", "Status \(statusName)")).font(.headline)
                TextField(model.t("城市", "City"), text: Bindable(model).city)
                TextField(model.t("州或省", "State or province"), text: Bindable(model).stateCode)
                TextField(model.t("邮编，不填门牌", "ZIP only. No street"), text: Bindable(model).zip)
                    .keyboardType(.numbersAndPunctuation)
                Button(model.t("生成 RFQ PDF", "Create the RFQ PDF")) {
                    guard model.intake != nil, !model.city.isEmpty, !model.zip.isEmpty else { return }
                    if let url = try? RFQPDF.write(model) {
                        model.rfqURL = url
                        if model.quotes.isEmpty { model.status = .published }
                        model.save()
                        showPDF = true
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(Studio.ink)
                if model.intake == nil || model.city.isEmpty || model.zip.isEmpty {
                    Text(model.t("需要完成问诊，并填写城市和邮编。不要写街道。", "Finish the consult, then add a city and ZIP. Do not write a street."))
                        .font(.footnote)
                        .foregroundStyle(Studio.clay)
                }
                if let url = model.rfqURL {
                    ShareLink(item: url) { Label(model.t("分享 PDF", "Share PDF"), systemImage: "square.and.arrow.up") }
                    Button(model.t("预览", "Preview")) { showPDF = true }
                }
            }
            .onChange(of: model.city) { _, _ in model.save() }
            .onChange(of: model.zip) { _, _ in model.save() }

            if let retrofits = model.legacyRetrofits, !retrofits.isEmpty {
                StudioCard {
                    Text(model.t("存量改造 / 桥接评估", "Legacy retrofit / bridge review")).font(.headline)
                    Text(model.t("这些名字来自问诊或顾问里点过的档案。卡片不提供市电接线步骤。", "These names were added from a record card. The card does not include line-voltage steps."))
                        .font(.footnote)
                        .foregroundStyle(Studio.mist)
                    ForEach(retrofits) { item in
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text(item.id).font(.caption.monospaced()).foregroundStyle(Studio.mist)
                                Text(item.name).font(.subheadline.weight(.semibold))
                                Spacer()
                                Button(model.t("移除", "Remove")) { model.removeLegacyRetrofit(item.id) }
                                    .font(.caption)
                            }
                            EvidenceBadge(tier: item.tier)
                            Text(item.bridge).font(.caption).fixedSize(horizontal: false, vertical: true)
                            if item.lineVoltage {
                                Text(KeywordRadarCopy.lineVoltageBoundary.text(chinese: model.chinese))
                                    .font(.caption.weight(.semibold))
                                    .foregroundStyle(Studio.clay)
                            }
                            if !item.sourceURL.isEmpty {
                                SourceLink(title: item.id, url: item.sourceURL)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }

            StudioCard {
                Text(model.t("结构化报价", "Structured bids")).font(.headline)
                Text(model.t("最多三家。字段对齐后才比较。示例数字不是任何公司的出价。", "Three at most. Compare only after the fields line up. Sample numbers are not a company's bid."))
                    .font(.footnote)
                    .foregroundStyle(Studio.mist)
                Button(model.t("填入三家示例", "Load three samples")) { model.loadSampleQuotes() }
                    .disabled(model.intake == nil)
                if model.quotes.count < 3 {
                    Button(model.t("加一家空白报价", "Add a blank bid")) { addBlank() }
                        .disabled(model.intake == nil)
                }
                ForEach(model.quotes, id: \.id) { quote in
                    quoteCard(quote)
                }
            }

            if let comparison = model.comparison {
                StudioCard {
                    Text(model.t("X 光对齐", "X-ray alignment")).font(.headline)
                    Text(model.t("编程小时参考 \(comparison.expectedHoursLow)–\(comparison.expectedHoursHigh)。", "Programming-hour reference \(comparison.expectedHoursLow)–\(comparison.expectedHoursHigh)."))
                        .font(.subheadline)
                    ForEach(comparison.portfolioNotes.indices, id: \.self) { index in
                        Text(comparison.portfolioNotes[index].text(chinese: model.chinese))
                            .font(.subheadline)
                            .foregroundStyle(Studio.clay)
                    }
                    ForEach(comparison.columns, id: \.id) { column in
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(column.dealerName) · \(usd(column.total))")
                                .font(.headline)
                            if column.isSample {
                                Text(model.t("示例", "Sample")).font(.caption.weight(.bold)).foregroundStyle(Studio.amber)
                            }
                            ForEach(column.warnings, id: \.code) { warning in
                                Text(warning.message.text(chinese: model.chinese))
                                    .font(.caption)
                                    .foregroundStyle(warning.severity == "high" ? Studio.clay : Studio.amber)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }

            StudioCard {
                Text(model.t("分品牌移交", "Brand-by-brand handover")).font(.headline)
                Text(model.t("Control4 写的是 OvrC 和 customer.control4.com 自助更换 Smart Home Pro。没有笼统的永久绑定说法。未全部勾选不能确认。", "Control4 is described as OvrC plus a customer.control4.com change of Smart Home Pro. There is no blanket permanent-binding claim. Confirmation stays off until every box is checked."))
                    .font(.footnote)
                ForEach(model.handoverItems) { item in
                    Button {
                        if model.checkedHandover.contains(item.id) {
                            model.checkedHandover.remove(item.id)
                        } else {
                            model.checkedHandover.insert(item.id)
                        }
                        model.handoverUnderstood = false
                        model.refreshStatus()
                        model.save()
                    } label: {
                        HStack(alignment: .top) {
                            Image(systemName: model.checkedHandover.contains(item.id) ? "checkmark.square.fill" : "square")
                                .foregroundStyle(Studio.forest)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.brand).font(.caption.weight(.bold))
                                Text(item.text.text(chinese: model.chinese))
                                    .font(.subheadline)
                                    .foregroundStyle(Studio.ink)
                                    .multilineTextAlignment(.leading)
                                HStack {
                                    EvidenceBadge(tier: item.tier)
                                    SourceLink(title: item.sourceName, url: item.url)
                                }
                            }
                        }
                    }
                    .buttonStyle(.plain)
                }
                Button(model.t("我已理解这些移交条款", "I understand these handover terms")) {
                    guard model.handoverReady else { return }
                    model.handoverUnderstood = true
                    model.refreshStatus()
                    model.save()
                }
                .buttonStyle(.borderedProminent)
                .tint(model.handoverReady ? Studio.ink : Studio.mist)
                .disabled(!model.handoverReady)
                if model.handoverUnderstood {
                    Text(model.t("已在本机确认。这不是电子签约。", "Confirmed on this device. This is not an e-signature."))
                        .font(.footnote)
                        .foregroundStyle(Studio.forest)
                }
            }
        }
        .sheet(isPresented: $showPDF) {
            Group {
            if let url = model.rfqURL {
                NavigationStack {
                    PDFKitPreview(url: url)
                        .navigationTitle("RFQ")
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                Button(model.t("首页", "Home")) { model.openHome() }
                            }
                            ToolbarItemGroup(placement: .topBarTrailing) {
                                Button(model.t("设置", "Settings")) { model.openSettings() }
                                Button(model.t("关闭", "Close")) { showPDF = false }
                            }
                        }
                        .onChange(of: model.dockTick) { _, _ in showPDF = false }
                }
            }
            }
            .environment(model)
        }
    }

    private var statusName: String {
        switch model.status {
        case .draft: return model.t("草稿", "Draft")
        case .published: return model.t("需求书已生成", "Brief ready")
        case .quoting: return model.t("比价中", "Comparing")
        case .awarded: return model.t("已选一家", "One selected")
        case .handoverComplete: return model.t("移交条款已读", "Handover read")
        }
    }

    private func addBlank() {
        model.quotes.append(QuoteInput(
            id: UUID().uuidString,
            dealerName: model.t("集成商", "Integrator"),
            isSample: false,
            controlBrand: model.topology?.controlBrand.rawValue ?? "Control4",
            lightingBrand: "Lutron",
            hardware: 0, prewire: 0, labor: 0, programmingCost: 0,
            programmingHours: 0, hourlyRate: 150, rackNetwork: 0,
            annualSubscription: 0, subscriptionMandatory: false,
            handoverAccepted: false, warrantyMonths: 12
        ))
        model.refreshStatus()
        model.save()
    }

    private func quoteCard(_ quote: QuoteInput) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            TextField(model.t("名称", "Name"), text: quoteString(quote.id, \.dealerName))
                .font(.headline)
            numberField(model.t("设备", "Hardware"), quote.id, \.hardware)
            numberField(model.t("布线基建", "Pre-wire"), quote.id, \.prewire)
            numberField(model.t("人工", "Labor"), quote.id, \.labor)
            numberField(model.t("编程费", "Programming $"), quote.id, \.programmingCost)
            numberField(model.t("编程小时", "Programming hours"), quote.id, \.programmingHours)
            numberField(model.t("小时单价", "Hourly rate"), quote.id, \.hourlyRate)
            numberField(model.t("机柜与网络", "Rack and network"), quote.id, \.rackNetwork)
            Toggle(model.t("接受移交条款", "Accepts handover"), isOn: quoteBool(quote.id, \.handoverAccepted))
            Toggle(model.t("订阅被写成强制", "Subscription marked mandatory"), isOn: quoteBool(quote.id, \.subscriptionMandatory))
            Text(model.t("小计 \(usd(QuoteComparator.total(quote)))，不含年费。", "Subtotal \(usd(QuoteComparator.total(quote))), before the yearly fee."))
                .font(.caption)
                .foregroundStyle(Studio.mist)
        }
        .padding(.vertical, 8)
    }

    private func numberField(_ title: String, _ id: String, _ key: WritableKeyPath<QuoteInput, Double>) -> some View {
        HStack {
            Text(title).frame(width: 110, alignment: .leading).font(.caption)
            TextField("0", text: Binding(
                get: {
                    guard let quote = model.quotes.first(where: { $0.id == id }) else { return "" }
                    return String(format: "%.0f", quote[keyPath: key])
                },
                set: { text in
                    guard let index = model.quotes.firstIndex(where: { $0.id == id }) else { return }
                    model.quotes[index][keyPath: key] = Double(text.filter { $0.isNumber || $0 == "." }) ?? 0
                    model.quotes[index].isSample = false
                    model.refreshStatus()
                    model.save()
                }
            ))
            .keyboardType(.decimalPad)
            .textFieldStyle(.roundedBorder)
        }
    }

    private func quoteString(_ id: String, _ key: WritableKeyPath<QuoteInput, String>) -> Binding<String> {
        Binding(
            get: { model.quotes.first { $0.id == id }?[keyPath: key] ?? "" },
            set: { value in
                guard let index = model.quotes.firstIndex(where: { $0.id == id }) else { return }
                model.quotes[index][keyPath: key] = value
                model.save()
            }
        )
    }

    private func quoteBool(_ id: String, _ key: WritableKeyPath<QuoteInput, Bool>) -> Binding<Bool> {
        Binding(
            get: { model.quotes.first { $0.id == id }?[keyPath: key] ?? false },
            set: { value in
                guard let index = model.quotes.firstIndex(where: { $0.id == id }) else { return }
                model.quotes[index][keyPath: key] = value
                model.refreshStatus()
                model.save()
            }
        )
    }
}
