// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VexSwift",
    products: [
        .executable(name: "VexSwift", targets: ["VexSwift"])
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "VexSwift",
            swiftSettings: [
                .enableExperimentalFeature("Embedded"),
                .unsafeFlags([
                    "-whole-module-optimization",
                    "-target", "armv7a-none-eabi",
                    "-Xfrontend", "-disable-objc-interop",
                    "-Xfrontend", "-disable-stack-protector",
                    "-Xfrontend", "-function-sections",
                    "-Xfrontend", "-gline-tables-only",
                    "-Xfrontend", "-experimental-platform-c-calling-convention=arm_aapcs",
                    "-Xlinker", "-Tv5.ld",
                    "-Xlinker", "-nostdlib",
                    "-Xlinker", "--gc-section",
                    "-Xcc", "-fshort-enums",
                    "-Xcc", "-march=armv7-a",
                    "-Xcc", "-mfpu=neon",
                    "-Xcc", "-mfloat-abi=softfp",
                    "-Xcc", "-ffunction-sections",
                    "-Xcc", "-fdata-sections",
                ])
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)
