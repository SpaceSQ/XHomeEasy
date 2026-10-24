import AVFoundation
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
}

enum WebsiteConfig {
    static var supabaseURL: String { value("SupabaseURL") }
    static var anonKey: String { value("SupabaseAnonKey") }
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
    static var isConfigured: Bool {
        !supabaseURL.isEmpty && !anonKey.isEmpty && !siteURL.isEmpty
    }

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

    static func save(accessToken: String, userID: String) {
        write(accessToken, account: "access")
        write(userID, account: "user")
    }

    static func accessToken() -> String? { read("access") }
    static func userID() -> String? { read("user") }

    private static func write(_ value: String, account: String) {
        let data = Data(value.utf8)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        SecItemDelete(query as CFDictionary)
        var add = query
        add[kSecValueData as String] = data
        SecItemAdd(add as CFDictionary, nil)
    }

    private static func read(_ account: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var item: CFTypeRef?
        guard SecItemCopyMatching(query as CFDictionary, &item) == errSecSuccess,
              let data = item as? Data else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

struct IntegratorComputerNotice: View {
    @Environment(AppModel.self) private var model

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(model.t(
                "请用电脑上的浏览器打开下面的网址，再用这台手机扫描页面上的二维码。不要在这台手机的浏览器里打开该页，否则相机扫不到自己的屏幕。用邮箱和密码仍可以在手机浏览器里登录管理。",
                "Open the address below in a browser on a computer, then scan the code on that page with this iPhone. Do not open that page in this iPhone’s browser, or the camera cannot scan its own screen. Email and password can still sign in from the iPhone’s browser."
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
    @Environment(AppModel.self) private var model
    @Environment(\.dismiss) private var dismiss
    @State private var draft = WebsiteAccountDraft()
    @State private var password = ""
    @State private var confirmation = ""
    @State private var message = ""
    @State private var working = false
    @State private var showScanner = false
    @State private var websiteReady = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    HomeSettingsBar()
                    Text(intro)
                        .font(.footnote)
                        .foregroundStyle(Studio.mist)
                    if !WebsiteConfig.isConfigured {
                        Text(model.t("这个安装还没有填入本产品自己的 Supabase 地址、匿名密钥和网站地址。", "This install does not yet have this product’s own Supabase URL, anon key, and website address."))
                            .foregroundStyle(Studio.clay)
                    }
                    Text(model.t("我们不验证这个邮箱是否真实。", "We do not check that this mailbox is real."))
                        .font(.caption)
                        .foregroundStyle(Studio.mist)
                    field(model.t("邮箱", "Email"), text: $draft.email)
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
                        Text(model.t("认领名单上已有的公司，或申请把本公司加入名单，都在电脑浏览器里的网站提交。", "Claim a company already on the list, or apply to add yours, on the website in a computer browser."))
                            .font(.caption)
                            .foregroundStyle(Studio.mist)
                        IntegratorComputerNotice()
                    }
                    Button(model.t("保存网站账户", "Save website account")) { Task { await save() } }
                        .buttonStyle(.borderedProminent)
                        .tint(Studio.ink)
                        .disabled(working)
                    Button(model.t("扫描网站登录码", "Scan the website sign-in code")) { showScanner = true }
                        .buttonStyle(.bordered)
                        .disabled(!websiteReady)
                    if !websiteReady {
                        Text(model.t("先保存邮箱和密码，才能用二维码代替网页上的邮箱密码登录。只用苹果账户不能打开网页。", "Save the email and password before the code can stand in for them on the website. Apple sign-in alone does not open the website."))
                            .font(.caption)
                            .foregroundStyle(Studio.mist)
                    }
                    if !message.isEmpty {
                        Text(message).font(.subheadline)
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
                loadDraft()
                draft.role = lockedRole
                websiteReady = WebsiteSession.accessToken() != nil
            }
            .sheet(isPresented: $showScanner) {
                WebsiteQRScanner { code in
                    showScanner = false
                    Task { await approve(code) }
                }
            }
        }
        .onChange(of: model.dockTick) { _, _ in dismiss() }
    }

    private func field(_ title: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title).font(.caption.weight(.semibold))
            TextField(title, text: text)
                .textFieldStyle(.roundedBorder)
        }
    }

    private func secure(_ title: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title).font(.caption.weight(.semibold))
            SecureField(title, text: text)
                .textFieldStyle(.roundedBorder)
        }
    }

    private func loadDraft() {
        let key = "xhomeeasy.account"
        guard let data = UserDefaults.standard.data(forKey: key),
              let stored = try? JSONDecoder().decode(WebsiteAccountDraft.self, from: data) else { return }
        draft = stored
        draft.role = lockedRole
    }

    private var intro: String {
        if lockedRole == "installer" {
            return model.t(
                "这是集成商销售人员的入口。邮箱和密码会以集成商身份保存。网页上的统一登录，无论扫码还是邮箱密码，都会进入集成商工作台和项目订单管理。密码只发给登录服务，不留在这台手机的方案里。",
                "This is the integrator salesperson entrance. The email and password are saved with the integrator identity. The website’s one sign-in page, by code or by email, then opens the integrator workbench and its project orders. The password goes only to the sign-in service and is not kept with the plan on this iPhone."
            )
        }
        return model.t(
            "苹果账户就能使用 App，但不能打开网页。要在网页上使用，先填写邮箱和密码。保存之后可以扫码，二维码代替在网页上再输入一次邮箱和密码。网页会按业主身份打开和 App 相同的工作界面。密码只发给登录服务，不留在这台手机的方案里。",
            "Apple sign-in is enough for the app, and it does not open the website. To use the website, enter an email and password. After they are saved, the code can stand in for typing them again. The website then opens the same studio as the app, as an owner. The password goes only to the sign-in service and is not kept with the plan on this iPhone."
        )
    }

    private func persistDraft() {
        if let data = try? JSONEncoder().encode(draft) {
            UserDefaults.standard.set(data, forKey: "xhomeeasy.account")
        }
    }

    private func save() async {
        message = ""
        guard WebsiteConfig.isConfigured else {
            message = model.t("还不能连接网站账户服务。", "The website account service is not configured.")
            return
        }
        guard draft.email.contains("@") else {
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
        draft.role = lockedRole
        working = true
        defer { working = false }
        do {
            let session = try await WebsiteAuth.establishSession(email: draft.email, password: password, fullName: draft.fullName)
            password = ""
            confirmation = ""
            persistDraft()
            try await WebsiteAuth.saveProfile(draft: draft, session: session)
            if draft.role == "installer", !draft.companyName.isEmpty, !draft.city.isEmpty, !draft.postalCode.isEmpty {
                try await WebsiteAuth.saveInstaller(draft: draft, token: session.accessToken)
            } else if draft.role == "homeowner", !draft.city.isEmpty, !draft.postalCode.isEmpty {
                try await WebsiteAuth.geocodeOwner(draft: draft, token: session.accessToken)
            }
            websiteReady = true
            message = model.t("邮箱和密码已保存。二维码扫描已解锁。网页登录会按这个身份进入对应的工作台。", "The email and password are saved. Code scanning is unlocked. Website sign-in opens the desk for this identity.")
        } catch {
            message = error.localizedDescription
        }
    }

    private func approve(_ raw: String) async {
        guard let parsed = PairPayload.parse(raw) else {
            message = model.t("这不是本网站的登录码。", "That is not a sign-in code for this website.")
            return
        }
        guard let token = WebsiteSession.accessToken() else {
            message = model.t("先保存网站账户，再扫描。", "Save the website account before scanning.")
            return
        }
        do {
            try await WebsiteAuth.approve(id: parsed.id, secret: parsed.secret, token: token)
            message = model.t("网页登录已确认。", "The website sign-in is approved.")
        } catch {
            message = error.localizedDescription
        }
    }
}

