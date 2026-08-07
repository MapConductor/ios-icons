// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

let frameworkLibraryType: Product.Library.LibraryType? =
    ProcessInfo.processInfo.environment["MAPCONDUCTOR_BUILD_XCFRAMEWORK"] == "1" ? .dynamic : nil
let usingLocalCore = FileManager.default.fileExists(atPath: "../ios-sdk-core/Package.swift")
let coreDependency: Package.Dependency = usingLocalCore
    ? .package(path: "../ios-sdk-core")
    : .package(url: "https://github.com/MapConductor/ios-sdk-core", from: "1.0.0")

let package = Package(
    name: "mapconductor-icons",
    platforms: [
        // See ios-sdk-core/Package.swift's comment: "15.0" must not be used here.
        .iOS("15.1"),
    ],
    products: [
        .library(
            name: "MapConductorIcons",
            type: frameworkLibraryType,
            targets: ["MapConductorIcons"]
        ),
    ],
    dependencies: [
        coreDependency,
    ],
    targets: [
        .target(
            name: "MapConductorIcons",
            dependencies: [
                .product(name: "MapConductorCore", package: "ios-sdk-core"),
            ],
        ),
        .testTarget(
            name: "MapConductorIconsTests",
            dependencies: [
                "MapConductorIcons",
                .product(name: "MapConductorCore", package: "ios-sdk-core"),
            ],
        ),
    ]
)
