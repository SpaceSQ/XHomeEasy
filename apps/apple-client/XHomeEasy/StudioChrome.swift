import SwiftUI
import XHomeEasyEngines

enum Studio {
    static let ink = Color(red: 0.055, green: 0.102, blue: 0.145)
    static let paper = Color(red: 0.965, green: 0.945, blue: 0.910)
    static let card = Color(red: 0.992, green: 0.980, blue: 0.960)
    static let bronze = Color(red: 0.42, green: 0.32, blue: 0.16)
    static let rule = Color(red: 0.72, green: 0.58, blue: 0.38)
    static let forest = Color(red: 0.11, green: 0.36, blue: 0.27)
    static let clay = Color(red: 0.45, green: 0.22, blue: 0.18)
    static let amber = Color(red: 0.55, green: 0.36, blue: 0.10)
    static let mist = Color(red: 0.38, green: 0.36, blue: 0.33)
    /// Quiet warm label on the dark phone tab bar. Lighter than `mist`, which disappears on `ink`.
    static let tabIdle = Color(red: 0.74, green: 0.68, blue: 0.58)
    static let e4 = Color(red: 0.86, green: 0.83, blue: 0.78)
}

struct HomeSettingsBar: View {
    @Environment(AppModel.self) private var model

    var body: some View {
        HStack(spacing: 12) {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .accessibilityHidden(true)
            Button { model.openHome() } label: {
                Label(model.t("首页", "Home"), systemImage: "house")
            }
            Spacer()
            Button { model.openHelp() } label: {
                Label(model.t("帮助", "Help"), systemImage: "book")
            }
            Button { model.openSettings() } label: {
                Label(model.t("设置", "Settings"), systemImage: "gearshape")
            }
        }
        .font(.subheadline.weight(.semibold))
        .foregroundStyle(Studio.ink)
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(Studio.paper)
    }
}

struct PaperScreen<Content: View>: View {
    let kicker: String
    let title: String
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack(spacing: 0) {
            HomeSettingsBar()
            Divider().overlay(Studio.rule)
            scroll
        }
        .background(Studio.paper)
    }

    private var scroll: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(kicker)
                        .font(.caption.weight(.semibold))
                        .tracking(1.6)
                        .foregroundStyle(Studio.bronze)
                    Text(title)
                        .font(.system(size: 34, weight: .regular, design: .serif))
                        .foregroundStyle(Studio.ink)
                        .fixedSize(horizontal: false, vertical: true)
                }
                content()
            }
            .padding(20)
            .frame(maxWidth: 860, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Studio.paper)
    }
}

struct StudioCard<Content: View>: View {
    @ViewBuilder var content: () -> Content
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            content()
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Studio.card)
        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Studio.rule.opacity(0.7), lineWidth: 1))
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

struct EvidenceBadge: View {
    let tier: String
    var body: some View {
        Text(label)
            .font(.caption2.weight(.semibold))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .foregroundStyle(foreground)
            .background(background)
            .clipShape(Capsule())
            .accessibilityLabel(label)
    }

    private var label: String {
        switch tier {
        case "E1": return "E1 官方"
        case "E2": return "E2 行业"
        case "E3": return "E3 集成商"
        default: return "E4 社区"
        }
    }

    private var background: Color {
        switch tier {
        case "E1": return Studio.ink
        case "E2": return Studio.forest
        case "E3": return Studio.amber
        default: return Studio.e4
        }
    }

    private var foreground: Color {
        tier == "E4" ? Studio.ink : Color.white
    }
}

struct SignalMark: View {
    let light: SignalLight
    let chinese: Bool
    var body: some View {
        Text(word)
            .font(.caption.weight(.bold))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .foregroundStyle(foreground)
            .background(background)
            .clipShape(Capsule())
            .accessibilityLabel(word)
    }

    private var word: String {
        switch light {
        case .proceed: return chinese ? "优先" : "Lead"
        case .consider: return chinese ? "可考虑" : "Consider"
        case .deferPath: return chinese ? "不优先" : "Not the lead"
        }
    }

    private var background: Color {
        switch light {
        case .proceed: return Studio.forest
        case .consider: return Color(red: 0.95, green: 0.84, blue: 0.62)
        case .deferPath: return Studio.clay
        }
    }

    private var foreground: Color {
        light == .consider ? Studio.ink : Color.white
    }
}

struct SourceLink: View {
    let title: String
    let url: String
    var body: some View {
        if let destination = URL(string: url) {
            Link(destination: destination) {
                Label(title, systemImage: "arrow.up.right")
                    .font(.caption)
                    .foregroundStyle(Studio.bronze)
            }
        }
    }
}

struct ChoiceButton: View {
    let title: String
    let selected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(Studio.ink)
                Spacer()
                Image(systemName: selected ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(selected ? Studio.forest : Studio.mist)
            }
            .padding(14)
            .frame(minHeight: 52)
            .background(selected ? Color(red: 0.94, green: 0.90, blue: 0.82) : Studio.card)
            .overlay(RoundedRectangle(cornerRadius: 4).stroke(selected ? Studio.bronze : Studio.rule.opacity(0.5), lineWidth: 1))
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(selected ? .isSelected : [])
    }
}

func usd(_ value: Int) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = "USD"
    formatter.maximumFractionDigits = 0
    return formatter.string(from: NSNumber(value: value)) ?? "$\(value)"
}

func usd(_ value: Double) -> String { usd(Int(value.rounded())) }
