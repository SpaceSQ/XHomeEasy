export type LegalLang = 'en' | 'zh';

export type LegalSection = {
  heading: string;
  paragraphs: string[];
};

export type LegalDocument = {
  kicker: string;
  title: string;
  updated: string;
  sections: LegalSection[];
};

export const SUPPORT_EMAIL = 'support@xhomeeasy.qianjia.com';

export function legalLang(value: string | string[] | undefined): LegalLang {
  const raw = Array.isArray(value) ? value[0] : value;
  return raw === 'zh' ? 'zh' : 'en';
}

const support: Record<LegalLang, LegalDocument> = {
  en: {
    kicker: 'X Home Easy',
    title: 'Support',
    updated: 'Updated 24 October 2026',
    sections: [
      {
        heading: 'What this app is',
        paragraphs: [
          'X Home Easy helps a villa owner, architect, or interior designer in the United States or Canada decide on a wired estate system before a contract is signed. The brands in scope are Control4, Crestron, Savant, and Lutron.',
          'The app does not operate the lights, and it does not replace a licensed electrician or an authorized integrator.'
        ]
      },
      {
        heading: 'Help inside the app',
        paragraphs: [
          'Open Help from the top of the app. It explains the consult, the plan, the request for quotes, the integrator directory, and handover by brand.',
          'The on-device advisor cites a source or says it does not know. It is not a legal opinion and it is not a building permit.'
        ]
      },
      {
        heading: 'The website',
        paragraphs: [
          'Apple sign-in is enough to use the app. It does not open the website. To use the website, save an email and a password in the app first. We do not check that the mailbox is real.',
          'After that, the same email and password sign in on the website. Owners then see the same studio as the app. Integrator salespeople see the integrator workbench and its project list.',
          'Open the sign-in page in a computer or phone browser and enter that email and password.'
        ]
      },
      {
        heading: 'What we cannot do from support',
        paragraphs: [
          'We do not provide line-voltage wiring, panel, or rack connection steps. That work belongs to a licensed electrician.',
          'We do not explain how to bypass Composer Pro, Configure Pro, or Savant dealer tools. Programming stays with an authorized integrator.'
        ]
      },
      {
        heading: 'Contact',
        paragraphs: [
          `Email ${SUPPORT_EMAIL}. Include the Apple ID name shown in the app if the question is about an on-device project, and say whether you are an owner or an integrator salesperson.`,
          'This page does not promise a response time. Deleting the on-device account is done in the app under Settings. To ask for a website account to be deleted, use the same email address.'
        ]
      }
    ]
  },
  zh: {
    kicker: 'X Home Easy',
    title: '支持',
    updated: '2026年10月24日更新',
    sections: [
      {
        heading: '这个 App 是做什么的',
        paragraphs: [
          'X Home Easy 帮助美国和加拿大的别墅业主、建筑师和室内设计师，在签订合同之前判断一座房子是否适合有线智能家居。范围内的品牌是 Control4、Crestron、Savant 和 Lutron。',
          '本 App 不控制家里的灯，也不代替持证电工或授权集成商施工。'
        ]
      },
      {
        heading: '在 App 里获得帮助',
        paragraphs: [
          '从 App 顶部打开帮助。里面说明问诊、方案、招标、集成商名录，以及按品牌分开的移交事项。',
          '本机顾问会给出处，或说明不知道。输出不是法律意见，也不是施工许可。'
        ]
      },
      {
        heading: '网站',
        paragraphs: [
          '只用苹果账户就可以使用 App，但不能打开网站。要使用网站，先在 App 里保存邮箱和密码。我们不验证这个邮箱是否真实。',
          '保存之后，用同一组邮箱和密码在网站登录。业主看到的是和 App 相同的工作界面。集成商销售人员进入集成商工作台和项目列表。',
          '在电脑或手机浏览器打开登录页，输入这一组邮箱和密码。'
        ]
      },
      {
        heading: '支持范围之外',
        paragraphs: [
          '我们不提供市电接线、配电箱或机柜接线步骤。这类工作属于持证电工。',
          '我们不说明如何绕过 Composer Pro、Configure Pro 或 Savant 经销商工具。编程属于授权集成商。'
        ]
      },
      {
        heading: '联系',
        paragraphs: [
          `请发邮件至 ${SUPPORT_EMAIL}。如果问题与本机上的方案有关，请写上 App 里显示的苹果账户姓名，并说明你是业主还是集成商销售人员。`,
          '本页不承诺回复时限。删除本机账户在 App 的设置里完成。如需删除网站账户，请使用上面的邮箱提出。'
        ]
      }
    ]
  }
};

