import type { AdvisorDocument, AdvisorReply, Copy } from "./types.ts";

const copy = (en: string, zh: string): Copy => ({ en, zh });

const REFUSAL: Copy = {
  en: "I can't help with that. Line-voltage wiring, panel work, and dealer-software bypasses are outside this app. Hire a licensed electrician for line voltage and an authorized integrator for the control system. I can still help with questions to ask them, handover terms, and how to compare bids.",
  zh: "这件事我不能协助。市电接线、配电箱作业，以及绕过经销商软件，都不在本 App 的范围内。市电请找持证电工，控制系统请找授权集成商。我仍然可以帮你准备该问他们的问题、移交条款，以及如何比较报价。",
};

const UNKNOWN: Copy = {
  en: "I don't have a sourced answer for that in the offline library. I won't guess a specification.",
  zh: "离线资料库里没有带出处的答案。我不会猜一个规格。",
};

export function isSafetyViolation(query: string): boolean {
  const text = query.toLowerCase();
  const asksCrack = /crack|keygen|pirate|patch|破解|盗版|注册机/.test(text)
    && /composer|configure pro|savant|dealer tool|编程软件/.test(text);
  const asksPanel = /120\s*v|240\s*v|line[-\s]?voltage|breaker|load center|electrical panel|配电箱|配电|市电|空开/.test(text)
    && /wire|wiring|land|connect|接进|接入|怎么接|如何接|rewire|panel/.test(text);
  const asksSteps = /step[-\s]?by[-\s]?step|分步|教程/.test(text)
    && /wire|wiring|panel|breaker|市电|配电|接进/.test(text);
  return asksCrack || asksPanel || asksSteps;
}

export function advise(query: string, documents: AdvisorDocument[]): AdvisorReply {
  if (isSafetyViolation(query)) {
    return { refused: true, unknown: false, text: REFUSAL, citations: [] };
  }
  const intent = intentReply(query);
  if (intent) return intent;
  const hits = search(query, documents).slice(0, 3);
  if (hits.length === 0 || hits[0].score < 2) {
    return { refused: false, unknown: true, text: UNKNOWN, citations: [] };
  }
  const cited = hits.map((hit) => hit.doc);
  return {
    refused: false,
    unknown: false,
    text: copy(
      `Closest sourced notes: ${cited.map((doc) => doc.title).join(" · ")}. Read the card before treating it as a fact. Community notes (E4) are not specifications.`,
      `最接近的有出处笔记：${cited.map((doc) => doc.title).join(" · ")}。先读卡片再把它当事实。社区笔记（E4）不是规格。`,
    ),
    citations: cited.map((doc) => ({ id: doc.id, title: doc.title, tier: doc.tier, url: doc.url })),
  };
}

