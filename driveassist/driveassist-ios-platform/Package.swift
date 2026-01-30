// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DriveAssist",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "DriveAssistCore", targets: ["DriveAssistCore"]),
        .library(name: "DriveAssistSensors", targets: ["DriveAssistSensors"]),
        .library(name: "DriveAssistLocation", targets: ["DriveAssistLocation"]),
        .library(name: "DriveAssistOBD", targets: ["DriveAssistOBD"]),
        .library(name: "DriveAssistUI", targets: ["DriveAssistUI"]),
        .library(name: "DriveAssistDesign", targets: ["DriveAssistDesign"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "DriveAssistCore"),
        .testTarget(
            name: "DriveAssistCoreTests",
            dependencies: ["DriveAssistCore"]),

        .target(
            name: "DriveAssistDesign"),

        .target(
            name: "DriveAssistSensors",
            dependencies: ["DriveAssistCore"]),
        .testTarget(
            name: "DriveAssistSensorsTests",
            dependencies: ["DriveAssistSensors"]),

        .target(
            name: "DriveAssistLocation",
            dependencies: ["DriveAssistCore"]),
        .testTarget(
            name: "DriveAssistLocationTests",
            dependencies: ["DriveAssistLocation"]),

        .target(
            name: "DriveAssistOBD",
            dependencies: ["DriveAssistCore"]),
        .testTarget(
            name: "DriveAssistOBDTests",
            dependencies: ["DriveAssistOBD"]),

        .target(
            name: "DriveAssistUI",
            dependencies: [
                "DriveAssistCore",
                "DriveAssistSensors",
                "DriveAssistLocation",
                "DriveAssistOBD",
                "DriveAssistDesign"
            ]),
    ]
)
