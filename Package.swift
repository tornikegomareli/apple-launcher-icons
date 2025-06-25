// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppleLauncherIcons",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "apple-launcher-icons", targets: ["AppleLauncherIcons"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.3.0"),
    ],
    targets: [
        .executableTarget(
            name: "AppleLauncherIcons",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .testTarget(
            name: "AppleLauncherIconsTests",
            dependencies: ["AppleLauncherIcons"]
        ),
    ]
)