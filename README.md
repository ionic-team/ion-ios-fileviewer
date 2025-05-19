# ion-ios-fileviewer

A Swift library for iOS that allows opening files and previewing media files.

The library supports local files, app assets, and remote URLs.

## Requirements

- iOS 14.0+
- Swift 5.0+
- Xcode 15.0+

## Installation

### CocoaPods

`ion-ios-fileviewer` is available through [CocoaPods](https://cocoapods.org). Add this to your Podfile:

```ruby
pod 'IONFileViewerLib', '~> 1.0.2'  # Use the latest 1.0.x version
```

## Quick Start

This library is currently used by the File Viewer Plugin for OutSystems' [Cordova](https://github.com/ionic-team/cordova-outsystems-file-viewer) and [Capacitor](https://github.com/ionic-team/capacitor-file-viewer) plugins. Please check their usage for real use-case scenarios.

## Features

The library's features are divided into two protocols:

- `IONFLVWOpenDocumentManager`
- `IONFLVWPreviewMediaManager`

The `IONFLVWManager` implements both of these protocols. To instantiate the library, you can do the following:

```swift
// Declare the type alias if you want to use all operations;
// otherwise, use the specific protocol directly.
typealias FileViewerManager = any IONFLVWOpenDocumentManager & IONFLVWPreviewMediaManager

let fileManager: FileViewerManager = IONFLVWManager(viewController: viewController)
```

Where `viewController` is a `UIViewController` used to present the screens for viewing files; it is required for the library to function.

### `IONFLVWOpenDocumentManager` 

The `IONFLVWOpenDocumentManager` manages operations for opening files like PDFs, images, and videos. Apple's [Quick Look](http://developer.apple.com/documentation/quicklook) is used. It provides three operations:

- `openDocumentFromLocalPath` - Open a file at `filePath` stored in the local file system.
- `openDocumentFromResources` - Open a resource file of the app, using the relative path `assetPath`.
- `openDocumentFromUrl` - Download and open a file from a remote `url` (http[s]://...).

These methods can throw errors. See the [Error Handling](#error-handling) section for more information.

#### Example

To know when the user finishes viewing the file, use the `completion` closure. Note that for `openDocumentFromUrl`, `completion` may optionally receive an error in case something goes wrong while preparing the file to be opened (e.g., download failure).

Here’s an example of how to use `openDocumentFromUrl`:

```swift
import Foundation
import IONFileViewerLib

// Instantiate manager and url
do {
    try manager.openDocumentFromUrl(url: url, completion: { err in
        if let err = err {
            // Handle opening errors here
        } else {
            // Handle user finished opening file here
        }
    })
} catch {
    // Handle validation errors here
}
```

### `IONFLVWPreviewMediaManager`

The `IONFLVWPreviewMediaManager` allows previewing media files (namely videos) with an in-app media player. It provides three operations:

- `previewMediaContentFromLocalPath` - Preview the contents of a local media file at `filePath`.
- `previewMediaContentFromResources` - Preview the contents of an app resource media file, using the relative path `assetPath`.
- `previewMediaContentFromUrl` - Preview the contents of a media file stored at a remote `url` (http[s]://...).

These methods can throw errors. See the [Error Handling](#error-handling) section for more information.

## Error Handling

The library returns specific errors when there are issues viewing files. These are:

```swift
public enum IONFLVWError: LocalizedError, Equatable {
    case fileDoesNotExist(atPath: String)
    case emptyFilePath
    case couldNotOpenDocument
    case invalidURL(forUrl: String)
    case invalidEmptyURL
    case downloadFailed
    case missingFileExtension
}
```

## Contributing

1. Fork the repository (make sure "Copy only `main` branch" is unchecked).
2. Checkout the development branch (`git switch development`).
3. Create your feature branch (`git checkout -b feature/amazing-feature`).
4. Commit your changes (`git commit -m 'Add amazing feature'`).
5. Push to your branch (`git push origin feature/amazing-feature`).
6. Open a Pull Request to `development` branch.

## License

`ion-ios-fileviewer` is available under the MIT license. See the [LICENSE](LICENSE) file for more information.

## Support

- Report issues on our [Issue Tracker](https://github.com/ionic-team/ion-ios-fileviewer/issues)
