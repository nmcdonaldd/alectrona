//
//  Package.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 12/26/20.
//

import PackageDescription

let package = Package(
    name: "DeckOfPlayingCards",
    products: [
        .executable(name: "Alectrona", targets: ["Alectrona"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/example-package-fisheryates.git", from: "2.0.0"),
        .package(url: "https://github.com/apple/example-package-playingcard.git", from: "3.0.0"),
    ],
    targets: [
        .target(
            name: "DeckOfPlayingCards",
            dependencies: ["FisherYates", "PlayingCard"]),
        .testTarget(
            name: "DeckOfPlayingCardsTests",
            dependencies: ["DeckOfPlayingCards"]),
    ]
)
