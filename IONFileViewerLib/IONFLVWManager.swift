import Foundation
import UIKit

public class IONFLVWManager {
    private let fileManager: FileManager
    weak var rootViewController: UIViewController?

    public init(viewController: UIViewController, fileManager: FileManager = .default) {
        self.rootViewController = viewController
        self.fileManager = fileManager
    }
}

extension IONFLVWManager: IONFLVWOpenDocumentManager {
    public func openDocumentFromLocalPath(filePath: String, completion: @escaping (() -> Void)) throws {
        guard !filePath.isEmpty else {
            throw IONFLVWError.emptyFilePath
        }
        let filePathToUse = replaceDuplicateSlashes(fromLocalPath: filePath)
        guard let file = URL(string: filePathToUse) else { throw IONFLVWError.couldNotOpenDocument }
        guard !file.pathExtension.isEmpty else { throw IONFLVWError.missingFileExtension }
        guard fileManager.fileExists(atPath: file.path) else { throw IONFLVWError.fileDoesNotExist(atPath: filePathToUse) }
        
        openDocumentFromLocalPath(file, completion)
    }
    
    public func openDocumentFromResources(assetPath: String, completion: @escaping (() -> Void)) throws {
        let url = try getResourceURL(assetPath)
        
        openDocumentFromLocalPath(url, completion)
    }
    
    public func openDocumentFromUrl(url: String, completion: @escaping ((IONFLVWError?) -> Void)) throws {
        guard !url.isEmpty else { throw IONFLVWError.invalidEmptyURL }
        guard url.isValidUrl(), let fileUrl = URL(string: url.replacingOccurrences(of: " ", with: "%20")) else {
            throw IONFLVWError.invalidURL(forUrl: url)
        }
        
        guard let viewController = rootViewController else { return }
        let fileViewerOpenDocument = IONFLVWDocumentOpener(viewController: viewController)
        fileViewerOpenDocument.openDocumentFromUrl(url: fileUrl, completion: { (inner: IONFLVWCompletionHandler) in
            do {
                try inner()
                completion(nil)
            } catch {
                completion((error as? IONFLVWError) ?? .couldNotOpenDocument)
            }
        })
    }
    
    private func openDocumentFromLocalPath(_ url: URL, _ completion: @escaping (() -> Void)) {
        guard let viewController = rootViewController else { return }
        let fileViewerOpenDocument = IONFLVWDocumentOpener(viewController: viewController)
        fileViewerOpenDocument.openDocumentFromLocalPath(filePath: url) {
            completion()
        }
    }
}

extension IONFLVWManager: IONFLVWPreviewMediaManager {
    public func previewMediaContentFromLocalPath(filePath: String) throws {
        guard !filePath.isEmpty else { throw IONFLVWError.emptyFilePath }
        let filePathToUse = replaceDuplicateSlashes(fromLocalPath: filePath)
        guard let file = URL(string: filePathToUse) else { throw IONFLVWError.couldNotOpenDocument }
        guard fileManager.fileExists(atPath: file.path) else { throw IONFLVWError.fileDoesNotExist(atPath: filePathToUse) }
        
        previewMediaContent(file)
    }
    
    public func previewMediaContentFromResources(assetPath: String) throws {
        let url = try getResourceURL(assetPath)
        
        previewMediaContent(url)
    }
    
    public func previewMediaContentFromUrl(url: String) throws {
        guard !url.isEmpty else { throw IONFLVWError.invalidEmptyURL }
        guard url.isValidUrl(), let fileUrl = URL(string: url) else { throw IONFLVWError.invalidURL(forUrl: url) }
        
        previewMediaContent(fileUrl)
    }
    
    private func previewMediaContent(_ url: URL) {
        guard let viewController = rootViewController else { return }
        let fileViewerPreview = IONFLVWPreviewer(viewController: viewController)
        fileViewerPreview.previewMediaContent(url: url)
    }
}

private extension IONFLVWManager {
    func getResourceURL(_ path: String) throws -> URL {
        guard !path.isEmpty, let URLfromPath = URL(string: path) else { throw IONFLVWError.emptyFilePath }
        
        let fileNameAndExt = URLfromPath.lastPathComponent.split(separator: ".").map { String($0) }
        guard fileNameAndExt.count > 1 else { throw IONFLVWError.missingFileExtension }
        
        let subdirectory = URLfromPath.pathComponents.count > 1
                ? URLfromPath.deletingLastPathComponent().path
                : nil
        
        guard let resourcePath = Bundle.main.path(forResource: fileNameAndExt[0], ofType: fileNameAndExt[1], inDirectory: subdirectory) else {
            throw IONFLVWError.fileDoesNotExist(atPath: path)
        }
        guard fileManager.fileExists(atPath: resourcePath) else { throw IONFLVWError.fileDoesNotExist(atPath: path) }
        
        let resourceURL = URL(fileURLWithPath: resourcePath)
        return resourceURL
    }
    
    func replaceDuplicateSlashes(fromLocalPath path: String) -> String {
        // remove duplicate slashes '//', except for the ones indicating the scheme (e.g. 'file://')
        var pathWithoutDuplicateSeparators = path.replacingOccurrences(
            of: #"(?<!:)/{2,}(?!/)"#,
            with: "/",
            options: .regularExpression
        )
        if (path.contains(":///")) {
            // the regex may ommit a slash after ://, which is incorrect because it breaks in case of an absolute file path
            pathWithoutDuplicateSeparators = pathWithoutDuplicateSeparators.replacingOccurrences(of: "://", with: ":///")
        }
        return pathWithoutDuplicateSeparators
    }
}
