import SwiftUI

struct IntegratorsView: View {
    @Environment(AppModel.self) private var model
    @State private var query = ""
    @State private var brand = "All"
    @State private var stateFilter = "All"
    @State private var selected: PartnerEntry?

    private var results: [PartnerEntry] {
        guard let partners = model.library?.partners else { return [] }
        return partners.filter { partner in
            let brandOK = brand == "All" || partner.brands.contains { $0.caseInsensitiveCompare(brand) == .orderedSame }
            let stateOK = stateFilter == "All" || partner.state.caseInsensitiveCompare(stateFilter) == .orderedSame
            let text = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            let textOK = text.isEmpty || partner.name.lowercased().contains(text) || partner.city.lowercased().contains(text) || partner.state.lowercased().contains(text)
            return brandOK && stateOK && textOK
        }
        .sorted {
            if EvidenceRank.sortKey($0.tier) != EvidenceRank.sortKey($1.tier) {
                return EvidenceRank.sortKey($0.tier) < EvidenceRank.sortKey($1.tier)
            }
            return $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
        }
    }

    var body: some View {
        PaperScreen(kicker: model.t("渠道", "INTEGRATORS"), title: model.t("公开名录，不是全量黄页", "A public sample, not a complete directory")) {
            StudioCard {
                Text(model.t(
                    "当前名录来源于公开可检索渠道抽样与商户自主认领（截至 2026-10-21），非全美或 CEDIA 全量目录。不能用各品牌行数比较市场份额。执照状态只以核验时间为准，签约前请向所在州查询电气与低电压执照。支持本地持证集成商免费认领。赞助位会标 Sponsored，并且不会因此排到前面。这一版离线名录没有赞助位。",
                    "This directory is a public sample plus future claims, as of 2026-10-21. It is not a national or CEDIA-complete list. Do not read row counts as market share. A license display is only as fresh as its check date. Before you sign, confirm electrical and low-voltage licensing with the state. Sponsored placements are labeled and are not sorted first. This offline edition has none."
                ))
                .font(.footnote)
                .fixedSize(horizontal: false, vertical: true)
                if let counts = model.library?.manifest.counts {
                    Text(model.t("已载入 \(counts["partners"] ?? 0) 行。", "\(counts["partners"] ?? 0) rows loaded."))
                        .font(.caption)
                        .foregroundStyle(Studio.mist)
                }
                if let error = model.libraryError {
                    Text(error).foregroundStyle(Studio.clay)
                }
            }
            TextField(model.t("名称或城市", "Name or city"), text: $query)
                .textFieldStyle(.roundedBorder)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    filterChip("All", brand) { brand = "All" }
                    filterChip("Control4", brand) { brand = "Control4" }
                    filterChip("Crestron", brand) { brand = "Crestron" }
                    filterChip("Savant", brand) { brand = "Savant" }
                    filterChip("Lutron", brand) { brand = "Lutron" }
                }
            }
            Picker(model.t("地区", "Region"), selection: $stateFilter) {
                Text(model.t("全部地区", "All regions")).tag("All")
                ForEach(model.library?.manifest.states ?? [], id: \.self) { state in
                    Text(state).tag(state)
                }
            }
            Text(model.t("\(results.count) 条匹配。列表按证据等级再按名称，不按佣金。", "\(results.count) matches. Sorted by evidence, then name. Not by commission."))
                .font(.caption)
                .foregroundStyle(Studio.mist)
            ForEach(results.prefix(60)) { partner in
                Button { selected = partner } label: {
                    StudioCard {
                        HStack {
                            Text(partner.name).font(.headline).foregroundStyle(Studio.ink).multilineTextAlignment(.leading)
                            Spacer()
                            EvidenceBadge(tier: partner.tier)
                        }
                        if partner.sponsored {
                            Text("Sponsored")
                                .font(.caption.weight(.bold))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 3)
                                .background(Studio.amber)
                                .foregroundStyle(.white)
                                .clipShape(Capsule())
                        }
                        Text([partner.city, partner.state, partner.country].filter { !$0.isEmpty }.joined(separator: ", "))
                            .font(.subheadline)
                            .foregroundStyle(Studio.mist)
                        Text(partner.brands.joined(separator: " · "))
                            .font(.caption)
                        if !partner.certs.isEmpty {
                            Text(partner.certs.joined(separator: " · "))
                                .font(.caption2)
                                .foregroundStyle(Studio.bronze)
                        }
                    }
                }
                .buttonStyle(.plain)
            }
            if results.count > 60 {
                Text(model.t("先显示 60 条。把城市或品牌收窄。", "Showing the first 60. Narrow the city or the brand."))
                    .font(.footnote)
                    .foregroundStyle(Studio.mist)
            }
        }
        .sheet(item: $selected) { partner in
            PartnerDetail(partner: partner)
                .environment(model)
        }
    }

    private func filterChip(_ title: String, _ current: String, _ action: @escaping () -> Void) -> some View {
        Button(title, action: action)
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .foregroundStyle(current == title ? Color.white : Studio.ink)
            .background(current == title ? Studio.ink : Studio.card)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Studio.rule, lineWidth: 1))
    }
}

struct PartnerDetail: View {
    @Environment(AppModel.self) private var model
    @Environment(\.dismiss) private var dismiss
    let partner: PartnerEntry

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    EvidenceBadge(tier: partner.tier)
                    Text(partner.name).font(.system(size: 28, weight: .regular, design: .serif))
                    Text(model.t("公开目录字段。不是平台背书，也不是实时执照。抓取日 \(partner.fetchedOn)。", "Public directory fields. Not an endorsement and not a live license. Fetched \(partner.fetchedOn)."))
                        .font(.footnote)
                        .foregroundStyle(Studio.mist)
                    if !partner.phone.isEmpty, let url = URL(string: "tel:\(partner.phone.filter { $0.isNumber || $0 == "+" })") {
                        Link(partner.phone, destination: url)
                    }
                    if !partner.email.isEmpty {
                        Text(model.t("公开邮箱 \(partner.email)", "Public email \(partner.email)")).font(.subheadline)
                    }
                    if !partner.website.isEmpty {
                        SourceLink(title: partner.website, url: websiteURL)
                    }
                    SourceLink(title: model.t("目录来源", "Directory source"), url: partner.url)
                    Button(model.claimInterests.contains(partner.id) ? model.t("认领意向已留在本机", "Claim interest saved on this device") : model.t("留下认领意向", "Save a claim interest")) {
                        model.claimInterests.insert(partner.id)
                        model.save()
                    }
                    .buttonStyle(.bordered)
                    Text(model.t("认领意向只存在这台设备上。这一版没有把资料上传到云端工作台。", "The claim interest stays on this device. This build does not upload it to a cloud desk."))
                        .font(.footnote)
                        .foregroundStyle(Studio.mist)
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(Studio.paper)
            .navigationTitle(partner.city.isEmpty ? partner.state : partner.city)
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

    private var websiteURL: String {
        partner.website.hasPrefix("http") ? partner.website : "https://\(partner.website)"
    }
}