struct PairPayload {
    var role: String
    var id: String
    var secret: String

    static func parse(_ value: String) -> PairPayload? {
        let parts = value.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: ":", omittingEmptySubsequences: false).map(String.init)
        guard parts.count == 5, parts[0] == "xhomeeasy-pair", parts[1] == "v1",
              parts[2] == "homeowner" || parts[2] == "installer",
              !parts[3].isEmpty, !parts[4].isEmpty else { return nil }
        return PairPayload(role: parts[2], id: parts[3], secret: parts[4])
    }
}

enum WebsiteAuthError: LocalizedError {
    case failed(String)
    var errorDescription: String? {
        switch self {
        case .failed(let message): return message
        }
    }
}

struct WebsiteAuthSession {
    var accessToken: String
    var userID: String
}

enum WebsiteAuth {
    static func establishSession(email: String, password: String, fullName: String) async throws -> WebsiteAuthSession {
        let signup = try await postAuth("/auth/v1/signup", [
            "email": email.trimmingCharacters(in: .whitespacesAndNewlines),
            "password": password,
            "data": ["full_name": fullName, "locale": "en-US"]
        ])
        if let session = session(from: signup) { return session }
        if let session = try await passwordSession(email: email, password: password) { return session }
        try await activate(email: email)
        if let session = try await passwordSession(email: email, password: password) { return session }
        throw WebsiteAuthError.failed("session")
    }

    private static func passwordSession(email: String, password: String) async throws -> WebsiteAuthSession? {
        let signin = try await postAuth("/auth/v1/token?grant_type=password", [
            "email": email.trimmingCharacters(in: .whitespacesAndNewlines),
            "password": password
        ])
        return session(from: signin)
    }

    private static func activate(email: String) async throws {
        try await sitePost("/api/account/activate", ["email": email.trimmingCharacters(in: .whitespacesAndNewlines)], token: "")
    }

