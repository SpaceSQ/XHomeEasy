# Lutron 架构：Clear Connect / RA3 / HomeWorks（公开规格摘要）

fetched_on: 2026-10-21

## RadioRA 3（Architecture PDF）

- Clear Connect **Type A**：系统设备规模上限公开表述约 200 devices/zones 量级（含中继与处理器地址预留）；中继间距约 60 ft，到设备约 30 ft 等（见 PDF 原文数字）。
- Clear Connect **Type X**（Sunnata 等）：约 200 devices；设备需在处理器约 75 ft 内，并满足近距多设备网格条件（PDF）。
- 处理器 PoE 供电；可选 RR-PROC3-KIT1（含 PoE 注入与网线）。

## HomeWorks Wireless Processor（3691222）

- 型号例：HQP7-RF-2；PoE；434 MHz Type A + 2.4 GHz Type X。
- 容量公开：最多约 100 Type X、95 Type A、4 Type A 中继 / 处理器等（以 PDF 为准）。
- 系统上限：最多 16 个网关/无线处理器/有线处理器合计（规格注）。
- 与 QSX 处理器配合；需最新 Lutron Designer。

## HomeWorks QSX Processor（3691127）

- 以太网互联多处理器与第三方集成；供电 24–36 V 等（规格）。
- Clear Connect Type X 网关不可直接接到该以太网口的限制说明见 PDF。

## Caséta Bridge

- L-BDG2 / L-BDGPRO2；经 Lutron App 设置与监控 Caséta 与部分无线遮阳。
