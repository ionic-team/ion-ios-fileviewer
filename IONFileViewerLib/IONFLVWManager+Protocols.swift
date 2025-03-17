import Foundation

public protocol IONFLVWOpenDocumentManager {
    func openDocumentFromLocalPath(filePath: String, completion: @escaping (() -> Void )) throws
    func openDocumentFromResources(assetPath: String, completion: @escaping (() -> Void )) throws
    func openDocumentFromURL(url: String, completion: @escaping ((IONFLVWError?) -> Void )) throws
}

public protocol IONFLVWPreviewMediaManager {
    func previewMediaContentFromLocalPath(filePath: String) throws
    func previewMediaContentFromResources(assetPath: String) throws
    func previewMediaContentFromUrl(url: String) throws
}

struct IONFLVWFileResult {
    var name: String?
    var destinationUrl: URL?
}

typealias IONFLVWCompletionHandler = () throws -> Void
typealias IONFLVWURLCompletionHandler = () throws -> IONFLVWFileResult
