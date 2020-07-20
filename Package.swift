// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JSONtoCSV",
    platforms: [
        .macOS(.v10_15), .iOS(.v13)
       ],
    products: [
        .library(
            name: "JSONtoCSV",
            targets: ["JSONtoCSVcore"])
    ],
    dependencies: [
        .package(url: "https://github.com/JohnSundell/Files",
                 from: "4.0.0"),
        .package(url: "https://github.com/onevcat/Rainbow",
                 from: "3.0.0"),
    ],
    targets: [
        .target(
            name: "JSONtoCSV",
            dependencies: ["JSONtoCSVcore"]),
        .target(
            name: "JSONtoCSVcore",
            dependencies: ["Files", "Rainbow"]),
        .testTarget(
            name: "JSONtoCSVTests",
            dependencies: ["JSONtoCSV"]),
    ]
)
