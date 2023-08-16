// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "CalendarFeature", targets: ["CalendarFeature"])
    ],
    dependencies: [
        .package(path: "Core"),
        .package(path: "DesignSystem"),
    ],
    targets: [
        .target(
            name: "CalendarFeature",
            dependencies: [
                .product(name: "Core", package: "Core"),
                .product(name: "DesignSystem", package: "DesignSystem"),
            ]
        ),
        .testTarget(
            name: "FeaturesTests",
            dependencies: ["CalendarFeature"]
        ),
    ]
)
