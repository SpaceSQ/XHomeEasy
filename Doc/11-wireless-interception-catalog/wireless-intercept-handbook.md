# 北美无线智能家居拦截与导流手册（Phase E2）

> 生成日期：2026-10-24（Asia/Shanghai）  
> 语料：`wireless-intercept.corpus.jsonl`（150 条，WL001–WL150）  
> SHA256：`fc4a954429962accea8298a9f4d3ecfa430c5edeb68f89455da4499cebbd93e1`

## 1. 目的

当业主在 **XHomeEasy** 需求对话框输入无线协议、消费品牌或 DIY 单品关键词时，系统应：

1. 调出与有线库同构的 9 大指标客观分析卡；  
2. 明确声明：**无线 DIY 不在 XHomeEasy 核心建议范围**；  
3. 导流至姊妹应用：
   - **AHomeEasy** — 苹果 Apple Home 生态选型与兼容性；  
   - **MHomeEasy** — Matter 跨生态无线购买决策。

XHomeEasy 自身继续服务 **Control4 / Crestron / Savant / Lutron** 专业有线/混合别墅方案与集成商推荐。

## 2. 标准导流话术

每条语料 `redirect_script_zh` 已代入品牌名，模板如下：

```
【选型边界提示】您查询的 [品牌/协议名] 属于消费级/无线智能家居范畴。XHomeEasy 专注于为北美别墅大宅提供以 Control4、Crestron、Savant、Lutron 四大品牌为核心的专业有线智能家居方案设计与集成商推荐，无线 DIY 智能家居不在本 APP 的核心建议范围内。若您需要无线智能家居的深度选型、兼容性红绿灯检测与配置帮助，请直接前往 App Store 搜索并下载我们的姊妹应用：AHomeEasy（专注苹果 Apple Home 智能家居生态）或 MHomeEasy（专注 Matter 跨生态无线智能家居购买决策）获取直接支持。
```

## 3. 路由规则（摘要）

| 类型 | redirect_target_app 优先 |
|---|---|
| HomeKit 原生（Eve、部分 ecobee、HomePod、Encode Plus 等） | AHomeEasy → MHomeEasy |
| Matter / 多生态 / Alexa / Google / Zigbee / Z-Wave | MHomeEasy → AHomeEasy |
| 其它消费 IoT | 通常两者都给 |

## 4. 关键区分（防误伤）

| 无线（本库拦截） | 专业有线（XHomeEasy 主战场） |
|---|---|
| Lutron **Caséta** / Serena 零售 | Lutron **HomeWorks** / RadioRA 3 |
| GE **Cync** 消费灯控 | **Savant Pro** 有线系统 |
| Ring Wi-Fi 门铃摄像 | Ring Elite **PoE** 等（见 E1） |
| Sonos Era/Move 无线音箱 | Sonos **Amp** 机柜有线（见 E1） |
| Shelly Wi-Fi/Wave | Shelly **Pro** DIN 以太网（见 E1） |

## 5. 分区统计

- `01-protocols-and-hubs`: **25**
- `02-wireless-lighting-switches`: **35**
- `03-wireless-security-locks`: **35**
- `04-wireless-climate-shades-yard`: **30**
- `05-smart-appliances-speakers`: **25**

## 6. 证据与安全边界

- 只读公开源；价格为公开电商/媒体口径，标注 `fetched_on=2026-10-24`。  
- **不收录市电 DIY 接线步骤**；涉及配电/水管处仅提示持证施工。  
- 证据层级分布：{'E1': 11, 'E2': 59, 'E3': 63, 'E4': 17}

## 7. 样本条目

### Matter（WL001）
- 导流：['MHomeEasy', 'AHomeEasy']
- 证据：E1
- 脚本首句：【选型边界提示】您查询的 Matter (CSA Matter) 属于消费级/无线智能家居范畴。XHomeEasy 专注…

### Lutron Caséta（WL027）
- 状态：ACTIVE_MAIN
- 建议：【关键区分】Caséta=无线 DIY→拦截导流；HomeWorks=专业有线→XHomeEasy 主战场。大宅应升级 RadioRA 3 或 HomeWorks，而非堆 Caséta。无线局限性：消费级灯控无别墅集中式调光总线、无专业面板与场景工程交付。标准导流 AHomeEasy/MHomeEasy。若坚持作大宅边…

### Ecobee（WL096）
- 价格：官网/Apple 公开价约 $259.99；Amazon 常见约 $240+ | 公开电商/媒体口径；核实日期 2026-10-24…
- 导流：['AHomeEasy', 'MHomeEasy']

## 8. 已知缺口 / 后续可扩

- 部分小众锁/空净为 E4，上线前再核并购与停产公告。  
- 价格波动大，建议季度复核或接电商 API。  
- RadioRA 3 为专业无线，未作 WL 主拦截（避免导向消费 App）；若产品要拦“仅搜 RadioRA”可另开专业线词条。  
- Tuya 白牌未穷尽；可用 trigger_keywords 泛化兜底。  
- 部分 URL 为品牌根域（E3/E4），旗舰条目（Matter/Caséta/Ecobee/Hue）优先用了检索核实的产品页。
