// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Coordinator",
            targets: ["Coordinator"]),
        .library(
            name: "ExerciseCounter",
            targets: ["ExerciseCounter"]),
        .library(
            name: "Main",
            targets: ["Main"]),
        .library(
            name: "Root",
            targets: ["Root"]),
    ],
    dependencies: [
        .package(path: "../Domain")
    ],
    targets: [
        .target(
            name: "Coordinator",
            dependencies: [
                .product(name: "Domain", package: "Domain")
            ]
        ),
        .target(
            name: "ExerciseCounter",
            dependencies: [
                "Coordinator",
                .product(name: "Domain", package: "Domain")
            ]
        ),
        .target(
            name: "Main",
            dependencies: [
                "Coordinator",
                "ExerciseCounter",
                .product(name: "Domain", package: "Domain")
            ]
        ),
        .target(
            name: "Root",
            dependencies: [
                "Main",
                .product(name: "Domain", package: "Domain")
            ]
        )
    ]
)
