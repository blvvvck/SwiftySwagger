// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "SwiftySwagger",
    platforms: [
       .macOS(.v10_12)
    ],
    products: [
        .executable(name: "swiftyswagger", targets: ["SwiftySwagger"]),
        .library(name: "SwiftySwaggerTools", targets: ["SwiftySwaggerTools"]),
    ],
    dependencies: [
        .package(url: "https://github.com/jpsim/Yams.git", from: "2.0.0"),
        .package(url: "https://github.com/jakeheis/SwiftCLI", from: "6.0.0"),
        .package(url: "https://github.com/onevcat/Rainbow.git", from: "3.0.0"),
        .package(url: "https://github.com/kylef/PathKit.git", from: "0.9.2"),
        .package(url: "https://github.com/kylef/Stencil.git", from: "0.13.0"),
        .package(url: "https://github.com/SwiftGen/StencilSwiftKit.git", from: "2.7.2")
    ],
    targets: [
        .target(
            name: "SwiftySwagger",
            dependencies: [
                "Yams",
                "SwiftCLI",
                "Rainbow",
                "PathKit",
                "Stencil",
                "StencilSwiftKit",
                "SwiftySwaggerTools"
            ],
            path: "Sources/SwiftySwagger"
        ),
        .target(
            name: "SwiftySwaggerTools",
            dependencies: [
                "SwiftCLI",
                "PathKit"
            ],
            path: "Sources/Tools"
        ),
        .testTarget(
            name: "ArmatureTests",
            dependencies: ["SwiftySwagger"],
            path: "Tests/ArmatureTests"
        ),
        .testTarget(
            name: "ArmatureToolsTests",
            dependencies: ["SwiftySwaggerTools"],
            path: "Tests/ArmatureToolsTests"
        )
    ]
)
