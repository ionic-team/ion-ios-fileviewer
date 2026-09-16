# [2.0.0](https://github.com/ionic-team/ion-ios-fileviewer/compare/1.0.4...2.0.0) (2026-09-16)


### Features

* bump minimum deployment target to iOS 15 ([#15](https://github.com/ionic-team/ion-ios-fileviewer/issues/15)) ([bec3795](https://github.com/ionic-team/ion-ios-fileviewer/commit/bec37953414664cce4035b16846ce14020807e4f))


### BREAKING CHANGES

* the minimum supported iOS version is now 15.0. Apps
with a deployment target of iOS 14 can no longer consume this library.

## [1.0.4](https://github.com/ionic-team/ion-ios-fileviewer/compare/1.0.3...1.0.4) (2026-08-28)


### Bug Fixes

* openDocumentFromUrl when extension is unresolvable ([#14](https://github.com/ionic-team/ion-ios-fileviewer/issues/14)) ([c08b4da](https://github.com/ionic-team/ion-ios-fileviewer/commit/c08b4da370fc56c3bae4ec5e6038c20bd951bbbc))
* use Xcode to 16.4 instead of 26 ([#13](https://github.com/ionic-team/ion-ios-fileviewer/issues/13)) ([2f1fe06](https://github.com/ionic-team/ion-ios-fileviewer/commit/2f1fe061261452f2e23e1e15e63e4c86ca290809))

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
