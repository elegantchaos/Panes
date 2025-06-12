// swift-tools-version: 6.2

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
      ],
      
      swiftSettings: [
//        .treatAllWarnings(as: .error),
        .swiftLanguageMode(.v6)
      ]
    ),

    .testTarget(
      name: "PanesCoreTests",
      dependencies: ["PanesCore"]
    ),
  ]
)
