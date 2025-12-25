// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TalsecRuntime",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(
            name: "TalsecRuntime",
            targets: ["TalsecRuntime"]
        )
    ],
    targets: [
        .binaryTarget(
              name: "TalsecRuntime",
              path: "Talsec/TalsecRuntime.xcframework"
        )
    ]
)

