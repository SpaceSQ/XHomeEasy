import SwiftUI
import XHomeEasyEngines

struct RadarStack: View {
    @Environment(AppModel.self) private var model
    let text: String

    private var hits: [RadarHit] { model.radarHits(for: text) }

    var body: some View {
        if !hits.isEmpty {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(Array(hits.prefix(4))) { hit in
                    KeywordRadarCardView(
                        item: hit.record,
                        chinese: model.chinese,
                        alreadyListed: model.containsLegacy(hit.record.id)
                    ) {
                        model.addLegacyRetrofit(hit.record)
                    }
                }
                if hits.count > 4 {
                    Text(model.t("还有 \(hits.count - 4) 条匹配。把句子写短一些，卡片会更准。", "\(hits.count - 4) more matches. A shorter sentence keeps the cards precise."))
                        .font(.caption)
                        .foregroundStyle(Studio.mist)
                }
            }
        }
    }
}

struct KeywordRadarCardView: View {
    let item: RadarRecord
    let chinese: Bool
    var alreadyListed = false
    var onAddLegacyToRFQ: (() -> Void)?
    @Environment(\.openURL) private var openURL
    @State private var showCommunityNote = false

    private var wireless: Bool { item.kind == "wireless" }
    private var accent: Color { wireless ? Studio.amber : Color(red: 0.12, green: 0.35, blue: 0.52) }
    private var showMetrics: Bool { item.evidenceTier != "E4" || showCommunityNote }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            header
            if item.evidenceTier == "E4" {
                Text(chinese ? "E4 社区笔记默认收起，不能当作规格事实。" : "E4 community notes stay folded. They are not a specification.")
                    .font(.caption)
                    .foregroundStyle(Studio.mist)
                Button(chinese ? (showCommunityNote ? "收起社区笔记" : "展开社区笔记") : (showCommunityNote ? "Hide the community note" : "Show the community note")) {
                    showCommunityNote.toggle()
                }
                .font(.caption.weight(.semibold))
            }
            if showMetrics {
                metrics
                comparison
            }
            if KeywordRadarEngine.requiresLicensedElectrician(item) {
                safety
            }
            if wireless {
                redirect
            } else if showMetrics || item.evidenceTier != "E4" {
                bridge
            }
            Text(KeywordRadarCopy.priceDisclaimer.text(chinese: chinese))
                .font(.caption2)
                .foregroundStyle(Studio.mist)
            sources
        }
        .padding(16)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(accent.opacity(0.45), lineWidth: 1))
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .firstTextBaseline) {
                Text(wireless
                    ? (chinese ? "无线生态识别 · 边界提示" : "Wireless brand · outside this advice")
                    : (chinese ? "小众/存量有线系统档案" : "Niche or legacy wired record"))
                    .font(.caption.weight(.bold))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(accent.opacity(0.16))
                    .foregroundStyle(accent)
                    .clipShape(Capsule())
                EvidenceBadge(tier: item.evidenceTier)
                Spacer()
                Text(item.id)
                    .font(.caption2.monospaced())
                    .foregroundStyle(Studio.mist)
            }
            Text(item.brandOrProtocolName)
                .font(.title3.weight(.semibold))
                .foregroundStyle(Studio.ink)
            Text("\(item.operatingCompany) · \(item.foundedYearAndStatus)")
                .font(.footnote)
                .foregroundStyle(Studio.mist)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private var metrics: some View {
        VStack(alignment: .leading, spacing: 8) {
            metric(chinese ? "协议特点" : "Protocol", item.protocolCharacteristics, wireless ? "antenna.radiowaves.left.and.right" : "cable.connector.horizontal")
            metric(chinese ? "主要产品" : "Products", item.mainProducts.joined(separator: "、"), "cpu")
            metric(chinese ? "应用领域" : "Where it is used", item.applicationAreas.joined(separator: "、"), "square.grid.2x2")
            metric(chinese ? "价格区间" : "Published range", item.priceRangeAndModel, "dollarsign.circle")
        }
    }

    private func metric(_ title: String, _ body: String, _ symbol: String) -> some View {
        Label {
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.caption.weight(.bold)).foregroundStyle(Studio.ink)
                Text(body).font(.footnote).foregroundStyle(Studio.ink).fixedSize(horizontal: false, vertical: true)
            }
        } icon: {
            Image(systemName: symbol).foregroundStyle(accent)
        }
    }

    private var comparison: some View {
        HStack(alignment: .top, spacing: 12) {
            column(chinese ? "系统优势" : "Strengths", item.pros, Studio.forest)
            column(chinese ? "系统局限" : "Limits", item.cons, Studio.clay)
        }
        .padding(10)
        .background(Color.primary.opacity(0.04))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    private func column(_ title: String, _ lines: [String], _ color: Color) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title).font(.caption.weight(.bold)).foregroundStyle(color)
            ForEach(Array(lines.enumerated()), id: \.offset) { _, line in
                Text("· \(line)").font(.caption2).foregroundStyle(Studio.mist).fixedSize(horizontal: false, vertical: true)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var safety: some View {
        Text(KeywordRadarCopy.lineVoltageBoundary.text(chinese: chinese))
            .font(.caption.weight(.semibold))
            .foregroundStyle(Studio.clay)
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Studio.clay.opacity(0.08))
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    private var bridge: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(chinese ? "向 Control4 / Crestron / Savant / Lutron 四大主力平台桥接或替换" : "Bridge or replace toward Control4, Crestron, Savant, or Lutron")
                .font(.caption.weight(.bold))
                .foregroundStyle(accent)
            Text(item.fourGiantBridge)
                .font(.caption)
                .fixedSize(horizontal: false, vertical: true)
            Text(item.actionAdvice)
                .font(.caption)
                .foregroundStyle(Studio.mist)
                .fixedSize(horizontal: false, vertical: true)
            Button {
                onAddLegacyToRFQ?()
            } label: {
                Label(
                    alreadyListed
                        ? (chinese ? "已在 RFQ 存量改造清单" : "Already on the RFQ retrofit list")
                        : (chinese ? "一键加入 RFQ 存量改造清单" : "Add to the RFQ retrofit list"),
                    systemImage: alreadyListed ? "checkmark.circle" : "doc.badge.plus"
                )
                .font(.caption.weight(.semibold))
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(accent)
            .disabled(alreadyListed)
        }
        .padding(10)
        .background(accent.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    private var redirect: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(KeywordRadarCopy.wirelessBoundary.text(chinese: chinese))
                .font(.caption.weight(.semibold))
                .foregroundStyle(Studio.amber)
                .fixedSize(horizontal: false, vertical: true)
            if chinese, !item.redirectScript.isEmpty {
                Text(item.redirectScript)
                    .font(.caption2)
                    .foregroundStyle(Studio.mist)
                    .fixedSize(horizontal: false, vertical: true)
            }
            ForEach(sisterOrder, id: \.self) { name in
                Button {
                    openSister(name)
                } label: {
                    Label(sisterTitle(name), systemImage: name == "AHomeEasy" ? "apple.logo" : "point.3.connected.trianglepath.dotted")
                        .font(.caption.weight(.semibold))
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(name == "AHomeEasy" ? Color(red: 0.12, green: 0.35, blue: 0.52) : Color(red: 0.28, green: 0.27, blue: 0.55))
            }
        }
        .padding(10)
        .background(Studio.amber.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    private var sisterOrder: [String] {
        let known = item.redirectTargets.filter { $0 == "AHomeEasy" || $0 == "MHomeEasy" }
        return known.isEmpty ? ["AHomeEasy", "MHomeEasy"] : known
    }

    private func sisterTitle(_ name: String) -> String {
        if name == "AHomeEasy" {
            return chinese ? "打开 AHomeEasy（苹果生态）" : "Open AHomeEasy (Apple Home)"
        }
        return chinese ? "打开 MHomeEasy（Matter 生态）" : "Open MHomeEasy (Matter)"
    }

    private func openSister(_ name: String) {
        var parts = URLComponents(string: "https://apps.apple.com/us/search")
        parts?.queryItems = [URLQueryItem(name: "term", value: name)]
        if let url = parts?.url {
            openURL(url)
        }
    }

    private var sources: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(Array(item.sources.enumerated()), id: \.offset) { _, source in
                SourceLink(title: source.note.isEmpty ? source.fetchedOn : "\(source.note) · \(source.fetchedOn)", url: source.url)
            }
        }
    }
}
