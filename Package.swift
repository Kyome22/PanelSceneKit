// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "PanelSceneKit",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "PanelSceneKit",
            targets: ["PanelSceneKit"]
        ),
    ],
    targets: [
        .target(
            name: "PanelSceneKit",
            swiftSettings: [
                .enableUpcomingFeature("ExistentialAny"),
            ]
        ),
    ]
)
