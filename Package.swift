// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VexSwiftApp",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .executable(
            name: "VexSwiftApp",
            targets: ["VexSwiftApp"]
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "VexSwiftApp",
            dependencies: [
                "VexV5"
            ]
        ),
        .target(
            name: "VexV5",
            dependencies: [
                "VexV5Startup",
                "VexSdk",
            ]),
        .target(name: "VexSdk"),
        .target(name: "VexV5Startup"),
    ]
)
