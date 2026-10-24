import SwiftUI
import XHomeEasyEngines

struct LifecycleView: View {
    @Environment(AppModel.self) private var model

    var body: some View {
        @Bindable var model = model
        return PaperScreen(kicker: model.t("陪伴", "LIFECYCLE"), title: model.t("工期、订阅、接手、边界", "Schedule, subscriptions, handover, limits")) {
            if model.adaptation?.prewireWindow == true {
                StudioCard {
                    Text(model.t("干墙还没封", "Drywall is still open")).font(.headline)
                    Text(model.t("把弱电路径写进总包日程。本页不说明如何穿线或上电。", "Put the low-voltage pathways on the builder's schedule. This page does not explain how to pull cable or energize anything."))
                }
            }
            StudioCard {
                Text(model.t("六个阶段", "Six stages")).font(.headline)
                ForEach(stages, id: \.id) { stage in
                    check(stage.id, stage.title, stage.detail, model.stageDone) { id in
                        toggle(&model.stageDone, id)
                    }
                }
            }
            StudioCard {
                Text(model.t("订阅雷达", "Subscription radar")).font(.headline)
                Text(model.t("自己勾选现状。这里不代任何厂商收费，也不填一个未公开的价格。", "Check what you actually have. This app does not bill a manufacturer and does not invent an unpublished price."))
                    .font(.footnote)
                    .foregroundStyle(Studio.mist)
                check("connect", "Control4 Connect", model.t("是否在用，谁付费，续费是不是自愿。", "In use or not, who pays, and whether renewal is optional."), model.subscriptionChecks) { toggle(&model.subscriptionChecks, $0) }
                check("assist", "Assist", model.t("是否在用。", "In use or not."), model.subscriptionChecks) { toggle(&model.subscriptionChecks, $0) }
                check("essentials", "Savant Essentials", model.t("价格以经销商书面为准。公开价未核实。", "Price comes from the dealer in writing. A public price was not verified."), model.subscriptionChecks) { toggle(&model.subscriptionChecks, $0) }
                check("local", model.t("本地维保", "Local service plan"), model.t("年限和上门范围。", "Term and what a visit includes."), model.subscriptionChecks) { toggle(&model.subscriptionChecks, $0) }
            }
            StudioCard {
                Text(model.t("接手已有系统", "An inherited system")).font(.headline)
                check("photo", model.t("记录主机和机柜型号", "Record the host and rack model"), model.t("只拍照和抄型号。不要拆电。", "Photograph and copy the model numbers. Do not open live equipment."), model.inheritedChecks) { toggle(&model.inheritedChecks, $0) }
                check("dealer", model.t("找到原来的集成商", "Find the previous integrator"), model.t("先问移交，不要恢复出厂。", "Ask about handover before any factory reset."), model.inheritedChecks) { toggle(&model.inheritedChecks, $0) }
                check("c4", "Control4", model.t("问 OvrC 归属和 customer.control4.com。", "Ask about OvrC ownership and customer.control4.com."), model.inheritedChecks) { toggle(&model.inheritedChecks, $0) }
                check("nocrack", model.t("不购买破解软件", "Do not buy a cracked tool"), model.t("Composer、Configure、Savant 工具只走授权经销商。", "Composer, Configure, and Savant tools stay with an authorized dealer."), model.inheritedChecks) { toggle(&model.inheritedChecks, $0) }
            }
            StudioCard {
                Text(model.t("给设计师的中立摘要", "Neutral brief for a designer")).font(.headline)
                Text(brief)
                    .font(.footnote)
                    .textSelection(.enabled)
                ShareLink(item: brief) { Label(model.t("分享摘要", "Share the brief"), systemImage: "square.and.arrow.up") }
                Text(model.t("这一版在本机分享文字。还没有云端协作席位。", "This build shares text from the device. There is no cloud studio seat yet."))
                    .font(.caption)
                    .foregroundStyle(Studio.mist)
            }
            StudioCard {
                Text(model.t("附录 B · 安全边界", "Appendix B · Safety boundary")).font(.headline)
                ForEach(Array(EvidenceCopy.redLines.enumerated()), id: \.offset) { _, line in
                    Text(line.text(chinese: model.chinese)).font(.subheadline)
                }
                Text(model.t("断电、验电、对照说明书只是一般提醒，不是操作规程。", "Power off, test, and read the manual are general reminders, not a procedure."))
                    .font(.footnote)
            }
            StudioCard {
                Text(model.t("隐私与披露", "Privacy and disclosure")).font(.headline)
                Text(model.t("Do Not Sell or Share My Personal Information：这一版的项目草稿只留在本机，没有出售或共享个人信息。若以后上云，将提供 CCPA/CPRA 的删除、更正和退出入口。", "Do Not Sell or Share My Personal Information: this build keeps the project draft on the device and does not sell or share personal information. A later cloud version will offer CCPA/CPRA delete, correct, and opt-out."))
                    .font(.subheadline)
                Text(model.t("排序参数：证据等级，然后是名称或文本匹配。不按佣金。Sponsored 必须单独标出。", "Sort: evidence tier, then name or text match. Not commission. Sponsored is labeled on its own."))
                    .font(.subheadline)
                Text(model.t("商标 Control4、Crestron、Savant、Lutron、CEDIA 属于各自权利人。这里是指名引用。", "Control4, Crestron, Savant, Lutron, and CEDIA are trademarks of their owners. They are named here, not endorsed."))
                    .font(.subheadline)
                Toggle(model.t("界面用中文", "Chinese interface"), isOn: $model.chinese)
                    .onChange(of: model.chinese) { _, _ in
                        Task { @MainActor in model.save() }
                    }
            }
            if let counts = model.library?.manifest.counts {
                Text(model.t(
                    "离线库：品牌 \(counts["brands"] ?? 0)，案例 \(counts["cases"] ?? 0)，融合 \(counts["fusion"] ?? 0)，子系统 \(counts["subsystems"] ?? 0)，渠道 \(counts["partners"] ?? 0)。核实日 2026-10-21。",
                    "Offline library: brands \(counts["brands"] ?? 0), cases \(counts["cases"] ?? 0), fusion \(counts["fusion"] ?? 0), subsystems \(counts["subsystems"] ?? 0), partners \(counts["partners"] ?? 0). Verified 2026-10-21."
                ))
                .font(.caption)
                .foregroundStyle(Studio.mist)
            }
        }
    }

