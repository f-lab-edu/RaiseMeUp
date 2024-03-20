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
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Coordinator",
            dependencies: [
                "Main",
                "Root",
                "ExerciseCounter",
                .product(name: "Data", package: "Data")
            ]
        )
        .target(
            name: "Main",
            dependencies: [
                "Main",
                "Root",
                "ExerciseCounter",
                .product(name: "Data", package: "Data")
            ]
        )
        
    ]
)
