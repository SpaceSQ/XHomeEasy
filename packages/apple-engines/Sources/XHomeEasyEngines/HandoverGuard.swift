import Foundation

public enum HandoverGuard {
    public static func items(for brands: [String]) -> [HandoverItem] {
        var seen = Set<String>()
        return brands.filter { seen.insert($0).inserted }.flatMap { catalog[$0] ?? [] }
    }

    public static func isComplete(brands: [String], checkedIds: Set<String>) -> Bool {
        items(for: brands).allSatisfy { checkedIds.contains($0.id) }
    }

    private static let catalog: [String: [HandoverItem]] = [
        "Control4": [
            item("c4-ovrc", "Control4", "E1", "Snap One Help · Dealer of Record change", "https://help.snapone.com/ovrc-ug/Content/C4CA/Dealer%20of%20Record%20Change.htm", "At acceptance the integrator transfers OvrC project ownership to the household.", "验收时，集成商在 OvrC 把项目归属交到业主名下。"),
            item("c4-account", "Control4", "E1", "Snap One Help · Dealer of Record change", "https://help.snapone.com/ovrc-ug/Content/C4CA/Dealer%20of%20Record%20Change.htm", "The household receives its own customer.control4.com login so it can change Smart Home Pro (Dealer of Record) later.", "业主获得自己的 customer.control4.com 登录，以便日后自行更换 Smart Home Pro（Dealer of Record）。"),
            item("c4-resources", "Control4", "E1", "Snap One Help · Dealer of Record change", "https://help.snapone.com/ovrc-ug/Content/C4CA/Dealer%20of%20Record%20Change.htm", "The project on the controller stays with the customer. Linked Resources and notification settings are rebuilt by the next Pro. That is a known step, not a reason to claim the system cannot move.", "控制器上的项目归客户。Linked Resources 和通知设置要由下一家 Pro 重新配置。这是已知步骤，不是系统不能移交的理由。"),
            item("c4-connect", "Control4", "E1", "Control4 Services", "https://www.control4.com/services", "Control4 Connect (it replaced 4Sight on 2024-04-23) and Assist are listed with their yearly price, who bills them, and that renewal is a choice unless the contract says otherwise.", "Control4 Connect（2024-04-23 起替代 4Sight）和 Assist 要写明年费、由谁收费，以及除非合同另有约定，续费是可以选择的。"),
        ],
        "Crestron": [
            item("cr-which", "Crestron", "E1", "Crestron Home OS manual", "https://docs.crestron.com/en-us/9599/Content/Topics/Overview/Overview.htm", "The contract states whether this job is Crestron Home (Configure Pro) or custom SIMPL programming.", "合同写明本项目是 Crestron Home（Configure Pro）还是定制 SIMPL 编程。"),
            item("cr-source", "Crestron", "E1", "Crestron Home OS manual", "https://docs.crestron.com/en-us/9599/Content/Topics/Overview/Overview.htm", "If the job includes SIMPL, the uncompiled source (.smw) and passwords transfer to the owner at final payment and are the owner's property.", "如果包含 SIMPL，未编译源码（.smw）和密码在尾款时交给业主，并归业主所有。"),
            item("cr-backup", "Crestron", "E1", "Crestron Home OS manual", "https://docs.crestron.com/en-us/9599/Content/Topics/Overview/Overview.htm", "A full Crestron Home configuration backup and an administrator login are handed to the household.", "完整的 Crestron Home 配置备份和管理员登录交给业主。"),
            item("cr-monitor", "Crestron", "E2", "Crestron XiO Cloud", "https://www.crestron.com/Products/Featured-Solutions/XiO-Cloud", "Residential monitoring access is named in the contract. XiO Cloud is not described here as the homeowner's subscription.", "合同写明住宅监控权限。这里不把 XiO Cloud 说成业主的订阅产品。"),
        ],
        "Savant": [
            item("sv-host", "Savant", "E1", "Savant Host", "https://www.savant.com/host/", "The Savant Host configuration backup is archived and the household is told where that copy lives.", "Savant Host 的配置备份要存档，并告知业主副本放在哪里。"),
            item("sv-essentials", "Savant", "E1", "Savant Host", "https://www.savant.com/host/", "Savant Essentials price, what it includes, and a written release of the account when the authorized dealer changes are in the contract. Public Essentials pricing was not verified on 2026-10-21.", "合同写明 Savant Essentials 的价格、包含的权益，以及更换授权经销商时无条件释放账号。2026-10-21 未核实到 Essentials 的公开标价。"),
        ],
        "Lutron": [
            item("lu-file", "Lutron", "E1", "Lutron HomeWorks", "https://www.lutron.com/us/en/controls/systems/homeworks", "A copy of the HomeWorks project database is given to the household at acceptance.", "验收时把 HomeWorks 工程数据库副本交给业主。"),
            item("lu-admin", "Lutron", "E1", "Lutron HomeWorks", "https://www.lutron.com/us/en/controls/systems/homeworks", "The household receives the Lutron app administrator login, the final keypad engraving schedule, and the warranty terms.", "业主收到 Lutron App 管理员登录、最终按键雕刻清单和质保条款。"),
        ],
    ]

    private static func item(_ id: String, _ brand: String, _ tier: String, _ source: String, _ url: String, _ en: String, _ zh: String) -> HandoverItem {
        HandoverItem(id: id, brand: brand, text: Copy(en: en, zh: zh), tier: tier, sourceName: source, url: url)
    }
}
