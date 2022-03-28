// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Root",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
    ],
    products: [
        .library(name: "Root", targets: ["Root"]),
    ],
    dependencies: [
        .package(url: "https://github.com/YusukeHosonuma/SFReadableSymbols.git", from: "1.0.0"),
    ],
    targets: [
        .target(name: "Root", dependencies: [
            "SFReadableSymbols",
        ]),
        .testTarget(name: "RootTests", dependencies: ["Root"]),
    ]
)
