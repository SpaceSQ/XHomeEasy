import XHomeEasyEngines

struct MatrixCell: Identifiable {
    var brand: String
    var body: Copy
    var tier: String
    var source: String
    var url: String
    var id: String { brand + url }
}

struct MatrixRow: Identifiable {
    var title: Copy
    var cells: [MatrixCell]
    var id: String { title.en }
}

enum BrandMatrix {
    static let cedia = "https://www.cepro.com/news/cedia-research-pegs-u-s-residential-tech-market-at-33-8-billion-with-ai-and-skilled-labor-defining-the-year-ahead/628665/"
    static let rows: [MatrixRow] = [
        MatrixRow(title: Copy(en: "Market role", zh: "市场角色"), cells: [
            cell("Control4", "Widest whole-home mention in CEDIA 2026 at 63%. About 6,000 authorized integrators on the company page.", "CEDIA 2026 全屋控制提及率 63%，公司页面写明约 6,000 家授权集成商。", "E2", "CE Pro", cedia),
            cell("Crestron", "43% whole-home mention. Often specified when the house or the program is more custom.", "全屋提及率 43%。房子或编程更定制时经常被写进规格。", "E2", "CE Pro", cedia),
            cell("Savant", "33% whole-home mention. Known for the interface and Savant Power, not for a public Essentials price.", "全屋提及率 33%。以界面和 Savant Power 著称。Essentials 没有核实到的公开标价。", "E2", "CE Pro", cedia),
            cell("Lutron", "76% lighting and 77% shade mention. Usually the base beside one host, not a statistic that every house uses it.", "照明提及率 76%，遮阳 77%。通常是主机旁边的底座，不是“每家都用”的统计。", "E2", "CE Pro", cedia),
        ]),
        MatrixRow(title: Copy(en: "Handover", zh: "移交"), cells: [
            cell("Control4", "After an OvrC transfer, the household can change Smart Home Pro at customer.control4.com. Linked Resources are rebuilt by the next Pro.", "OvrC 移交之后，业主可以在 customer.control4.com 更换 Smart Home Pro。Linked Resources 由下一家 Pro 重建。", "E1", "Snap One Help", "https://help.snapone.com/ovrc-ug/Content/C4CA/Dealer%20of%20Record%20Change.htm"),
            cell("Crestron", "Write down Crestron Home versus SIMPL. Uncompiled .smw source transfers only when the contract says the owner keeps it.", "写明是 Crestron Home 还是 SIMPL。未编译 .smw 只有在合同写明归业主时才移交。", "E1", "Crestron Home", "https://docs.crestron.com/en-us/9599/Content/Topics/Overview/Overview.htm"),
            cell("Savant", "Host backup location and a written Essentials account release belong in the contract.", "合同要写 Host 备份放在哪里，以及 Essentials 账号如何书面释放。", "E1", "Savant Host", "https://www.savant.com/host/"),
            cell("Lutron", "Ask for the HomeWorks project database, the app admin login, and the engraving schedule at acceptance.", "验收时要 HomeWorks 工程库、App 管理员登录和按键雕刻清单。", "E1", "Lutron HomeWorks", "https://www.lutron.com/us/en/controls/systems/homeworks"),
        ]),
        MatrixRow(title: Copy(en: "Remote service", zh: "远程服务"), cells: [
            cell("Control4", "Connect replaced 4Sight on 2024-04-23. Assist is optional. Ask who bills the renewal.", "Connect 在 2024-04-23 替代 4Sight。Assist 可选。问清续费账单谁出。", "E1", "Control4 Services", "https://www.control4.com/services"),
            cell("Crestron", "Name residential monitoring in the contract. XiO Cloud is not the homeowner subscription story.", "合同写明住宅监控。XiO Cloud 不是这里的业主订阅叙事。", "E2", "Crestron", "https://www.crestron.com/Products/Featured-Solutions/XiO-Cloud"),
            cell("Savant", "Essentials is dealer-managed. A public price was not verified on 2026-10-21.", "Essentials 由经销商管理。2026-10-21 没有核实到公开价格。", "E1", "Savant Host", "https://www.savant.com/host/"),
            cell("Lutron", "Remote access usually follows the system and the dealer. Confirm it on the quote.", "远程一般跟着系统和经销商。在报价单上确认。", "E1", "Lutron", "https://www.lutron.com/us/en/controls/systems/homeworks"),
        ]),
    ]

    private static func cell(_ brand: String, _ en: String, _ zh: String, _ tier: String, _ source: String, _ url: String) -> MatrixCell {
        MatrixCell(brand: brand, body: Copy(en: en, zh: zh), tier: tier, source: source, url: url)
    }
}
