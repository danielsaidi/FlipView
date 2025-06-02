// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "FlipKit",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "FlipKit",
            targets: ["FlipKit"]
        )
    ],
    targets: [
        .target(
            name: "FlipKit"
        ),
        .testTarget(
            name: "FlipKitTests",
            dependencies: ["FlipKit"]
        )
    ]
)
