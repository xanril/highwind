// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HighwindSkin",
    platforms: [
        .iOS(.v17),
        .macOS(.v10_13),
        .tvOS(.v13),
        .watchOS(.v4),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "HighwindSkin",
            targets: [
                "HighwindSkin",
                "HWDViewModelProtocols",
                "HWDViewModels",
                "HWDViews"]),
    ],
    dependencies: [
        .package(name: "HighwindLibrary", path: "../Libraries"),
        .package(url: "https://github.com/hmlongco/Factory.git", from: "2.3.1")],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "HighwindSkin",
            dependencies: ["Factory", "HighwindLibrary", "HWDViewModelProtocols", "HWDViewModels"]),
        .target(
            name: "HWDViewModelProtocols",
            dependencies: ["HighwindLibrary"]),
        .target(
            name: "HWDViewModels",
            dependencies: ["HWDViewModelProtocols", "Factory"]),
        .target(
            name: "HWDViews",
            dependencies: ["HWDViewModelProtocols", "Factory", "HighwindSkin"]),
        .testTarget(
            name: "HighwindSkinTests",
            dependencies: ["HighwindSkin"]),
    ]
)
