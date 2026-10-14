// swift-tools-version: 6.3;(experimentalCGen)
//
//  Package.swift
//  Adwaita
//
//  Created by david-swift on 08.06.23.
//

import PackageDescription

/// The dependencies, pinned by commit (this fork: reproducible builds, Flathub's offline sources). MetaSQLite and its
/// Linux SQLite copy are left out: the copy replaced the system SQLite for every package in the app (no FTS5), and the
/// app keeps its own database.
let dependencies: [Package.Dependency] = [
    .package(url: "https://git.aparoksha.dev/aparoksha/meta", revision: "4d274f3cd042cbc3cb2098838093c65097935349"),
    .package(
        url: "https://git.aparoksha.dev/aparoksha/levenshtein-transformations",
        revision: "06577a2c4c6419ed859e34a8fb7be87a3b8975da"
    ),
    .package(url: "https://github.com/CoreOffice/XMLCoder", exact: "0.18.2")
]

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
        .executableTarget(
            name: "WidgetGeneration",
            dependencies: [
                .product(name: "XMLCoder", package: "XMLCoder")
            ],
            swiftSettings: [.defaultIsolation(MainActor.self)]
        ),
        .plugin(
            name: "GenerateAPINotes",
            capability: .buildTool(),
            dependencies: ["WidgetGeneration"],
            path: "Sources/PluginNotes"
        ),
        .target(
            name: "CAdw",
            dependencies: ["CAdwLib"],
            resources: [
                .process("include/apinotes.txt"),
                .process("include/module.txt"),
                .process("include/adwshim.h")
            ],
            plugins: ["GenerateAPINotes"]
        ),
        .plugin(
            name: "GenerateWidgets",
            capability: .buildTool(),
            dependencies: ["WidgetGeneration"],
            path: "Sources/Plugin"
        ),
        .target(
            name: "Adwaita",
            dependencies: [
                "CAdw",
                .product(name: "LevenshteinTransformations", package: "levenshtein-transformations"),
                .product(name: "Meta", package: "meta")
            ],
            swiftSettings: [.defaultIsolation(MainActor.self)],
            plugins: ["GenerateWidgets"],
        ),
        .executableTarget(
            name: "Demo",
            dependencies: ["Adwaita"],
            swiftSettings: [.defaultIsolation(MainActor.self)]
        ),
        .testTarget(
            name: "AdwaitaTests",
            dependencies: ["Adwaita"],
            swiftSettings: [.defaultIsolation(MainActor.self)]
        )
    ]
)
