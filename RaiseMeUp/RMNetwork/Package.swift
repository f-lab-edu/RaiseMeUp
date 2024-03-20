// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RMNetwork",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "RMNetwork",
            targets: ["RMNetwork"]
        )
    ],
    dependencies: [
        .package(path: "../Shared")
    ],
    targets: [
        .target(
            name: "RMNetwork",
            dependencies: [.product(name: "Shared", package: "Shared")]
        )
    ]
)
