import Foundation

public enum IONFLVWError: LocalizedError, Equatable {
    case fileDoesNotExist(atPath: String)
    case emptyFilePath
    case couldNotOpenDocument
    case invalidURL(forUrl: String)
    case invalidEmptyURL
    case downloadFailed
    case missingFileExtension
    
    public var errorDescription: String? {
        switch self {
        case .fileDoesNotExist(let path): "The file you are trying to open does not exist - \(path)"
        case .emptyFilePath: "No file path was provided"
        case .couldNotOpenDocument: "Could not open the document"
        case .invalidURL(let url): "The URL you are trying to open is malformed - \(url)"
        case .invalidEmptyURL: "The URL to open is either null or empty"
        case .downloadFailed: "The download failed"
        case .missingFileExtension: "The file has no extension"
        }
    }
}
