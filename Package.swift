// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JSONparse",
    platforms: [
        .macOS(.v10_15), .iOS(.v13)
       ],
    products: [
    .executable(
        name: "jsonparse",
        targets: ["JSONparse"]),
        .library(
            name: "JSONparse",
            targets: ["JSONparseCore"])
    ],
    dependencies: [
        .package(url: "https://github.com/JohnSundell/Files",
                 from: "4.0.0"),
        .package(url: "https://github.com/onevcat/Rainbow",
                 from: "3.0.0"),
        .package(
            url: "https://github.com/apple/swift-argument-parser",
                 from: "0.0.2")
    ],
    targets: [
        .target(
            name: "JSONparse",
            dependencies: ["JSONparseCore", .product(name: "ArgumentParser", package: "swift-argument-parser")]),
        .target(
            name: "JSONparseCore",
            dependencies: ["Files", "Rainbow"]),
        .testTarget(
            name: "JSONparseTests",
            dependencies: ["JSONparse"]),
    ]
)
