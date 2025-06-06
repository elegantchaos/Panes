// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "PanesCore",

  platforms: [.macOS(.v15)],

  products: [
    .library(
      name: "PanesCore",
      targets: ["PanesCore"]
    )
  ],

  dependencies: [
    .package(url: "https://github.com/elegantchaos/Logger", branch: "swift6-manager-events"),
    .package(url: "https://github.com/stevengharris/SplitView", from: "1.1.1"),
  ],

  targets: [
    .target(
      name: "PanesCore",
      dependencies: [
        .product(name: "SplitView", package: "SplitView"),
        .product(name: "Logger", package: "Logger"),
        .product(name: "LoggerUI", package: "Logger"),
      ]
    ),

    .testTarget(
      name: "PanesCoreTests",
      dependencies: ["PanesCore"]
    ),
  ]
)
