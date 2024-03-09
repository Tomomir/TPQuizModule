// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TPQuizModule",
    platforms: [
        .iOS("15.0"), // Set the minimum iOS deployment target to iOS 13.0
        // Other platforms can be specified similarly if needed, such as macOS, watchOS, and tvOS
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "TPQuizModule",
            targets: ["TPQuizModule"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "TPQuizModule",
            resources: [
                .copy("Quiz.storyboard")
            ]),
        .testTarget(
            name: "TPQuizModuleTests",
            dependencies: ["TPQuizModule"]),
    ]
)
