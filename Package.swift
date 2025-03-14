// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "IONFileViewerLib",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "IONFileViewerLib",
            targets: ["IONFileViewerLib"]
        )
    ],
    targets: [
        .target(
            name: "IONFileViewerLib",
            path: "IONFileViewerLib"
        ),
        .testTarget(
            name: "IONFileViewerLibTests",
            dependencies: ["IONFileViewerLib"],
            path: "IONFileViewerLibTests"
        )
    ]
)
