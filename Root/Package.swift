// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Root",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
    ],
    products: [
        .library(name: "Root", targets: ["Root"]),
    ],
    dependencies: [
        .package(url: "https://github.com/YusukeHosonuma/SFReadableSymbols.git", from: "1.0.0"),
        .package(url: "https://github.com/YusukeHosonuma/SwiftUICommon.git", from: "0.1.0"),
    ],
    targets: [
        .target(
            name: "Root",
            dependencies: [
                "SFReadableSymbols",
                "SwiftUICommon",
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(name: "RootTests", dependencies: ["Root"]),
    ]
)
