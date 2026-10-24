import SwiftUI

struct WebsiteAccountDraft: Codable, Equatable {
    var role = "homeowner"
    var email = ""
    var fullName = ""
    var companyName = ""
    var addressLine = ""
    var houseNumber = ""
    var city = ""
    var postalCode = ""
    var countryCode = "US"
    var area = ""
    var floors = ""
    var rooms = ""

    func linkedAddress(chinese: Bool) -> String {
        let country = countryCode == "CA"
            ? (chinese ? "加拿大" : "Canada")
            : (chinese ? "美国" : "United States")
        let parts = [role == "installer" ? companyName : "", addressLine, houseNumber, city, postalCode, country]
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        return parts.joined(separator: " · ")
    }
}

enum WebsiteAccountStore {
    static let key = "xhomeeasy.account"

    static func load() -> WebsiteAccountDraft? {
        guard let data = UserDefaults.standard.data(forKey: key),
              let stored = try? JSONDecoder().decode(WebsiteAccountDraft.self, from: data),
              stored.email.contains("@") else { return nil }
        return stored
    }

    static func save(_ draft: WebsiteAccountDraft) {
        if let data = try? JSONEncoder().encode(draft) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    static func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

enum WebsiteConfig {
    static var siteURL: String { value("SiteURL") }
    static var siteBase: String? {
        let raw = siteURL.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !raw.isEmpty else { return nil }
        return raw.hasSuffix("/") ? String(raw.dropLast()) : raw
    }

    static var loginAddress: String? {
        guard let siteBase else { return nil }
        return siteBase + "/login"
    }

    static var isConfigured: Bool { siteBase != nil }

    private static func value(_ key: String) -> String {
        guard let url = Bundle.main.url(forResource: "WebsiteAccount", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let object = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any],
              let raw = object[key] as? String else {
            return ""
        }
        return raw.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

enum WebsiteSession {
    private static let service = "com.scrlab.xhomeeasy.website"

    static func clear() {
        for account in ["access", "user"] {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service,
                kSecAttrAccount as String: account
            ]
            SecItemDelete(query as CFDictionary)
        }
    }
}

struct IntegratorComputerNotice: View {
    @Environment(AppModel.self) private var model

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(model.t(
                "用电脑或手机浏览器打开下面的网址，用这里保存的邮箱和密码登录。业主进入和 App 相同的工作界面。集成商销售人员进入集成商工作台。",
                "Open the address below in a computer or phone browser and sign in with the email and password saved here. An owner opens the same studio as the app. An integrator salesperson opens the integrator workbench."
            ))
            .font(.caption)
            .foregroundStyle(Studio.mist)
            .fixedSize(horizontal: false, vertical: true)
            if let address = WebsiteConfig.loginAddress {
                Text(address)
                    .font(.footnote.monospaced())
                    .foregroundStyle(Studio.ink)
                    .textSelection(.enabled)
                    .fixedSize(horizontal: false, vertical: true)
            } else {
                Text(model.t("网站地址还没有配置。", "The website address is not configured."))
                    .font(.caption)
                    .foregroundStyle(Studio.clay)
            }
        }
    }
}

struct WebsiteAccountView: View {
    var lockedRole: String = "homeowner"
    var onSaved: () -> Void = {}
    @Environment(AppModel.self) private var model
    @Environment(\.dismiss) private var dismiss
    @State private var draft = WebsiteAccountDraft()
    @State private var password = ""
    @State private var confirmation = ""
    @State private var message = ""
    @State private var working = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    HomeSettingsBar()
                    Text(intro)
                        .font(.footnote)
                        .foregroundStyle(Studio.mist)
                    if !WebsiteConfig.isConfigured {
                        Text(model.t("这个安装还没有填入网站地址。", "This install does not yet have the website address."))
                            .foregroundStyle(Studio.clay)
                    }
                    Text(model.t("我们不验证这个邮箱是否真实。修改资料时请再输入网站密码。密码不会留在这台手机上。", "We do not check that this mailbox is real. Enter the website password again to save a change. The password is not kept on this iPhone."))
                        .font(.caption)
                        .foregroundStyle(Studio.mist)
                    field(model.t("邮箱", "Email"), text: $draft.email, email: true)
                    secure(model.t("密码（至少 8 位）", "Password (at least 8 characters)"), text: $password)
                    secure(model.t("再输入一次密码", "Confirm password"), text: $confirmation)
                    field(draft.role == "installer" ? model.t("负责人", "Responsible person") : model.t("姓名", "Name"), text: $draft.fullName)
                    if draft.role == "installer" {
                        field(model.t("公司名称", "Company name"), text: $draft.companyName)
                    }
                    field(model.t("街道", "Street"), text: $draft.addressLine)
                    field(model.t("门牌号", "House number"), text: $draft.houseNumber)
                    field(model.t("城市", "City"), text: $draft.city)
                    field(model.t("邮编", "Postal code"), text: $draft.postalCode)
                    Picker(model.t("国家", "Country"), selection: $draft.countryCode) {
                        Text(model.t("美国", "United States")).tag("US")
                        Text(model.t("加拿大", "Canada")).tag("CA")
                    }
                    if draft.role == "homeowner" {
                        field(model.t("面积（平方米，可空）", "Area in m², optional"), text: $draft.area)
                        field(model.t("层数，可空", "Floors, optional"), text: $draft.floors)
                        field(model.t("房间数，可空", "Rooms, optional"), text: $draft.rooms)
                        Text(model.t("业主的门牌号留在账户里，定位时不使用。", "The owner’s house number stays on the account and is not used for geocoding."))
                            .font(.caption)
                            .foregroundStyle(Studio.mist)
                    } else {
                        Text(model.t("新档案从 Silver 开始，联系方式默认不公开。门牌号留在账户里，不出现在公开名单上。", "A new profile starts at Silver, and contact details stay private. The house number stays on the account and is not shown on the public directory."))
                            .font(.caption)
                            .foregroundStyle(Studio.mist)
                        Text(model.t("认领名单上已有的公司，或申请把本公司加入名单，都在网站里提交。", "Claim a company already on the list, or apply to add yours, on the website."))
                            .font(.caption)
                            .foregroundStyle(Studio.mist)
                    }
                    IntegratorComputerNotice()
                    Button(model.t("保存网站账户", "Save website account")) { Task { await save() } }
                        .buttonStyle(.borderedProminent)
                        .tint(Studio.ink)
                        .disabled(working)
                    if !message.isEmpty {
                        Text(message)
                            .font(.subheadline)
                            .foregroundStyle(Studio.ink)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding(20)
            }
            .background(Studio.paper)
            .navigationTitle(lockedRole == "installer" ? model.t("集成商网站账户", "Integrator website account") : model.t("网站账户", "Website account"))
            .toolbar {
                Button(model.t("首页", "Home")) { model.openHome() }
            }
            .onAppear {
                if let stored = WebsiteAccountStore.load() {
                    draft = stored
                }
                draft.role = lockedRole
            }
        }
        .onChange(of: model.dockTick) { _, _ in dismiss() }
    }

    private func field(_ title: String, text: Binding<String>, email: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title).font(.caption.weight(.semibold))
            TextField(title, text: text)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(email ? .never : .sentences)
                .keyboardType(email ? .emailAddress : .default)
                .autocorrectionDisabled(email)
        }
    }

    private func secure(_ title: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title).font(.caption.weight(.semibold))
            SecureField(title, text: text)
                .textFieldStyle(.roundedBorder)
        }
    }

    private var intro: String {
        if lockedRole == "installer" {
            return model.t(
                "这是集成商销售人员的入口。邮箱和密码会以集成商身份保存。网站登录只用这一组邮箱和密码，然后进入集成商工作台和项目订单管理。密码只发给网站，不留在这台手机的方案里。",
                "This is the integrator salesperson entrance. The email and password are saved with the integrator identity. The website accepts only that email and password, then opens the integrator workbench and its project orders. The password goes only to the website and is not kept with the plan on this iPhone."
            )
        }
        return model.t(
            "苹果账户就能使用 App，但不能打开网页。要在网页上使用，先填写邮箱和密码。网站登录只用这一组邮箱和密码，然后按业主身份打开和 App 相同的工作界面。密码只发给网站，不留在这台手机的方案里。",
            "Apple sign-in is enough for the app, and it does not open the website. To use the website, enter an email and password. The website accepts only that email and password, then opens the same studio as the app, as an owner. The password goes only to the website and is not kept with the plan on this iPhone."
        )
    }

    private func save() async {
        message = ""
        guard WebsiteConfig.isConfigured else {
            message = model.t("还不能连接网站。", "The website is not configured.")
            return
        }
        let email = draft.email.trimmingCharacters(in: .whitespacesAndNewlines)
        guard email.contains("@") else {
            message = model.t("需要有效邮箱。", "A valid email is required.")
            return
        }
        guard password.count >= 8 else {
            message = model.t("密码至少 8 位。", "The password needs at least 8 characters.")
            return
        }
        guard password == confirmation else {
            message = model.t("两次密码不一致。", "The two passwords do not match.")
            return
        }
        draft.email = email
        draft.role = lockedRole
        working = true
        defer { working = false }
        do {
            let saved = try await WebsiteAuth.register(draft: draft, password: password)
            password = ""
            confirmation = ""
            WebsiteAccountStore.save(draft)
            onSaved()
            if draft.role == "installer", !saved.installerSaved {
                message = model.t(
                    "邮箱和密码已保存。公司名称、城市和邮编都填上之后，才会写入集成商资料。请用这一组邮箱和密码在网站登录。",
                    "The email and password are saved. The integrator record is written after the company name, city, and postal code are all filled in. Sign in on the website with this email and password."
                )
            } else {
                message = model.t(
                    "邮箱和密码已保存。请用这一组邮箱和密码在网站登录。业主进入和 App 相同的工作界面，集成商销售人员进入集成商工作台。",
                    "The email and password are saved. Sign in on the website with this email and password. An owner opens the same studio as the app. An integrator salesperson opens the integrator workbench."
                )
            }
        } catch let error as WebsiteAuthError {
            message = error.text(chinese: model.chinese)
        } catch let error as URLError {
            let address = WebsiteConfig.loginAddress ?? WebsiteConfig.siteURL
            message = model.t(
                "手机无法与网站建立安全连接（\(error.localizedDescription)）。请先在浏览器打开 \(address)，确认能打开后再保存。",
                "This iPhone could not open a secure connection to the website (\(error.localizedDescription)). Open \(address) in a browser, confirm it loads, then save again."
            )
        } catch {
            message = error.localizedDescription
        }
    }
}

