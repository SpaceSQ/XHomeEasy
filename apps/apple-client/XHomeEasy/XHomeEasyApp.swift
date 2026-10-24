import SwiftData
import SwiftUI

enum AppCover: String, Identifiable {
    case settings, help
    var id: String { rawValue }
}

enum StudioTab: String, CaseIterable, Identifiable, Hashable {
    case advisor, blueprint, rfq, integrators, lifecycle
    var id: StudioTab { self }

    func title(_ chinese: Bool) -> String {
        switch self {
        case .advisor: return chinese ? "顾问" : "Advisor"
        case .blueprint: return chinese ? "方案" : "Plan"
        case .rfq: return chinese ? "招标" : "RFQ"
        case .integrators: return chinese ? "集成商" : "Integrators"
        case .lifecycle: return chinese ? "陪伴" : "Care"
        }
    }

    var symbol: String {
        switch self {
        case .advisor: return "compass"
        case .blueprint: return "square.grid.2x2"
        case .rfq: return "doc.text"
        case .integrators: return "mappin.and.ellipse"
        case .lifecycle: return "clock"
        }
    }
}

/// Dark phone tab bar. The system bar stays a light glass surface, so compact width uses this bar instead.
struct StudioPhoneTabBar: View {
    @Binding var selection: StudioTab
    var chinese: Bool

    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Studio.rule.opacity(0.55))
                .frame(height: 1)
            HStack(spacing: 4) {
                ForEach(StudioTab.allCases) { item in
                    tab(item)
                }
            }
            .padding(.horizontal, 6)
            .padding(.top, 6)
            .padding(.bottom, 6)
        }
        .background(Studio.ink.ignoresSafeArea(edges: .bottom))
        .accessibilityElement(children: .contain)
    }

    private func tab(_ item: StudioTab) -> some View {
        let selected = selection == item
        return Button {
            selection = item
        } label: {
            VStack(spacing: 3) {
                Image(systemName: item.symbol)
                    .font(.system(size: 18, weight: selected ? .semibold : .regular))
                    .frame(height: 22)
                Text(item.title(chinese))
                    .font(.system(size: 10, weight: selected ? .bold : .medium))
                    .lineLimit(1)
                    .minimumScaleFactor(0.65)
            }
            .foregroundStyle(selected ? Studio.paper : Studio.tabIdle)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 6)
            .background {
                if selected {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.white.opacity(0.10))
                        .overlay {
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(Studio.rule, lineWidth: 1.5)
                        }
                }
            }
            .contentShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .buttonStyle(.plain)
        .tint(selected ? Studio.paper : Studio.tabIdle)
        .accessibilityLabel(item.title(chinese))
        .accessibilityAddTraits(selected ? .isSelected : [])
    }
}

struct RootView: View {
    @Environment(\.horizontalSizeClass) private var sizeClass
    @Environment(\.modelContext) private var context
    @Environment(\.scenePhase) private var scenePhase
    @State private var model = AppModel()
    @State private var splashDone = false
    @State private var loadedPhoneTabs: Set<StudioTab> = [.advisor]

    var body: some View {
        @Bindable var model = model
        return ZStack {
            appBody
            if let cover = model.cover {
                coverSheet(cover)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Studio.paper.ignoresSafeArea())
            }
            if !splashDone {
                LaunchSplash { splashDone = true }
            }
        }
        .environment(model)
        .task { model.attach(context) }
        .onChange(of: scenePhase) { _, phase in
            if phase != .active { model.save() }
        }
    }

    private var appBody: some View {
        @Bindable var model = model
        return Group {
            if !model.accountReady {
                Studio.paper.ignoresSafeArea()
            } else if !model.signedIn {
                SignInView()
            } else if sizeClass == .regular {
                NavigationSplitView {
                    List {
                        ForEach(StudioTab.allCases) { item in
                            Button {
                                model.studioTab = item
                            } label: {
                                Label(item.title(model.chinese), systemImage: item.symbol)
                                    .foregroundStyle(model.studioTab == item ? Studio.bronze : Studio.ink)
                            }
                        }
                    }
                    .navigationTitle("X Home Easy")
                } detail: {
                    screen(model.studioTab)
                }
            } else {
                VStack(spacing: 0) {
                    ZStack {
                        ForEach(StudioTab.allCases) { tab in
                            if loadedPhoneTabs.contains(tab) || tab == model.studioTab {
                                screen(tab)
                                    .opacity(model.studioTab == tab ? 1 : 0)
                                    .allowsHitTesting(model.studioTab == tab)
                                    .accessibilityHidden(model.studioTab != tab)
                                    .zIndex(model.studioTab == tab ? 1 : 0)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    StudioPhoneTabBar(selection: $model.studioTab, chinese: model.chinese)
                }
                .background(Studio.ink.ignoresSafeArea(edges: .bottom))
                .onAppear { loadedPhoneTabs.insert(model.studioTab) }
                .onChange(of: model.studioTab) { _, tab in
                    loadedPhoneTabs.insert(tab)
                }
            }
        }
        .tint(Studio.ink)
    }

    @ViewBuilder private func coverSheet(_ cover: AppCover) -> some View {
        switch cover {
        case .settings: SettingsView(model: model)
        case .help: HelpView(model: model)
        }
    }

    @ViewBuilder private func screen(_ tab: StudioTab) -> some View {
        switch tab {
        case .advisor: AdvisorView()
        case .blueprint: BlueprintView()
        case .rfq: RFQView()
        case .integrators: IntegratorsView()
        case .lifecycle: LifecycleView()
        }
    }
}

@main
struct XHomeEasyApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: EstateProject.self)
    }
}
