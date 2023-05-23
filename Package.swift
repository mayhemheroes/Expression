// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Expression",
    products: [
        .library(name: "Expression", targets: ["Expression"]),
        .executable(name: "ExpressionFuzz", targets: ["ExpressionFuzz"]),
    ],
    targets: [
        .target(name: "Expression", path: "Sources"),
        .target(
            name: "ExpressionFuzz",
            dependencies: ["Expression"],
            path: "mayhem",
            sources: ["main.swift", "FuzzedDataProvider.swift"],
            swiftSettings: [
                .unsafeFlags(["-sanitize=fuzzer,address"]),
                .unsafeFlags(["-parse-as-library"])
            ],
            linkerSettings: [
                .unsafeFlags(["-sanitize=fuzzer,address"])
            ]),
        .testTarget(name: "ExpressionTests", dependencies: ["Expression"], path: "Tests"),
    ]
)