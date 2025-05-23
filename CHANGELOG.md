# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
