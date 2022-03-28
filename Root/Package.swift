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
    ],
    targets: [
        .target(name: "Root", dependencies: []),
        .testTarget(name: "RootTests", dependencies: ["Root"]),
    ]
)
