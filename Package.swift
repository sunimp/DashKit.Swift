// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "DashKit",
    platforms: [
        .iOS(.v14),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "DashKit",
            targets: ["DashKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/attaswift/BigInt.git", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/groue/GRDB.swift.git", .upToNextMajor(from: "6.0.0")),
        .package(url: "https://github.com/sunimp/BitcoinCore.Swift.git", .upToNextMajor(from: "3.1.0")),
        .package(url: "https://github.com/sunimp/DashCrypto.Swift.git", .upToNextMajor(from: "1.0.3")),
        .package(url: "https://github.com/sunimp/HDWalletKit.Swift.git", .upToNextMajor(from: "1.3.5")),
        .package(url: "https://github.com/sunimp/WWToolKit.Swift.git", .upToNextMajor(from: "2.1.1")),
        .package(url: "https://github.com/sunimp/WWCryptoKit.Swift.git", .upToNextMajor(from: "1.3.5")),
        .package(url: "https://github.com/sunimp/WWExtensions.Swift.git", .upToNextMajor(from: "1.1.0")),
        .package(url: "https://github.com/nicklockwood/SwiftFormat.git", from: "0.54.0"),
    ],
    targets: [
        .target(
            name: "DashKit",
            dependencies: [
                "BigInt",
                .product(name: "GRDB", package: "GRDB.swift"),
                .product(name: "BitcoinCore", package: "BitcoinCore.Swift"),
                .product(name: "DashCrypto", package: "DashCrypto.Swift"),
                .product(name: "WWCryptoKit", package: "WWCryptoKit.Swift"),
                .product(name: "WWExtensions", package: "WWExtensions.Swift"),
                .product(name: "WWToolKit", package: "WWToolKit.Swift"),
                .product(name: "HDWalletKit", package: "HDWalletKit.Swift")
            ]
        ),
    ]
)