    private var stages: [(id: String, title: String, detail: String)] {
        [
            ("design", model.t("设计冻结", "Design freeze"), model.t("房间、档位和主机方向先写下来，再请人进场。", "Write the rooms, the package, and the host direction before anyone mobilizes.")),
            ("prewire", model.t("粗装布线窗口", "Pre-wire window"), model.t("封板前的日程提醒。穿线由持证集成商做。", "A schedule reminder before the walls close. The integrator pulls the cable.")),
            ("paint", model.t("油漆前点位", "Locations before paint"), model.t("核对面板和音箱位置，不在这里画接线图。", "Confirm keypad and speaker locations. No wiring diagram here.")),
            ("power", model.t("设备与机柜", "Equipment and rack"), model.t("上电属于持证电工和集成商。", "Energizing belongs to a licensed electrician and the integrator.")),
            ("program", model.t("编程与场景", "Programming"), model.t("问清包含的小时和变更单价。", "Ask for included hours and the change-order rate.")),
            ("train", model.t("培训与移交", "Training and handover"), model.t("按品牌拿走文件、账号和培训记录。", "Leave with the files, accounts, and training record for that brand.")),
        ]
    }

    private var brief: String {
        let plan = model.topology
        let band = model.budget.map { "\(usd($0.totalLow)) – \(usd($0.totalHigh))" } ?? "—"
        let rooms = model.rooms.map { "\($0.name): \($0.note)" }.joined(separator: "\n")
        return """
        X Home Easy
        \(model.city), \(model.stateCode) \(model.zip)
        \(plan?.lightingBase ?? "Lutron") + \(plan?.controlBrand.rawValue ?? "—") · \(plan?.packageTier.rawValue ?? "—")
        \(band)
        \(model.t("带宽不是报价。", "The band is not a bid."))
        \(rooms)
        """
    }

    private func check(_ id: String, _ title: String, _ detail: String, _ set: Set<String>, _ action: @escaping (String) -> Void) -> some View {
        Button { action(id) } label: {
            HStack(alignment: .top) {
                Image(systemName: set.contains(id) ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(Studio.forest)
                VStack(alignment: .leading, spacing: 2) {
                    Text(title).foregroundStyle(Studio.ink)
                    Text(detail).font(.caption).foregroundStyle(Studio.mist).multilineTextAlignment(.leading)
                }
            }
        }
        .buttonStyle(.plain)
    }

    private func toggle(_ set: inout Set<String>, _ id: String) {
        if set.contains(id) { set.remove(id) } else { set.insert(id) }
        model.save()
    }
}