struct WebsiteSaveResult {
    var installerSaved: Bool
}

enum WebsiteAuthError: LocalizedError {
    case failed(String)

    func text(chinese: Bool) -> String {
        switch self {
        case .failed("password"):
            return chinese ? "这个邮箱已经有网站账户，但密码不一致。" : "This email already has a website account, and the password does not match."
        case .failed("unavailable"):
            return chinese ? "网站暂时不能保存账户。请稍后再试。" : "The website cannot save the account right now. Try again shortly."
        case .failed("email"), .failed("country"):
            return chinese ? "请检查邮箱、密码和国家。" : "Check the email, password, and country."
        case .failed("profile"):
            return chinese ? "账户已建立，但资料没有写入。请再保存一次。" : "The account exists, but the details were not written. Save again."
        case .failed("admin"):
            return chinese ? "这个邮箱不能在这里修改。" : "This email cannot be changed here."
        case .failed("missing"):
            return chinese ? "网站还没有打开保存入口。请等网站更新后再试。" : "The website does not have the save entry yet. Try again after the site is updated."
        case .failed(let message):
            return message
        }
    }

    var errorDescription: String? { text(chinese: false) }
}

enum WebsiteAuth {
    static func register(draft: WebsiteAccountDraft, password: String) async throws -> WebsiteSaveResult {
        let body: [String: String] = [
            "email": draft.email,
            "password": password,
            "role": draft.role,
            "fullName": draft.fullName,
            "companyName": draft.companyName,
            "addressLine": draft.addressLine,
            "houseNumber": draft.houseNumber,
            "city": draft.city,
            "postalCode": draft.postalCode,
            "countryCode": draft.countryCode,
            "area": draft.area,
            "floors": draft.floors,
            "rooms": draft.rooms
        ]
        let payload = try await sitePost("/api/account/register", body)
        return WebsiteSaveResult(installerSaved: payload["installerSaved"] as? Bool ?? false)
    }

    private static func sitePost(_ path: String, _ body: [String: String]) async throws -> [String: Any] {
        guard let base = WebsiteConfig.siteBase, let url = URL(string: base + path) else {
            throw WebsiteAuthError.failed("missing")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await URLSession.shared.data(for: request)
        } catch let error as URLError {
            throw error
        } catch {
            throw WebsiteAuthError.failed(error.localizedDescription)
        }
        let json = (try? JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
        guard let http = response as? HTTPURLResponse else {
            throw WebsiteAuthError.failed("unavailable")
        }
        if http.statusCode == 404 {
            throw WebsiteAuthError.failed("missing")
        }
        guard (200..<300).contains(http.statusCode) else {
            let code = json["error"] as? String
            throw WebsiteAuthError.failed(code ?? "unavailable")
        }
        return json
    }
}
