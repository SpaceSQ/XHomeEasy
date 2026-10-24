import SwiftUI

struct HelpView: View {
    var model: AppModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    HomeSettingsBar()
                    HelpArticle(source: document)
                }
                .padding(20)
                .frame(maxWidth: 860, alignment: .leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(Studio.paper)
            .navigationTitle(model.t("帮助", "Help"))
            .toolbar {
                Button(model.t("首页", "Home")) { model.openHome() }
            }
        }
        .environment(model)
    }

    private var document: String {
        let name = model.chinese ? "help-zh" : "help-en"
        let url = Bundle.main.url(forResource: name, withExtension: "md", subdirectory: "Resources/Help")
            ?? Bundle.main.url(forResource: name, withExtension: "md", subdirectory: "Help")
            ?? Bundle.main.url(forResource: name, withExtension: "md")
        guard let url, let raw = try? String(contentsOf: url, encoding: .utf8) else {
            return model.t("帮助文件没有载入。", "The help file did not load.")
        }
        return raw
    }
}

private struct HelpArticle: View {
    let source: String

    var body: some View {
        let article = HelpMarkdown.parse(source)
        VStack(alignment: .leading, spacing: 16) {
            if !article.title.isEmpty {
                Text(article.title)
                    .font(.system(size: 28, weight: .regular, design: .serif))
                    .foregroundStyle(Studio.ink)
                    .fixedSize(horizontal: false, vertical: true)
            }
            HelpBlocks(blocks: article.intro)
            ForEach(article.sections) { section in
                StudioCard {
                    Text(section.heading)
                        .font(.system(size: 22, weight: .regular, design: .serif))
                        .foregroundStyle(Studio.ink)
                        .fixedSize(horizontal: false, vertical: true)
                    HelpBlocks(blocks: section.blocks)
                }
            }
        }
    }
}

private struct HelpBlocks: View {
    let blocks: [HelpBlock]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(Array(blocks.enumerated()), id: \.offset) { _, block in
                switch block {
                case .paragraph(let text):
                    Text(text)
                        .font(.body)
                        .foregroundStyle(Studio.ink)
                        .lineSpacing(4)
                        .fixedSize(horizontal: false, vertical: true)
                case .subheading(let text):
                    Text(text)
                        .font(.headline)
                        .foregroundStyle(Studio.bronze)
                        .padding(.top, 6)
                        .fixedSize(horizontal: false, vertical: true)
                case .number(let index, let text):
                    HStack(alignment: .firstTextBaseline, spacing: 10) {
                        Text("\(index)")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(Studio.bronze)
                            .frame(width: 18, alignment: .trailing)
                        Text(text)
                            .font(.body)
                            .foregroundStyle(Studio.ink)
                            .lineSpacing(3)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                case .bullet(let text):
                    HStack(alignment: .firstTextBaseline, spacing: 10) {
                        Text("·")
                            .font(.body.weight(.bold))
                            .foregroundStyle(Studio.bronze)
                        Text(text)
                            .font(.body)
                            .foregroundStyle(Studio.ink)
                            .lineSpacing(3)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        }
    }
}

private enum HelpBlock {
    case paragraph(String)
    case subheading(String)
    case number(Int, String)
    case bullet(String)
}

private struct HelpSection: Identifiable {
    let id = UUID()
    var heading: String
    var blocks: [HelpBlock]
}

private struct HelpArticleModel {
    var title = ""
    var intro: [HelpBlock] = []
    var sections: [HelpSection] = []
}

private enum HelpMarkdown {
    static func parse(_ source: String) -> HelpArticleModel {
        var article = HelpArticleModel()
        var section: HelpSection?
        var paragraph = ""

        func flushParagraph() {
            let text = paragraph.trimmingCharacters(in: .whitespacesAndNewlines)
            paragraph = ""
            guard !text.isEmpty else { return }
            append(.paragraph(text), to: &article, section: &section)
        }

        for rawLine in source.split(separator: "\n", omittingEmptySubsequences: false) {
            let line = String(rawLine).trimmingCharacters(in: .whitespaces)
            if line.isEmpty {
                flushParagraph()
                continue
            }
            if line.hasPrefix("### ") {
                flushParagraph()
                append(.subheading(String(line.dropFirst(4))), to: &article, section: &section)
            } else if line.hasPrefix("## ") {
                flushParagraph()
                if let finished = section { article.sections.append(finished) }
                section = HelpSection(heading: String(line.dropFirst(3)), blocks: [])
            } else if line.hasPrefix("# ") {
                flushParagraph()
                article.title = String(line.dropFirst(2))
            } else if let number = numbered(line) {
                flushParagraph()
                append(.number(number.index, number.text), to: &article, section: &section)
            } else if line.hasPrefix("- ") {
                flushParagraph()
                append(.bullet(String(line.dropFirst(2))), to: &article, section: &section)
            } else {
                if !paragraph.isEmpty { paragraph += " " }
                paragraph += line
            }
        }
        flushParagraph()
        if let finished = section { article.sections.append(finished) }
        return article
    }

    private static func append(_ block: HelpBlock, to article: inout HelpArticleModel, section: inout HelpSection?) {
        if section != nil {
            section?.blocks.append(block)
        } else {
            article.intro.append(block)
        }
    }

    private static func numbered(_ line: String) -> (index: Int, text: String)? {
        guard let dot = line.firstIndex(of: "."), dot > line.startIndex else { return nil }
        let prefix = line[..<dot]
        guard let index = Int(prefix), line[line.index(after: dot)...].first == " " else { return nil }
        let text = line[line.index(dot, offsetBy: 2)...]
        return (index, String(text))
    }
}
