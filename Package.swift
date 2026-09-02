// swift-tools-version: 6.3
//
//  Package.swift
//  Adwaita
//
//  Created by david-swift on 08.06.23.
//

import PackageDescription

/// The dependencies.
var dependencies: [Package.Dependency] = [
    .package(url: "https://git.aparoksha.dev/aparoksha/meta", branch: "main"),
    .package(url: "https://git.aparoksha.dev/aparoksha/meta-sqlite", branch: "main"),
    .package(
        url: "https://git.aparoksha.dev/aparoksha/levenshtein-transformations",
        branch: "main"
    ),
    .package(url: "https://github.com/CoreOffice/XMLCoder", from: "0.17.1")
]

#if os(Linux)
dependencies.append(.package(url: "https://github.com/stephencelis/CSQLite", from: "3.50.4"))
#endif

/// The Adwaita package.
let package = Package(
    name: "Adwaita",
    platforms: [.macOS(.v13), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
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
    traits: [.trait(name: "exposeGeneratedAppearUpdateFunctions")],
    dependencies: dependencies,
    targets: [
        .systemLibrary(
            name: "CAdwLib",
            pkgConfig: "libadwaita-1"
        ),
        .target(
            name: "CAdw",
            dependencies: ["CAdwLib"]
        ),
        .target(
            name: "Adwaita",
            dependencies: [
                "CAdw",
                .product(name: "LevenshteinTransformations", package: "levenshtein-transformations"),
                .product(name: "Meta", package: "meta"),
                .product(name: "MetaSQLite", package: "meta-sqlite")
            ],
            swiftSettings: [.defaultIsolation(MainActor.self)]
        ),
        .executableTarget(
            name: "Generation",
            dependencies: [
                .product(name: "XMLCoder", package: "XMLCoder")
            ],
            swiftSettings: [.defaultIsolation(MainActor.self)]
        ),
        .executableTarget(
            name: "Demo",
            dependencies: ["Adwaita"],
            swiftSettings: [.defaultIsolation(MainActor.self)]
        )
    ]
)
