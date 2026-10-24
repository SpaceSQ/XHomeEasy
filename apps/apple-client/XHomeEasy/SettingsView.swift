import AuthenticationServices
import SwiftUI

struct SignInView: View {
    @Environment(AppModel.self) private var model

    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            Spacer()
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 96, height: 96)
                .accessibilityLabel("X Home Easy")
            Text("X HOME EASY")
                .font(.caption.weight(.semibold))
                .tracking(1.6)
                .foregroundStyle(Studio.bronze)
            Text(model.t("用苹果账户进入", "Sign in with Apple"))
                .font(.system(size: 34, weight: .regular, design: .serif))
                .foregroundStyle(Studio.ink)
            Text(model.t(
                "登录之后，问诊、方案和设置保存在这台手机上，并记在这个苹果账户名下。登出不会删掉它们。",
                "After sign-in, the consult, plan, and settings stay on this iPhone under this Apple account. Signing out does not delete them."
            ))
            .foregroundStyle(Studio.mist)
            Button(model.t("先看帮助", "Read help first")) { model.openHelp() }
                .buttonStyle(.bordered)
            SignInWithAppleButton(.signIn) { request in
                request.requestedScopes = [.fullName, .email]
            } onCompletion: { result in
                switch result {
                case .success(let authorization):
                    guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
                    let name = [credential.fullName?.givenName, credential.fullName?.familyName]
                        .compactMap { $0 }
                        .joined(separator: " ")
                    model.completeSignIn(userID: credential.user, fullName: name, email: credential.email ?? "")
                case .failure(let error):
                    model.authError = error.localizedDescription
                }
            }
            .signInWithAppleButtonStyle(.black)
            .frame(height: 48)
            if let authError = model.authError {
                Text(authError).font(.footnote).foregroundStyle(Studio.clay)
            }
            Spacer()
        }
        .padding(24)
        .frame(maxWidth: 520)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Studio.paper)
    }
}

