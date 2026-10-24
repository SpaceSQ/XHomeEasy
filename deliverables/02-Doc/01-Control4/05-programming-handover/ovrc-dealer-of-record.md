# Control4 编程与经销商移交（公开 OvrC 文档）

fetched_on: 2026-10-21
primary_source: https://help.snapone.com/ovrc-ug/Content/C4CA/Dealer%20of%20Record%20Change.htm

## 业主换 Smart Home Pro（离场流程摘要）

1. 前提：项目已在 OvrC 中移交给业主，否则无法 Change My Pro。
2. 业主在 customer.control4.com 或 App → Settings → Support → Your Independent Professional Integrator → Change Your Pro。
3. My Account → Smart Home Pro → Change My Pro；选择原因并确认。
4. 原集成商关系解除后，账户进入 Holding；业主需通过 Pro Locator / Dealer Request 找新集成商。
5. 新集成商须为 **Control4 certified**，否则不会出现在可选列表，也无法在 OvrC 接管。
6. 新集成商在 OvrC Customer List → New Customers Pending → Accept。

## 移交内容（公开帮助文）

**转移**：整个 Location、已认领设备与配置、OvrC 备注、OvrC Connect 用户、customer.control4 账户，以及 Connect/Assist 收入分成（文称接管后第二个月起）。

**不转移**：Linked Resources、原集成商信息、Notification 设置（需重配）。设备本地用户名密码不会因 takeover 重置。

## 相关公开新闻

- https://news.snapav.com/post/updated-process-to-change-the-dealer-of-record （现场 System Takeover / OvrC Pro Hub 流程说明）
- https://news.snapav.com/post/additional-enhancements-to-the-process-to-change-the-dealer-of-record

## 缺口

Composer 工程文件格式、驱动签名、经销商侧完整 takeover 矩阵操作手册：部分仅登录后可见。
