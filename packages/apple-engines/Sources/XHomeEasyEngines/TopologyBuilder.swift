import Foundation

public enum TopologyBuilder {
    public static func recommendedControlBrand(_ input: Intake, tier: PackageTier) -> ControlBrand {
        if input.hospitality { return .crestron }
        if input.legacy == .crestron { return .crestron }
        if input.legacy == .savant { return .savant }
        if input.legacy == .control4 { return .control4 }
        if input.multiBuilding || (tier == .best && (input.sqft == .over8000 || (input.cinema && input.pool))) { return .crestron }
        if input.keypad == .basalte { return .control4 }
        if input.energyPriority && !input.multiBuilding && tier != .good && input.sqft != .over8000 { return .savant }
        if input.legacy == .appleHome && tier != .good && input.budget != .under25k && input.budget != .unstated { return .savant }
        return .control4
    }

    public static func build(_ input: Intake, tier: PackageTier, controlOverride: ControlBrand? = nil) -> TopologyPlan {
        let adaptation = AdaptationScorer.score(input)
        if input.hospitality {
            return TopologyPlan(
                packageTier: tier,
                lightingBase: "Guest-room standard, not a villa base",
                controlBrand: .crestron,
                voiceLayer: nil,
                layers: [
                    LayerCard(
                        name: Copy(en: "Outside the villa model", zh: "超出别墅模型"),
                        detail: Copy(en: "Crestron is named here only because large custom buildings are often discussed with that company. This screen does not specify a hotel system, a guest Apple workflow, or a voice product.", zh: "这里出现 Crestron，只是因为大型定制建筑经常会提到这家公司。本页不指定酒店系统、客人的苹果设备流程，或某一款语音产品。"),
                        tier: "E2",
                        url: "https://www.crestron.com/Products/Featured-Solutions/XiO-Cloud"
                    ),
                ],
                subsystemCategories: [],
                fusionHint: adaptation.scopeNote ?? Copy(en: "Hospitality is out of scope.", zh: "酒店不在别墅范围内。"),
                prewireWindow: false,
                specificationWithheld: true
            )
        }
        let controlBrand = controlOverride ?? recommendedControlBrand(input, tier: tier)
        let lightingBase = input.keypad == .basalte ? "Basalte wall keypads" : (input.sqft == .under3000 && tier == .good ? "Lutron RadioRA 3" : "Lutron HomeWorks")
        let voiceLayer: String? = tier == .best && (input.cinema || input.sqft == .over8000) ? "Josh.ai" : nil
        var layers: [LayerCard] = [
            LayerCard(
                name: Copy(en: "Layer 0 · Timing", zh: "第 0 层 · 时机"),
                detail: adaptation.prewireWindow
                    ? Copy(en: "New work or a major renovation: freeze low-voltage pathways before drywall. This is a schedule reminder, not a wiring guide.", zh: "新建或大翻修：封干墙前冻结低电压路径。这是工期提醒，不是穿线指南。")
                    : Copy(en: "Occupied or inherited house: mark each room as wireable, wireless, or needs a site visit. Do not open walls from an app.", zh: "已入住或接手的房子：每个房间标成可布线、倾向无线或必须现场评估。不要照着 App 开墙。"),
                tier: "E2",
                url: "https://www.cepro.com/news/cedia-research-pegs-u-s-residential-tech-market-at-33-8-billion-with-ai-and-skilled-labor-defining-the-year-ahead/628665/"
            ),
            LayerCard(
                name: Copy(en: "Layer 1 · Light and shade", zh: "第 1 层 · 照明与遮阳"),
                detail: input.keypad == .basalte
                    ? Copy(en: "The owner specified Basalte wall keypads. A KNX Association case, House BE, uses Basalte Sentido with a Control4 interface. Lutron remains a different base if the specification changes. This does not include a wiring diagram.", zh: "业主指定了巴萨墙面面板。KNX 协会的 House BE 案例用 Basalte Sentido 配合 Control4 界面。如果规格改了，Lutron 仍是另一种底座。这里没有接线图。")
                    : Copy(en: "\(lightingBase) is the usual lighting and shade base beside a control host. Lutron's CEDIA mention share is high. That is not a statistic that every house uses it.", zh: "\(lightingBase) 是控制主机旁边常见的照明与遮阳底座。Lutron 在 CEDIA 的提及率很高，这不是“每家都在用”的统计。"),
                tier: "E1",
                url: input.keypad == .basalte
                    ? "https://knx.org/news/case-study-knx-and-control-4-integrate-unified-control-belgian-smart-home"
                    : "https://www.lutron.com/us/en/controls/systems/homeworks"
            ),
            LayerCard(
                name: Copy(en: "Layer 2 · Control host", zh: "第 2 层 · 控制主机"),
                detail: controlCopy(controlBrand),
                tier: "E1",
                url: controlURL(controlBrand)
            ),
        ]
        if voiceLayer != nil {
            layers.append(LayerCard(
                name: Copy(en: "Layer 3 · Voice", zh: "第 3 层 · 语音"),
                detail: Copy(en: "Josh.ai is an optional local voice layer on top of a host. CEDIA 2026 mention share is 32%. It is not a fourth control system you must buy.", zh: "Josh.ai 是主机之上的可选本地语音层。CEDIA 2026 提及率 32%。它不是必须购买的第四套控制系统。"),
                tier: "E2",
                url: "https://www.crestron.com/Partners/Integrated-Partners/josh-ai"
            ))
        } else if input.legacy == .appleHome || input.legacy == .matter {
            layers.append(LayerCard(
                name: Copy(en: "Layer 3 · Front end you already have", zh: "第 3 层 · 已经在用的前端"),
                detail: Copy(en: "Keep Apple Home or Matter as a room front end where it already works. Whole-home shades, audio, and the rack stay on the integrator host.", zh: "Apple Home 或 Matter 已经好用的房间可以保留。全屋遮阳、音频和机柜仍放在集成商的主机上。"),
                tier: "E2",
                url: "https://www.cepro.com/news/cedia-research-pegs-u-s-residential-tech-market-at-33-8-billion-with-ai-and-skilled-labor-defining-the-year-ahead/628665/"
            ))
        }

        var categories: [String] = []
        if input.multiRoomAudio || input.cinema || tier != .good { categories.append("luxury-av") }
        if input.hvacZones { categories.append("hvac") }
        if tier != .good { categories.append("security") }
        if input.hvacZones || tier == .best { categories.append("ventilation-erv") }
        if input.shades || input.pool || input.largeGarden || input.outdoorLiving || tier == .best { categories.append("shades-climate-aux") }
        if input.elderCare && !categories.contains("security") { categories.append("security") }
        if input.elderCare && !categories.contains("hvac") { categories.append("hvac") }
        layers.append(LayerCard(
            name: Copy(en: "Layer 4 · House systems", zh: "第 4 层 · 别墅子系统"),
            detail: Copy(en: "Theater, HVAC, security, fresh air, shades, and pool stay understandable when one wired host supervises them. The cards below cite why, and they are not a bill of materials.", zh: "影院、暖通、安防、新风、遮阳和泳池，由一台有线主机统一监管时才容易验收。下面的卡片只说明原因，不是设备清单。"),
            tier: "E2",
            url: "https://www.control4.com/company"
        ))
        return TopologyPlan(
            packageTier: tier,
            lightingBase: lightingBase,
            controlBrand: controlBrand,
            voiceLayer: voiceLayer,
            layers: layers,
            subsystemCategories: categories,
            fusionHint: fusionHint(input, controlBrand),
            prewireWindow: adaptation.prewireWindow,
            specificationWithheld: false
        )
    }