struct SettingsView: View {
    @Bindable var model: AppModel
    @State private var confirmSignOut = false
    @State private var confirmDelete = false
    @State private var linkedDraft = WebsiteAccountStore.load()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    HomeSettingsBar()
                    if let profile = model.currentProfile {
                        StudioCard {
                            Text(model.t("苹果账户", "Apple account")).font(.headline)
                            Text(profile.fullName.isEmpty ? model.t("已登录", "Signed in") : profile.fullName)
                            if !profile.email.isEmpty {
                                Text(profile.email).font(.subheadline).foregroundStyle(Studio.mist)
                            }
                            Text(model.t("姓名和邮箱只在首次授权时由苹果提供。", "Apple shares the name and email only on the first authorization."))
                                .font(.caption)
                                .foregroundStyle(Studio.mist)
                        }
                    }
                    Button {
                        model.openHelp()
                    } label: {
                        StudioCard {
                            Text(model.t("帮助", "Help")).font(.headline).foregroundStyle(Studio.ink)
                            Text(model.t("功能模块、使用流程，以及免费与收费权益。", "Modules, the workflow, and free versus paid rights."))
                                .font(.subheadline)
                                .foregroundStyle(Studio.mist)
                        }
                    }
                    .buttonStyle(.plain)
                    if linkedDraft == nil {
                        NavigationLink {
                            WebsiteAccountView(onSaved: { linkedDraft = WebsiteAccountStore.load() })
                                .environment(model)
                        } label: {
                            StudioCard {
                                Text(model.t("网站账户资料", "Website account details")).font(.headline).foregroundStyle(Studio.ink)
                                Text(model.t("苹果账户就能用 App。要打开网页，在这里填写邮箱和密码。我们不验证邮箱是否真实。网站只用这一组邮箱和密码登录。", "Apple sign-in is enough for the app. To open the website, enter an email and password here. We do not check that the mailbox is real. The website signs in only with that email and password."))
                                    .font(.subheadline)
                                    .foregroundStyle(Studio.mist)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                    StudioCard {
                        Toggle(model.t("界面用中文", "Chinese interface"), isOn: $model.chinese)
                            .onChange(of: model.chinese) { _, _ in
                                Task { @MainActor in model.save() }
                            }
                    }
                    if let linked = linkedDraft {
                        NavigationLink {
                            WebsiteAccountView(
                                lockedRole: linked.role == "installer" ? "installer" : "homeowner",
                                onSaved: { linkedDraft = WebsiteAccountStore.load() }
                            )
                            .environment(model)
                        } label: {
                            StudioCard {
                                Text(model.t("已关联网站账户", "Website account already linked")).font(.headline).foregroundStyle(Studio.ink)
                                Text(linked.email).font(.subheadline).foregroundStyle(Studio.ink)
                                Text(linked.linkedAddress(chinese: model.chinese).isEmpty
                                     ? model.t("地址还没有填写。", "No address yet.")
                                     : linked.linkedAddress(chinese: model.chinese))
                                    .font(.subheadline)
                                    .foregroundStyle(Studio.mist)
                                Text(model.t("点击进入，可以修改这些资料。", "Tap to edit these details."))
                                    .font(.caption)
                                    .foregroundStyle(Studio.bronze)
                            }
                        }
                        .buttonStyle(.plain)
                        if linked.role == "installer" {
                            IntegratorComputerNotice()
                        }
                    }
                    if linkedDraft?.role != "installer" {
                        StudioCard {
                            Text(model.t(
                                "我是一名集成商销售人员，需要进入集成商工作台。",
                                "I am an integrator salesperson and need the integrator workbench."
                            ))
                            .font(.subheadline)
                            .foregroundStyle(Studio.mist)
                            NavigationLink {
                                WebsiteAccountView(lockedRole: "installer", onSaved: { linkedDraft = WebsiteAccountStore.load() })
                                    .environment(model)
                            } label: {
                                Text(model.t("进入", "Enter"))
                                    .font(.body.weight(.semibold))
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(Studio.ink)
                            Text(model.t(
                                "进入后只在本 App 填写邮箱和密码，并以集成商身份保存。网站只用这一组邮箱和密码登录。",
                                "Enter only to save an email and password in this app, with the integrator identity. The website signs in only with that email and password."
                            ))
                            .font(.caption)
                            .foregroundStyle(Studio.mist)
                            IntegratorComputerNotice()
                        }
                    }
                    StudioCard {
                        Text(model.t("登出", "Sign out")).font(.headline)
                        Text(model.t("只结束这次苹果登录。问诊、方案、房间和设置仍留在这台手机上，用同一个苹果账户再登录就能看到。", "This ends the Apple session only. The consult, plan, rooms, and settings remain on this iPhone and return when the same Apple account signs in."))
                            .font(.subheadline)
                            .foregroundStyle(Studio.mist)
                        Button(model.t("登出", "Sign out")) { confirmSignOut = true }
                            .buttonStyle(.bordered)
                    }
                    StudioCard {
                        Text(model.t("注销", "Delete this device’s account")).font(.headline)
                        Text(model.t("删除本机保存的登录信息，以及这个苹果账户在这台手机上的别墅方案、问诊、报价草稿和设置。不会删除你的 Apple ID。", "Deletes the sign-in record stored on this iPhone and this Apple account’s villa plan, consult, quote drafts, and settings on this iPhone. Your Apple ID itself is not deleted."))
                            .font(.subheadline)
                            .foregroundStyle(Studio.mist)
                        Button(model.t("注销并删除本机数据", "Delete on-device account and data"), role: .destructive) {
                            confirmDelete = true
                        }
                    }
                }
                .padding(20)
            }
            .background(Studio.paper)
            .onAppear { linkedDraft = WebsiteAccountStore.load() }
            .navigationTitle(model.t("设置", "Settings"))
            .toolbar {
                Button(model.t("首页", "Home")) { model.openHome() }
            }
        }
        .environment(model)
        .confirmationDialog(model.t("登出苹果账户？", "Sign out of Apple?"), isPresented: $confirmSignOut, titleVisibility: .visible) {
            Button(model.t("登出", "Sign out")) { model.signOut() }
            Button(model.t("取消", "Cancel"), role: .cancel) {}
        } message: {
            Text(model.t("方案会留在这台手机上。", "The plan stays on this iPhone."))
        }
        .confirmationDialog(model.t("注销并删除本机数据？", "Delete the on-device account and data?"), isPresented: $confirmDelete, titleVisibility: .visible) {
            Button(model.t("注销", "Delete"), role: .destructive) { model.deleteAccount() }
            Button(model.t("取消", "Cancel"), role: .cancel) {}
        } message: {
            Text(model.t("本机上的登录信息和该账户的设计记录会被删除，且不能从本机恢复。", "The sign-in record and this account’s design on this iPhone will be deleted and cannot be restored from this iPhone."))
        }
    }
}
