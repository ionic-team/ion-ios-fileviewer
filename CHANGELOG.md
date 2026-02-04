## 1.0.3

## Fixes

- Compatibility with Xcode 15 and 16.

## 1.0.2

**Note: This version has an issue in Xcode 15 and 16. Please use version 1.0.3**

### Fixes

- Opening local files without `file://`.

## 1.0.1

### Fixes

- Remove duplicate path separators that could cause files to not be found.

## 1.0.0

### Features
- Add implementation for opening files - `openDocumentFromLocalPath`, `openDocumentFromResources`, `openDocumentFromUrl`. 
- Add implementation for previewing media files - `previewMediaContentFromLocalPath`, `previewMediaContentFromResources`, `previewMediaContentFromUrl`.

### Chores
- Add dependency management contract file for CocoaPods and Swift Package Manager.
- Add GitHub Actions workflows.
- Create Repository