    private static func controlCopy(_ brand: ControlBrand) -> Copy {
        switch brand {
        case .crestron:
            return Copy(en: "Crestron Home fits larger and more custom houses. If the job needs SIMPL programming, the contract must say who owns the uncompiled source.", zh: "Crestron Home 适合更大、更定制的房子。如果工程要写 SIMPL，合同必须写明未编译源码归谁。")
        case .savant:
            return Copy(en: "Savant is the Apple-like interface and Savant Power option. Essentials pricing was not public on 2026-10-21, so the dealer must price it in writing.", zh: "Savant 的界面更接近苹果，并可选 Savant Power。2026-10-21 未见 Essentials 公开标价，必须由经销商书面报价。")
        case .control4:
            return Copy(en: "Control4 has the widest dealer footprint in the verified notes: about 6,000 authorized integrators and 25,000+ third-party devices on the company page.", zh: "在已核实材料里，Control4 的经销商覆盖最广：公司页面写明约 6,000 家授权集成商、25,000 个以上第三方设备。")
        }
    }

    private static func controlURL(_ brand: ControlBrand) -> String {
        switch brand {
        case .crestron: return "https://docs.crestron.com/en-us/9599/Content/Topics/Overview/Overview.htm"
        case .savant: return "https://www.savant.com/host/"
        case .control4: return "https://www.control4.com/company"
        }
    }

    private static func fusionHint(_ input: Intake, _ brand: ControlBrand) -> Copy {
        if input.legacy == .matter || input.stage == .retrofitExisting {
            return Copy(
                en: "Matter overlay: keep certified wireless devices where they already work. Lutron's professional line is conservative about native Matter, so the practical path is Clear Connect, the host bridge, or a documented gateway such as 1Home. Savant public native Matter/KNX pages were thin on 2026-10-21.",
                zh: "Matter 叠加：已经在用的认证无线设备可以留下。Lutron 专业线对原生 Matter 偏保守，实际路径是 Clear Connect、主机桥，或有公开说明的网关（如 1Home）。截至 2026-10-21，Savant 原生 Matter/KNX 的公开官方页较少。"
            )
        }
        if brand == .savant {
            return Copy(
                en: "Do not invent a Savant-native KNX or Matter gateway. Show only sourced fusion cards, and label European or Middle East projects so they are not read as a local crew map.",
                zh: "不要编造 Savant 原生的 KNX 或 Matter 网关。只展示有来源的融合卡片，欧洲和中东项目必须标地域，避免被看成当地施工队地图。"
            )
        }
        return Copy(
            en: "Where a KNX backbone shows up in the library, it is usually comfort and HVAC under a Control4 or Crestron interface. North American public examples are fewer. Foreign cards wear a region label.",
            zh: "资料库里的 KNX 骨干，多半是舒适和暖通，上面再叠 Control4 或 Crestron 界面。北美公开大案较少。境外卡片会标地域。"
        )
    }
}
