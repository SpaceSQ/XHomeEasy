// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "XHomeEasyEngines",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        .library(name: "XHomeEasyEngines", targets: ["XHomeEasyEngines"]),
    ],
    targets: [
        .target(name: "XHomeEasyEngines"),
        .testTarget(name: "XHomeEasyEnginesTests", dependencies: ["XHomeEasyEngines"]),
    ]
)
