// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "WindowSceneKit",
    platforms: [
        .macOS(.v14),
    ],
    products: [
        .library(
            name: "WindowSceneKit",
            targets: ["WindowSceneKit"]
        ),
    ],
    targets: [
        .target(
            name: "WindowSceneKit",
            swiftSettings: [
                .enableUpcomingFeature("ExistentialAny"),
            ]
        ),
    ]
)
