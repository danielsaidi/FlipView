// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "FlipView",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "FlipView",
            targets: ["FlipView"]
        )
    ],
    targets: [
        .target(
            name: "FlipView"
        ),
        .testTarget(
            name: "FlipViewTests",
            dependencies: ["FlipView"]
        )
    ]
)
