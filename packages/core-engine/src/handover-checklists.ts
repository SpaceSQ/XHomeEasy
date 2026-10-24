import type { HandoverItem } from "./types.ts";

const copy = (en: string, zh: string): { en: string; zh: string } => ({ en, zh });

const CONTROL4: HandoverItem[] = [
  {
    id: "c4-ovrc",
    brand: "Control4",
    tier: "E1",
    sourceName: "Snap One Help · Dealer of Record change",
    url: "https://help.snapone.com/ovrc-ug/Content/C4CA/Dealer%20of%20Record%20Change.htm",
    text: copy(
      "At acceptance the integrator transfers OvrC project ownership to the household.",
      "验收时，集成商在 OvrC 把项目归属交到业主名下。",
    ),
  },
  {
    id: "c4-account",
    brand: "Control4",
    tier: "E1",
    sourceName: "Snap One Help · Dealer of Record change",
    url: "https://help.snapone.com/ovrc-ug/Content/C4CA/Dealer%20of%20Record%20Change.htm",
    text: copy(
      "The household receives its own customer.control4.com login so it can change Smart Home Pro (Dealer of Record) later.",
      "业主获得自己的 customer.control4.com 登录，以便日后自行更换 Smart Home Pro（Dealer of Record）。",
    ),
  },
  {
    id: "c4-resources",
    brand: "Control4",
    tier: "E1",
    sourceName: "Snap One Help · Dealer of Record change",
    url: "https://help.snapone.com/ovrc-ug/Content/C4CA/Dealer%20of%20Record%20Change.htm",
    text: copy(
      "The project on the controller stays with the customer. Linked Resources and notification settings are rebuilt by the next Pro. That is a known step, not a reason to claim the system cannot move.",
      "控制器上的项目归客户。Linked Resources 和通知设置要由下一家 Pro 重新配置。这是已知步骤，不是系统不能移交的理由。",
    ),
  },
  {
    id: "c4-connect",
    brand: "Control4",
    tier: "E1",
    sourceName: "Control4 Services",
    url: "https://www.control4.com/services",
    text: copy(
      "Control4 Connect (it replaced 4Sight on 2024-04-23) and Assist are listed with their yearly price, who bills them, and that renewal is a choice unless the contract says otherwise.",
      "Control4 Connect（2024-04-23 起替代 4Sight）和 Assist 要写明年费、由谁收费，以及除非合同另有约定，续费是可以选择的。",
    ),
  },
];

const CRESTRON: HandoverItem[] = [
  {
    id: "cr-which",
    brand: "Crestron",
    tier: "E1",
    sourceName: "Crestron Home OS manual",
    url: "https://docs.crestron.com/en-us/9599/Content/Topics/Overview/Overview.htm",
    text: copy(
      "The contract states whether this job is Crestron Home (Configure Pro) or custom SIMPL programming.",
      "合同写明本项目是 Crestron Home（Configure Pro）还是定制 SIMPL 编程。",
    ),
  },
  {
    id: "cr-source",
    brand: "Crestron",
    tier: "E1",
    sourceName: "Crestron Home OS manual",
    url: "https://docs.crestron.com/en-us/9599/Content/Topics/Overview/Overview.htm",
    text: copy(
      "If the job includes SIMPL, the uncompiled source (.smw) and passwords transfer to the owner at final payment and are the owner's property.",
      "如果包含 SIMPL，未编译源码（.smw）和密码在尾款时交给业主，并归业主所有。",
    ),
  },
  {
    id: "cr-backup",
    brand: "Crestron",
    tier: "E1",
    sourceName: "Crestron Home OS manual",
    url: "https://docs.crestron.com/en-us/9599/Content/Topics/Overview/Overview.htm",
    text: copy(
      "A full Crestron Home configuration backup and an administrator login are handed to the household.",
      "完整的 Crestron Home 配置备份和管理员登录交给业主。",
    ),
  },
  {
    id: "cr-monitor",
    brand: "Crestron",
    tier: "E2",
    sourceName: "Crestron XiO Cloud",
    url: "https://www.crestron.com/Products/Featured-Solutions/XiO-Cloud",
    text: copy(
      "Residential monitoring access is named in the contract. XiO Cloud is not described here as the homeowner's subscription.",
      "合同写明住宅监控权限。这里不把 XiO Cloud 说成业主的订阅产品。",
    ),
  },
];

const SAVANT: HandoverItem[] = [
  {
    id: "sv-host",
    brand: "Savant",
    tier: "E1",
    sourceName: "Savant Host",
    url: "https://www.savant.com/host/",
    text: copy(
      "The Savant Host configuration backup is archived and the household is told where that copy lives.",
      "Savant Host 的配置备份要存档，并告知业主副本放在哪里。",
    ),
  },
  {
    id: "sv-essentials",
    brand: "Savant",
    tier: "E1",
    sourceName: "Savant Host",
    url: "https://www.savant.com/host/",
    text: copy(
      "Savant Essentials price, what it includes, and a written release of the account when the authorized dealer changes are in the contract. Public Essentials pricing was not verified on 2026-10-21.",
      "合同写明 Savant Essentials 的价格、包含的权益，以及更换授权经销商时无条件释放账号。2026-10-21 未核实到 Essentials 的公开标价。",
    ),
  },
];

const LUTRON: HandoverItem[] = [
  {
    id: "lu-file",
    brand: "Lutron",
    tier: "E1",
    sourceName: "Lutron HomeWorks",
    url: "https://www.lutron.com/us/en/controls/systems/homeworks",
    text: copy(
      "A copy of the HomeWorks project database is given to the household at acceptance.",
      "验收时把 HomeWorks 工程数据库副本交给业主。",
    ),
  },
  {
    id: "lu-admin",
    brand: "Lutron",
    tier: "E1",
    sourceName: "Lutron HomeWorks",
    url: "https://www.lutron.com/us/en/controls/systems/homeworks",
    text: copy(
      "The household receives the Lutron app administrator login, the final keypad engraving schedule, and the warranty terms.",
      "业主收到 Lutron App 管理员登录、最终按键雕刻清单和质保条款。",
    ),
  },
];

const ALL: Record<HandoverItem["brand"], HandoverItem[]> = {
  Control4: CONTROL4,
  Crestron: CRESTRON,
  Savant: SAVANT,
  Lutron: LUTRON,
};

export function handoverItems(brands: HandoverItem["brand"][]): HandoverItem[] {
  const unique = [...new Set(brands)];
  return unique.flatMap((brand) => ALL[brand]);
}

export function handoverComplete(brands: HandoverItem["brand"][], checkedIds: string[]): boolean {
  const required = handoverItems(brands).map((item) => item.id);
  const checked = new Set(checkedIds);
  return required.every((id) => checked.has(id));
}
