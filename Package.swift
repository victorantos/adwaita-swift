// swift-tools-version: 6.0
//
//  Package.swift
//  Adwaita
//
//  Created by david-swift on 08.06.23.
//

import PackageDescription

/// The Adwaita package.
let package = Package(
    name: "Adwaita",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
    products: [
        .library(
            name: "Adwaita",
            targets: ["Adwaita"]
        ),
        .library(
            name: "CAdw",
            targets: ["CAdw"]
        )
    ],
    dependencies: [
        .package(url: "https://git.aparoksha.dev/aparoksha/meta", branch: "main"),
        .package(url: "https://git.aparoksha.dev/aparoksha/meta-sqlite", branch: "main"),
        .package(
            url: "https://git.aparoksha.dev/aparoksha/levenshtein-transformations",
            from: "0.1.1"
        ),
        .package(url: "https://github.com/CoreOffice/XMLCoder", from: "0.17.1")
    ],
    targets: [
        .systemLibrary(
            name: "CAdw",
            pkgConfig: "libadwaita-1"
        ),
        .target(
            name: "Adwaita",
            dependencies: [
                "CAdw",
                .product(name: "LevenshteinTransformations", package: "levenshtein-transformations"),
                .product(name: "Meta", package: "meta"),
                .product(name: "MetaSQLite", package: "meta-sqlite")
            ]
        ),
        .executableTarget(
            name: "Generation",
            dependencies: [
                .product(name: "XMLCoder", package: "XMLCoder")
            ]
        ),
        .executableTarget(
            name: "Demo",
            dependencies: ["Adwaita"]
        )
    ],
    swiftLanguageModes: [.v5]
)