function intentReply(query: string): AdvisorReply | null {
  const text = query.toLowerCase();
  const mentions = (words: string[]) => words.some((word) => text.includes(word));
  if (mentions(["dealer of record", "change dealer", "换商", "更换集成商", "ovrc"])) {
    return {
      refused: false,
      unknown: false,
      text: copy(
        "Control4 publishes a Dealer of Record change after the project is transferred in OvrC. The household uses customer.control4.com to choose the next Smart Home Pro. The project stays with the customer. Linked Resources and notifications are set up again by the new Pro. Crestron and Savant do not use that same page. Their handover has to be written into the contract: Crestron Home backup versus SIMPL source, and Savant Host plus Essentials account release.",
        "Control4 公开了换商流程：先在 OvrC 完成项目移交，业主再用 customer.control4.com 选择下一家 Smart Home Pro。项目归客户。Linked Resources 和通知要由新的 Pro 重新配置。Crestron 和 Savant 不走这个页面。它们的移交要写进合同：Crestron Home 备份还是 SIMPL 源码，以及 Savant Host 加上 Essentials 账号释放。",
      ),
      citations: [
        {
          id: "X05",
          title: "Snap One Help · Dealer of Record change",
          tier: "E1",
          url: "https://help.snapone.com/ovrc-ug/Content/C4CA/Dealer%20of%20Record%20Change.htm",
        },
        { id: "X11", title: "Control4 Services", tier: "E1", url: "https://www.control4.com/services" },
      ],
    };
  }
  if (mentions(["savant", "control4"]) && mentions(["vs", "versus", "difference", "区别", "差别", "对比"])) {
    return {
      refused: false,
      unknown: false,
      text: copy(
        "Control4's company page cites 500,000+ homes, about 6,000 authorized integrators, and 25,000+ third-party devices. Savant's public host page emphasizes a polished interface, Savant Power, and dealer-managed Essentials. CEDIA 2026 mention shares were Control4 63% and Savant 33% for whole-home control. Neither number is a vote for which one belongs in this house. Compare handover terms and itemized hours.",
        "Control4 公司页面写的是 50 万户以上、约 6,000 家授权集成商、25,000 个以上第三方设备。Savant 的主机页面强调界面、Savant Power，以及由经销商管理的 Essentials。CEDIA 2026 全屋控制提及率是 Control4 63%、Savant 33%。这两个数字不是给这座房子投票。要比移交条款和分项工时。",
      ),
      citations: [
        { id: "X03", title: "Control4 company", tier: "E1", url: "https://www.control4.com/company" },
        { id: "X02", title: "CE Pro · CEDIA 2026", tier: "E2", url: "https://www.cepro.com/news/cedia-research-pegs-u-s-residential-tech-market-at-33-8-billion-with-ai-and-skilled-labor-defining-the-year-ahead/628665/" },
        { id: "SV", title: "Savant Host", tier: "E1", url: "https://www.savant.com/host/" },
      ],
    };
  }
  if (mentions(["budget", "cost", "price", "预算", "多少钱", "编程"])) {
    return {
      refused: false,
      unknown: false,
      text: copy(
        "There is no homeowner MSRP for these systems. Published bands for a roughly 5,000–8,000 ft² house put Control4 plus a Lutron base around $50k–$120k, Savant about $20k–$40k higher, and Crestron Home around $80k–$180k. Programming is often described as 15–25% and about $100–$250 per hour. Labor plus programming plus rack finish is often described as 30–55%. Those are trade-press bands verified 2026-10-21, not a bid.",
        "这些系统没有面向业主的统一标价。公开区间里，大约 5,000–8,000 平方英尺的房子，Control4 加 Lutron 底座常见 5 万至 12 万美元，Savant 大约再高 2 万至 4 万美元，Crestron Home 常见 8 万至 18 万美元。编程常见为 15%–25%，每小时大约 100–250 美元。人工加编程加机柜收边常见为 30%–55%。这是 2026-10-21 复核的媒体区间，不是报价。",
      ),
      citations: [
        { id: "X07", title: "homeautomation.us.com", tier: "E3", url: "https://homeautomation.us.com/planning/luxury-smart-home/" },
        { id: "X06", title: "South Florida Crestron cost note", tier: "E3", url: "https://www.geeksfl.com/blog/crestron-smart-home-cost-south-florida/" },
      ],
    };
  }
  return null;
}

function search(query: string, documents: AdvisorDocument[]): { doc: AdvisorDocument; score: number }[] {
  const needles = tokens(query);
  if (needles.length === 0) return [];
  return documents
    .map((doc) => {
      const hay = tokens(`${doc.title} ${doc.text}`);
      const set = new Set(hay);
      let score = 0;
      for (const needle of needles) if (set.has(needle)) score += 1;
      if (doc.tier === "E4") score -= 1;
      return { doc, score };
    })
    .filter((hit) => hit.score > 0)
    .sort((a, b) => b.score - a.score);
}

function tokens(value: string): string[] {
  const folded = value.toLowerCase();
  const latin = folded.split(/[^a-z0-9@.]+/).filter((part) => part.length > 2);
  const cjk = [...folded].filter((char) => char >= "\u4e00" && char <= "\u9fff");
  const grams: string[] = [];
  for (let i = 0; i < cjk.length - 1; i += 1) grams.push(cjk[i] + cjk[i + 1]);
  return [...latin, ...grams];
}
