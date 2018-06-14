// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "NetJob",
    products: [
        .library(
            name: "NetJob",
            targets: ["NetJob"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "NetJob",
            dependencies: []),
        .testTarget(
            name: "NetJobTests",
            dependencies: ["NetJob"]),
    ]
)