const privacy: Record<LegalLang, LegalDocument> = {
  en: {
    kicker: 'X Home Easy',
    title: 'Privacy',
    updated: 'Updated 24 October 2026',
    sections: [
      {
        heading: 'Who this notice covers',
        paragraphs: [
          'This notice describes the X Home Easy iPhone and iPad app and the website at xhomeeasy.qianjia.com. The product is a decision aid for wired estate systems in the United States and Canada.',
          'It is not legal advice. It does not describe how to wire line voltage or how to use a dealer programming tool.'
        ]
      },
      {
        heading: 'Information on the device',
        paragraphs: [
          'If you sign in with Apple, Apple may share your name and email on the first authorization. The app stores that sign-in record, your consult, rooms, quote drafts, and settings on the device, under that Apple account.',
          'Signing out keeps those records on the device. Delete account in Settings removes that Apple account’s on-device sign-in, consult, plan, quote drafts, and settings. It does not delete the Apple ID itself.'
        ]
      },
      {
        heading: 'The website account',
        paragraphs: [
          'You do not need an email and password to use the app. You do need them to open the website. We do not check that the mailbox is real.',
          'The password is sent to the website and is not stored in the project file on the phone. The service stores the credential in hashed form. The email, address, and the role (owner or integrator salesperson) are stored so the website can open the matching desk. The website signs in with that email and password.'
        ]
      },
      {
        heading: 'Integrator claims',
        paragraphs: [
          'An integrator salesperson who asks to claim a listed company, or to add a company, may be asked for a business-card photo, a company email address, and a photo taken in an office that shows the company logo. Extra evidence may be added if two people dispute a claim.',
          'Those files are stored in a private bucket. They are not shown on the public directory. The applicant and X Home Easy staff can read them while a claim is reviewed. One listed company has one claimant. A second request does not become a second claim; staff see it as a dispute.',
          'An unclaimed Silver listing does not show an email address or a street on the public directory. A house number is not placed on the public directory or in a request for quotes.'
        ]
      },
      {
        heading: 'What we do not do',
        paragraphs: [
          'We do not sell personal information. We do not use the directory order to reward a paid placement. A sponsored block, if one is shown later, is labeled Sponsored and is separate from the ranked list.',
          'The website does not take payment. This build does not charge. A later purchase, if offered, would be an Apple in-app purchase confirmed on a server, not a card form on the website.',
          'The website does not use a third-party advertising tracker.'
        ]
      },
      {
        heading: 'Where the data is kept',
        paragraphs: [
          'On-device records stay on the iPhone or iPad until you delete them. Website accounts, profiles, claim files, and staff review records are stored with our database provider in the United States.',
          'Staff with an admin role assigned in the database can review users, integrator applications, claim disputes, request progress, and messages needed to operate the service.'
        ]
      },
      {
        heading: 'Children',
        paragraphs: [
          'X Home Easy is not directed to children under 13, and we do not knowingly collect personal information from them.'
        ]
      },
      {
        heading: 'Contact and changes',
        paragraphs: [
          `Questions about this notice, or a request to delete a website account, go to ${SUPPORT_EMAIL}.`,
          'If this notice changes, the date at the top of this page changes with it. The page shows one language at a time. English is the default.'
        ]
      }
    ]
  },
  zh: {
    kicker: 'X Home Easy',
    title: '隐私',
    updated: '2026年10月24日更新',
    sections: [
      {
        heading: '本说明覆盖什么',
        paragraphs: [
          '本说明适用于 X Home Easy 的 iPhone 与 iPad App，以及网站 xhomeeasy.qianjia.com。本产品是面向美国和加拿大的有线别墅智能家居决策辅助。',
          '它不是法律意见，也不说明如何做市电接线，或如何使用经销商编程工具。'
        ]
      },
      {
        heading: '留在设备上的信息',
        paragraphs: [
          '如果你使用苹果登录，苹果可能在第一次授权时提供姓名和邮箱。App 会把这次登录记录、问诊、房间、报价草稿和设置保存在这台设备上，并记在这个苹果账户名下。',
          '登出只结束登录，这些记录仍留在设备上。在设置里注销，会删除该苹果账户在这台设备上的登录、问诊、方案、报价草稿和设置。不会删除 Apple ID 本身。'
        ]
      },
      {
        heading: '网站账户',
        paragraphs: [
          '使用 App 不需要邮箱和密码。打开网站才需要。我们不验证这个邮箱是否真实。',
          '密码只发给网站，不写进手机上的方案文件。登录服务以散列形式保存凭据。邮箱、地址和身份（业主或集成商销售人员）会被保存，以便网站打开对应的工作台。网站使用这一组邮箱和密码登录。'
        ]
      },
      {
        heading: '集成商认领',
        paragraphs: [
          '集成商销售人员申请认领已列出的公司，或申请把本公司加入名单时，可能需要提交名片照片、公司邮箱，以及在带有公司标志的办公区拍摄的照片。若两个人对同一认领有争议，可以再提交证据。',
          '这些文件放在非公开的存储里，不会出现在公开名录上。申请人和 X Home Easy 工作人员在审核期间可以查看。一家已列出的公司只能有一个认领人。第二个人的申请不会变成第二个认领，工作人员会把它当作争议处理。',
          '未认领的 Silver 名单不公开邮箱和街道。门牌号不进入公开名录，也不进入招标需求书。'
        ]
      },
      {
        heading: '我们不做的事',
        paragraphs: [
          '我们不出售个人信息。名录排序不因为付费而提前。如果以后出现赞助位，会单独标出 Sponsored，并且不进入正常排序。',
          '网站不收款。当前版本不收费。如果以后提供购买，将通过苹果 App 内购买并由服务器确认，而不是在网站上填写银行卡。',
          '网站不使用第三方广告追踪。'
        ]
      },
      {
        heading: '数据存放在哪里',
        paragraphs: [
          '本机记录留在 iPhone 或 iPad 上，直到你删除。网站账户、资料、认领文件和工作人员审核记录存放在我们位于美国的数据库服务中。',
          '在数据库中被指定为管理员的工作人员，可以查看用户、集成商申请、认领争议、招标进度，以及运营本服务所需要的沟通记录。'
        ]
      },
      {
        heading: '儿童',
        paragraphs: [
          'X Home Easy 不面向 13 岁以下儿童，我们也不会明知地收集他们的个人信息。'
        ]
      },
      {
        heading: '联系与变更',
        paragraphs: [
          `关于本说明的问题，或要求删除网站账户，请发送至 ${SUPPORT_EMAIL}。`,
          '如果本说明变更，页面顶部的日期会一起变更。本页一次只显示一种语言。默认是英文。'
        ]
      }
    ]
  }
};

export function legalDocument(page: 'support' | 'privacy', lang: LegalLang): LegalDocument {
  return page === 'support' ? support[lang] : privacy[lang];
}
