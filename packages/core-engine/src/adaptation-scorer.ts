import type {
  AdaptationResult,
  BudgetBand,
  BuildStage,
  Copy,
  Intake,
  Light,
  PathKind,
  PathScore,
  SqftBand,
} from "./types.ts";
import { HEURISTIC_DISCLAIMER, RED_LINES } from "./types.ts";

function lightFor(score: number): Light {
  if (score >= 70) return "proceed";
  if (score >= 45) return "consider";
  return "defer";
}

function clamp(n: number): number {
  return Math.max(0, Math.min(100, Math.round(n)));
}

const copy = (en: string, zh: string): Copy => ({ en, zh });

const on = (value: boolean | undefined) => value === true;

export function scoreAdaptation(input: Intake): AdaptationResult {
  if (on(input.hospitality)) {
    return {
      paths: [
        { kind: "wired", score: 0, light: "defer", reasons: [] },
        { kind: "matter", score: 0, light: "defer", reasons: [] },
        { kind: "hybrid", score: 0, light: "defer", reasons: [] },
      ],
      primary: "wired",
      prewireWindow: false,
      retailGuardrail: false,
      residentialModelApplies: false,
      scopeNote: copy(
        "A hotel of guest rooms is outside this villa model. Do not price it with a house band, and do not send it as a homeowner RFQ to three residential dealers.",
        "酒店客房不在这座别墅模型里。不要用独栋住宅的金额带宽给它计价，也不要把它当成业主 RFQ 发给三家住宅集成商。",
      ),
      briefNotes: [
        copy(
          "Write a guest-room standard and a suite standard. Three hundred rooms are copies of those types, not three hundred custom homes.",
          "先写标准客房和套房两种房型。三百多间是房型的复制，不是三百座定制住宅。",
        ),
        copy(
          "Guests bringing an iPhone or iPad is a requirement to confirm with a hospitality integrator. It does not make Apple Home the hotel's control system.",
          "客人自带 iPhone 或 iPad 是要向酒店工程集成商确认的需求。这不会让 Apple Home 变成酒店的控制系统。",
        ),
        copy(
          "Voice is the same: ask whether it stays in the room, what it hears, and who operates it. This app does not name a voice product as the hotel standard.",
          "语音也一样：问清它是否留在房间里、听什么、谁在操作。本 App 不指定某一款语音产品为酒店标准。",
        ),
      ],
      disclaimer: HEURISTIC_DISCLAIMER,
      redLines: RED_LINES,
    };
  }

  let wired = 15;
  let matter = 15;
  let hybrid = 15;
  const reasons: Record<PathKind, Copy[]> = { wired: [], matter: [], hybrid: [] };
  let prewireWindow = false;

  const sqftNotes: Record<SqftBand, () => void> = {
    under3000: () => {
      matter += 16;
      reasons.matter.push(copy(
        "Under 3,000 ft² often fits a retail ecosystem before a whole-home rack.",
        "3,000 平方英尺以下，常常先适合零售生态，而不是整屋机柜。",
      ));
    },
    ft3000to5000: () => {
      hybrid += 12;
      wired += 6;
      reasons.hybrid.push(copy(
        "3,000–5,000 ft² is a common boundary: lighting can be professional while some rooms stay wireless.",
        "3,000–5,000 平方英尺常常是分界：照明可以走专业系统，部分房间仍可无线。",
      ));
    },
    ft5000to8000: () => {
      wired += 20;
      hybrid += 6;
      reasons.wired.push(copy(
        "5,000–8,000 ft² overlaps the home size used in published Control4 project ranges. Those ranges are not a bid.",
        "5,000–8,000 平方英尺与公开 Control4 项目口径里的常见面积重叠。那是区间，不是报价。",
      ));
    },
    over8000: () => {
      wired += 28;
      reasons.wired.push(copy(
        "Estates over 8,000 ft² usually need a control host, a rack plan, and a pre-wire conversation before drywall.",
        "8,000 平方英尺以上的庄园通常需要控制主机、机柜规划和封干墙前的布线窗口讨论。",
      ));
    },
  };
  sqftNotes[input.sqft]();

  const stageNotes: Record<BuildStage, () => void> = {
    new_build_pre_drywall: () => {
      wired += 24;
      prewireWindow = true;
      reasons.wired.push(copy(
        "Drywall is still open. This is the structured-wiring window. The app will not tell anyone how to pull cable.",
        "干墙还没封。这是结构化布线的窗口。本 App 不说明如何穿线。",
      ));
    },
    major_renovation: () => {
      wired += 16;
      hybrid += 8;
      prewireWindow = input.sqft !== "under3000";
      reasons.wired.push(copy(
        "A major renovation can still open walls for structured wiring. Confirm the date with the builder.",
        "大翻修仍可能为结构化布线打开墙体。具体日子要和总包确认。",
      ));
    },
    retrofit_existing: () => {
      hybrid += 22;
      matter += 10;
      wired += 2;
      reasons.hybrid.push(copy(
        "An occupied retrofit should not assume every wall can open. Lutron Clear Connect plus a control host is the usual mix.",
        "已入住的改造不能假设每面墙都能打开。常见做法是 Lutron Clear Connect 加上一台控制主机。",
      ));
    },
    inherited_home: () => {
      wired += 12;
      hybrid += 14;
      reasons.hybrid.push(copy(
        "An inherited professional system needs a brand-specific handover, not a factory reset and not a new retail kit.",
        "接手的专业系统要按品牌办移交，不要恢复出厂，也不要先买一套零售设备。",
      ));
    },
  };
  stageNotes[input.stage]();

  if (input.rackRoom) {
    wired += 12;
    reasons.wired.push(copy(
      "A dedicated low-voltage room gives the rack, UPS, and service technician a place to work.",
      "独立弱电间能放下机柜、UPS，也方便以后维护。",
    ));
  } else {
    hybrid += 6;
    matter += 4;
    reasons.hybrid.push(copy(
      "There is no rack room yet. A closet or mechanical space has to be confirmed before a large host is specified.",
      "还没有弱电间。指定大型主机之前，要先确认衣帽间或设备空间。",
    ));
  }

  const budgetNotes: Record<BudgetBand, () => void> = {
    under25k: () => {
      matter += 30;
      wired = Math.max(0, wired - 12);
      hybrid += 4;
      reasons.matter.push(copy(
        "Under $25k sits below typical whole-home wired bands. Leading with retail avoids overselling a rack project.",
        "2.5 万美元以下，低于常见的整屋有线区间。先走零售，避免被推销成机柜工程。",
      ));
    },
    k25to75: () => {
      hybrid += 16;
      matter += 6;
      reasons.hybrid.push(copy(
        "$25k–$75k can cover a lighting base and a modest host. It is not an estate cinema package.",
        "2.5 万至 7.5 万美元可以覆盖照明底座和一台适度的主机，不是庄园影院包。",
      ));
    },
    k75to150: () => {
      wired += 18;
      reasons.wired.push(copy(
        "$75k–$150k overlaps published whole-home bands. Compare itemized bids. Do not treat the band as a price.",
        "7.5 万至 15 万美元与公开的整屋区间重叠。要比分项报价，不要把区间当成成交价。",
      ));
    },
    k150plus: () => {
      wired += 24;
      reasons.wired.push(copy(
        "$150k and above is consistent with larger estates. Labor, programming, and the rack still need their own lines.",
        "15 万美元以上与较大庄园相符。人工、编程和机柜仍然要单独列项。",
      ));
    },
    unstated: () => {
      reasons.hybrid.push(copy(
        "No budget was stated, so this result has no dollar band. Choose a band only as a scenario, and label it as an assumption.",
        "还没有预算，所以结果里不出现金额带宽。若要试算，只能把档位标成情景假设。",
      ));
    },
  };
  budgetNotes[input.budget]();

  if (input.cinema) {
    wired += 14;
    reasons.wired.push(copy(
      "A dedicated theater usually needs a rack and a control host. That is an integrator scope, not a DIY speaker kit.",
      "独立影院通常需要机柜和控制主机。这是集成商的范围，不是一套自己装的音箱。",
    ));
  }
  if (input.multiRoomAudio) {
    wired += 10;
    reasons.wired.push(copy(
      "Whole-home audio is a strength of Control4, Crestron, and Savant. Ask for zones and sources as separate lines.",
      "全屋音频是 Control4、Crestron、Savant 的常见能力。分区和音源要在报价里分开写。",
    ));
  }
  if (input.shades) {
    wired += 8;
    hybrid += 4;
    reasons.wired.push(copy(
      "Whole-home shades are where Lutron is the usual engineering base. CEDIA mention share is not a mandate to buy it.",
      "全屋遮阳通常以 Lutron 为工程底座。CEDIA 的提及率不是购买指令。",
    ));
  }
  if (input.pool || on(input.largeGarden) || on(input.outdoorLiving)) {
    wired += 8;
    reasons.wired.push(copy(
      "Outdoor garden, terrace, or pool zones are listed for the integrator after a site survey. Line-voltage landscape lighting stays with a licensed electrician.",
      "花园、露台或泳池要在现场勘测后写成室外分区。景观市电灯具仍由持证电工负责。",
    ));
  }
  if (input.hvacZones) {
    wired += 6;
    reasons.wired.push(copy(
      "Multi-zone HVAC is typically supervised by the control layer through a documented driver or BACnet. Termination stays with the licensed trade.",
      "多温区暖通通常由控制层通过公开驱动或 BACnet 来监管。端接仍由持证工种完成。",
    ));
  }

  if (input.keypad === "basalte") {
    wired += 18;
    reasons.wired.push(copy(
      "Basalte is already specified for the wall keypads. That is a professional interface, not a retail switch. A public KNX case pairs Basalte Sentido keypads with a Control4 interface. Lutron is a different base, not a silent substitute.",
      "墙面已经指定巴萨。这是专业面板，不是零售开关。公开的 KNX 案例里，Basalte Sentido 与 Control4 界面放在一起。Lutron 是另一种底座，不能悄悄替换。",
    ));
  }

  if (input.legacy === "appleHome") {
    hybrid += 14;
    reasons.hybrid.push(copy(
      "Apple Home can remain a room and voice front end. On a large house it does not replace a wired host.",
      "Apple Home 可以继续做房间和语音的前端。大宅上它不替代有线主机。",
    ));
  } else if (input.legacy === "matter") {
    hybrid += 12;
    matter += 8;
    reasons.hybrid.push(copy(
      "Existing Matter devices can stay in some rooms. Shades, a theater, and a rack still need an integrator plan.",
      "已有的 Matter 设备可以留在部分房间。遮阳、影院和机柜仍然需要集成商方案。",
    ));
  } else if (input.legacy !== "none") {
    wired += 10;
    hybrid += 8;
    reasons.wired.push(copy(
      "A legacy professional system should be inventoried and handed over by brand. Do not factory-reset it.",
      "原有的专业系统应按品牌盘点并移交。不要恢复出厂。",
    ));
  }

  const retailGuardrail = input.budget === "under25k"
    && input.stage === "retrofit_existing"
    && !input.cinema
    && !input.multiRoomAudio;
  if (retailGuardrail) {
    matter += 20;
    reasons.matter.push(copy(
      "Small budget, occupied retrofit, and no whole-home audio matrix: start with Matter or Apple Home instead of a wired estate system.",
      "预算不高、房屋已入住、又没有全屋音频矩阵：先走 Matter 或 Apple Home，而不是整屋有线。",
    ));
  }

  const largeHome = input.sqft === "ft5000to8000" || input.sqft === "over8000";
  const funded = input.budget === "k75to150" || input.budget === "k150plus";
  if (largeHome && (input.stage === "new_build_pre_drywall" || funded)) {
    wired += 10;
    if (input.stage === "new_build_pre_drywall" || input.stage === "major_renovation") {
      prewireWindow = true;
    }
  }

  if (
    input.stage === "retrofit_existing"
    && input.budget !== "under25k"
    && !input.cinema
    && (input.shades || input.multiRoomAudio || input.hvacZones)
  ) {
    hybrid += 20;
    reasons.hybrid.push(copy(
      "Occupied house, reliable shades or comfort, and walls that should stay closed: specify a hybrid, then let the integrator mark what can still be wired.",
      "房屋已入住，又要可靠的遮阳或舒适系统，同时不希望大面积开墙：先定混合架构，再让集成商标出哪些房间仍可布线。",
    ));
  }

  const paths: PathScore[] = [
    { kind: "wired", score: clamp(wired), light: "defer", reasons: reasons.wired },
    { kind: "matter", score: clamp(matter), light: "defer", reasons: reasons.matter },
    { kind: "hybrid", score: clamp(hybrid), light: "defer", reasons: reasons.hybrid },
  ].map((path) => ({ ...path, light: lightFor(path.score) }));
  paths.sort((a, b) => b.score - a.score);
  const briefNotes: Copy[] = [];
  if (on(input.drywallUnconfirmed) && prewireWindow) {
    briefNotes.push(copy(
      "The pre-wire window is only real if the drywall is still open. A finished purchase must be switched to a retrofit before anyone trusts this lead.",
      "只有干墙还开着，布线窗口才成立。已经收房的话，要先改成改造再相信这条主路径。",
    ));
  }
  if (on(input.children)) {
    briefNotes.push(copy(
      "Children need a night path and understandable door alerts. Automation does not supervise a child.",
      "孩子需要夜间路径和说得清的门磁提醒。自动化不代替看护。",
    ));
  }
  if (on(input.pets)) {
    briefNotes.push(copy(
      "Program doors and alerts so pets are not trapped or let out. Confirm that on site. This is not a wiring note.",
      "门和提醒要避免把宠物关住或放走。到现场确认。这不是接线说明。",
    ));
  }
  if (on(input.elderCare)) {
    briefNotes.push(copy(
      "Aging in place here means reliable light, comfort, and professional monitoring. It is not a medical device and not a diagnosis.",
      "适老在这里指可靠的灯光、舒适的暖通和专业监控。它不是医疗器械，也不做诊断。",
    ));
  }
  if (on(input.simpleAlarmOnly)) {
    briefNotes.push(copy(
      "A simple infrared alarm is not a monitored professional panel. The integrator surveys it before anything is removed. Do not dismantle a live alarm from this app.",
      "简单红外报警不是专业监控主机。拆除前由集成商现场查看。不要照着 App 拆正在使用的报警。",
    ));
  }
  if (on(input.multiBuilding)) {
    briefNotes.push(copy(
      "More than one residence needs a decision about one host or several, plus outdoor zones. That is an integrator design after a site survey.",
      "多幢住宅要决定一台主机还是多台，并把室外分区写清。这是现场勘测之后的集成商设计。",
    ));
  }
  if (on(input.energyPriority)) {
    briefNotes.push(copy(
      "Low carbon is a measured-load goal, not a feature of a keypad. Savant Power is a published energy option on Savant. It is not assumed to drive a Basalte keypad, and it does not certify a zero-carbon house.",
      "低碳是可计量的负荷目标，不是开关面板的功能。Savant Power 是 Savant 公开的能源选项。不要假定它已经能驱动巴萨面板，它也不能证明房子零碳。",
    ));
  }

  return {
    paths,
    primary: paths[0].kind,
    prewireWindow,
    retailGuardrail,
    residentialModelApplies: true,
    scopeNote: null,
    briefNotes,
    disclaimer: HEURISTIC_DISCLAIMER,
    redLines: RED_LINES,
  };
}
