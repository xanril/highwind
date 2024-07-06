// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HighwindLibrary",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_13),
        .tvOS(.v13),
        .watchOS(.v4),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "HighwindLibrary",
            targets: [
                "HighwindLibrary",
                "DigitalAPIClient",
                "HWDBusinessModels",
                "HWDDataServiceProtocols",
                "HWDDataServices",
                "HWDControllerProtocols",
                "HWDControllers"]),
    ],
    dependencies: [
        .package(url: "https://github.com/hmlongco/Factory.git", from: "2.3.1"),
        .package(name: "OpenAPIRuntime", url: "https://github.com/apple/swift-openapi-runtime", .upToNextMajor(from: "1.3.2")),
        .package(name: "OpenAPIURLSession", url: "https://github.com/apple/swift-openapi-urlsession", .upToNextMajor(from: "1.0.1"))],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "HighwindLibrary",
            dependencies: ["Factory", "HWDDataServiceProtocols", "HWDDataServices", "HWDControllerProtocols", "HWDControllers"]),
        .target(
            name: "DigitalAPIClient",
            dependencies: ["OpenAPIRuntime", "OpenAPIURLSession"]),
        .target(
            name: "HWDBusinessModels",
            dependencies: []),
        .target(
            name: "HWDDataServiceProtocols",
            dependencies: ["HWDBusinessModels", "HWDBusinessModels", "DigitalAPIClient"]),
        .target(
            name: "HWDDataServices",
            dependencies: ["HWDDataServiceProtocols"]),
        .target(
            name: "HWDControllerProtocols",
            dependencies: ["HWDDataServiceProtocols", "HWDDataServiceProtocols", "HWDBusinessModels"]),
        .target(
            name: "HWDControllers",
            dependencies: ["HWDControllerProtocols"]),
        .testTarget(
            name: "HighwindLibraryTests",
            dependencies: ["HighwindLibrary"]),
    ]
)
