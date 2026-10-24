import SwiftUI

struct BrandSeat: Identifiable {
    let id: String
    let asset: String
    let x: CGFloat
    let y: CGFloat
    let contentMode: ContentMode

    init(id: String, asset: String, x: CGFloat, y: CGFloat, contentMode: ContentMode = .fit) {
        self.id = id
        self.asset = asset
        self.x = x
        self.y = y
        self.contentMode = contentMode
    }

    static let all: [BrandSeat] = [
        // Square canvas; the wordmark sits in a short center band. Fill crops the empty space.
        BrandSeat(id: "Control4", asset: "BrandControl4", x: 0.18, y: 0.50, contentMode: .fill),
        BrandSeat(id: "Crestron", asset: "BrandCrestron", x: 0.82, y: 0.50),
        BrandSeat(id: "Savant", asset: "BrandSavant", x: 0.50, y: 0.16),
        BrandSeat(id: "Lutron", asset: "BrandLutron", x: 0.50, y: 0.82)
    ]
}

struct LaunchSplash: View {
    @Environment(AppModel.self) private var model
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    var onFinished: () -> Void
    @State private var progress: CGFloat = 0
    @State private var shimmer = false
    @State private var finished = false

    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            ZStack {
                Color.black.ignoresSafeArea()
                ConnectionField(progress: progress)
                ForEach(BrandSeat.all) { seat in
                    brandPlate(seat, in: size)
                }
                centerMark(in: size)
                VStack {
                    HStack {
                        Spacer()
                        Button(model.t("跳过", "Skip")) { finish() }
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 16)
                            .frame(minHeight: 44)
                    }
                    Spacer()
                    Text("Control4, Crestron, Savant, and Lutron are trademarks of their respective owners.")
                        .font(.caption2)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white.opacity(0.55))
                        .padding(.horizontal, 24)
                        .padding(.bottom, 28)
                }
            }
        }
        .ignoresSafeArea()
        .onAppear(perform: start)
    }

    private func brandPlate(_ seat: BrandSeat, in size: CGSize) -> some View {
        let side = min(size.width, size.height)
        let card = CGSize(width: side * 0.34, height: side * 0.16)
        let inset: CGFloat = 8
        return Image(seat.asset)
            .resizable()
            .aspectRatio(contentMode: seat.contentMode)
            .frame(width: card.width - inset * 2, height: card.height - inset * 2)
            .clipped()
            .padding(inset)
            .frame(width: card.width, height: card.height)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .opacity(shimmer ? 1 : 0.78)
            .shadow(color: .white.opacity(shimmer ? 0.55 : 0.12), radius: shimmer ? 12 : 4)
            .position(x: size.width * seat.x, y: size.height * seat.y)
            .accessibilityLabel(seat.id)
    }

    private func centerMark(in size: CGSize) -> some View {
        let base = min(size.width, size.height) * 0.2
        let scale = 1 + progress
        return Image("Logo")
            .resizable()
            .scaledToFit()
            .frame(width: base, height: base)
            .scaleEffect(scale)
            .shadow(color: Color(red: 0.85, green: 0.25, blue: 0.18).opacity(0.45 * progress), radius: 18 * progress)
            .position(x: size.width * 0.5, y: size.height * 0.46)
            .accessibilityLabel("X Home Easy")
    }

    private func start() {
        if reduceMotion {
            progress = 1
            shimmer = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { finish() }
            return
        }
        withAnimation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true)) {
            shimmer = true
        }
        withAnimation(.easeInOut(duration: 3.2)) {
            progress = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.9) { finish() }
    }

    private func finish() {
        guard !finished else { return }
        finished = true
        onFinished()
    }
}

private struct ConnectionField: View {
    var progress: CGFloat

    var body: some View {
        Canvas { context, canvasSize in
            let center = CGPoint(x: canvasSize.width * 0.5, y: canvasSize.height * 0.46)
            let centerRadius = min(canvasSize.width, canvasSize.height) * 0.2 * (1 + progress) * 0.5
            for seat in BrandSeat.all {
                let target = CGPoint(x: canvasSize.width * seat.x, y: canvasSize.height * seat.y)
                let brandRadius = min(canvasSize.width, canvasSize.height) * 0.17
                let start = point(from: center, toward: target, distance: centerRadius)
                let end = point(from: target, toward: center, distance: brandRadius)
                let tip = CGPoint(
                    x: start.x + (end.x - start.x) * progress,
                    y: start.y + (end.y - start.y) * progress
                )
                var path = Path()
                path.move(to: start)
                path.addLine(to: tip)
                context.stroke(
                    path,
                    with: .linearGradient(
                        Gradient(colors: [
                            Color(red: 0.86, green: 0.22, blue: 0.16),
                            Color.white
                        ]),
                        startPoint: start,
                        endPoint: tip
                    ),
                    style: StrokeStyle(lineWidth: 2.5, lineCap: .round)
                )
            }
        }
        .allowsHitTesting(false)
        .accessibilityHidden(true)
    }

    private func point(from origin: CGPoint, toward target: CGPoint, distance: CGFloat) -> CGPoint {
        let dx = target.x - origin.x
        let dy = target.y - origin.y
        let length = max(1, hypot(dx, dy))
        return CGPoint(x: origin.x + dx / length * distance, y: origin.y + dy / length * distance)
    }
}