    static func saveProfile(draft: WebsiteAccountDraft, session: WebsiteAuthSession) async throws {
        var body: [String: Any] = [
            "role": draft.role,
            "full_name": draft.fullName,
            "locale": "en-US",
            "country_code": draft.countryCode,
            "postal_code": draft.postalCode,
            "city": draft.city,
            "house_number": draft.houseNumber,
            "address_line": draft.addressLine
        ]
        if let area = Int(draft.area), area > 0 { body["area_sqm"] = area }
        if let floors = Int(draft.floors), floors > 0 { body["floors"] = floors }
        if let rooms = Int(draft.rooms), rooms > 0 { body["room_count"] = rooms }
        try await patch("profiles?id=eq.\(session.userID)", body: body, token: session.accessToken)
    }

    static func geocodeOwner(draft: WebsiteAccountDraft, token: String) async throws {
        try await sitePost("/api/account/geocode", [
            "street": draft.addressLine,
            "city": draft.city,
            "postalCode": draft.postalCode,
            "countryCode": draft.countryCode
        ], token: token)
    }

    static func saveInstaller(draft: WebsiteAccountDraft, token: String) async throws {
        try await sitePost("/api/account/installer", [
            "companyName": draft.companyName,
            "city": draft.city,
            "postalCode": draft.postalCode,
            "countryCode": draft.countryCode,
            "streetAddress": draft.addressLine,
            "houseNumber": draft.houseNumber
        ], token: token)
    }

    static func approve(id: String, secret: String, token: String) async throws {
        try await sitePost("/api/login-challenges/approve", ["id": id, "secret": secret], token: token)
    }

    private static func session(from json: [String: Any]) -> WebsiteAuthSession? {
        let access = json["access_token"] as? String
        let user = (json["user"] as? [String: Any])?["id"] as? String
        guard let access, let user else { return nil }
        WebsiteSession.save(accessToken: access, userID: user)
        return WebsiteAuthSession(accessToken: access, userID: user)
    }

    private static func postAuth(_ path: String, _ body: [String: Any]) async throws -> [String: Any] {
        var request = URLRequest(url: endpoint(WebsiteConfig.supabaseURL, path))
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(WebsiteConfig.anonKey, forHTTPHeaderField: "apikey")
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        let (data, response) = try await URLSession.shared.data(for: request)
        let json = (try? JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
        if let http = response as? HTTPURLResponse, !(200..<300).contains(http.statusCode), json["access_token"] == nil {
            return json
        }
        return json
    }

    private static func patch(_ query: String, body: [String: Any], token: String) async throws {
        var request = URLRequest(url: endpoint(WebsiteConfig.supabaseURL, "/rest/v1/\(query)"))
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(WebsiteConfig.anonKey, forHTTPHeaderField: "apikey")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("return=minimal", forHTTPHeaderField: "Prefer")
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        let (_, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw WebsiteAuthError.failed("profile")
        }
    }

    private static func sitePost(_ path: String, _ body: [String: String], token: String) async throws {
        var request = URLRequest(url: endpoint(WebsiteConfig.siteURL, path))
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            let text = String(data: data, encoding: .utf8) ?? "request"
            throw WebsiteAuthError.failed(text)
        }
    }

    private static func endpoint(_ base: String, _ path: String) -> URL {
        let trimmed = base.hasSuffix("/") ? String(base.dropLast()) : base
        return URL(string: trimmed + (path.hasPrefix("/") ? path : "/" + path))!
    }
}

struct WebsiteQRScanner: UIViewControllerRepresentable {
    var onCode: (String) -> Void

    func makeUIViewController(context: Context) -> ScannerController {
        let controller = ScannerController()
        controller.onCode = onCode
        return controller
    }

    func updateUIViewController(_ uiViewController: ScannerController, context: Context) {}

    final class ScannerController: UIViewController {
        var onCode: ((String) -> Void)?
        private let session = AVCaptureSession()
        private var seen = false

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .black
            guard let device = AVCaptureDevice.default(for: .video),
                  let input = try? AVCaptureDeviceInput(device: device),
                  session.canAddInput(input) else { return }
            session.addInput(input)
            let output = AVCaptureMetadataOutput()
            guard session.canAddOutput(output) else { return }
            session.addOutput(output)
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            output.metadataObjectTypes = [.qr]
            let preview = AVCaptureVideoPreviewLayer(session: session)
            preview.frame = view.bounds
            preview.videoGravity = .resizeAspectFill
            view.layer.addSublayer(preview)
            DispatchQueue.global(qos: .userInitiated).async { [session] in
                session.startRunning()
            }
        }

    }
}

extension WebsiteQRScanner.ScannerController: AVCaptureMetadataOutputObjectsDelegate {
    nonisolated func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        let value = (metadataObjects.first as? AVMetadataMachineReadableCodeObject)?.stringValue
        Task { @MainActor in
            guard let value, !seen else { return }
            seen = true
            session.stopRunning()
            onCode?(value)
        }
    }
}
