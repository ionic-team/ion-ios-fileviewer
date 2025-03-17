import UIKit

class IONFLVWDocumentOpener: NSObject, UIDocumentInteractionControllerDelegate {
    
    var documentInteractionController: UIDocumentInteractionController?
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func openDocumentFromUrl(url: URL, completion: @escaping (_ inner: IONFLVWCompletionHandler) -> Void) {
        IONFLVWFileDownloader.downloadFile(url: url, completion: { (_, inner: IONFLVWURLCompletionHandler) in
            do {
                let result = try inner()
                DispatchQueue.main.async {
                    self.documentInteractionController = IONFLVWDocumentInteractor {
                        completion({})
                    }
                    self.documentInteractionController?.delegate = self
                    self.documentInteractionController?.url = result.destinationUrl
                    if let urlStr = result.destinationUrl?.standardized {
                        self.documentInteractionController?.uti = urlStr.uti
                    }
                    self.documentInteractionController?.name = result.name
                    self.documentInteractionController?.presentPreview(animated: true)
                }
            } catch let error {
                DispatchQueue.main.async { completion({ throw error }) }
            }
        })
    }
    
    func openDocumentFromLocalPath(filePath: URL, completion: @escaping () -> Void) throws {
        self.documentInteractionController = IONFLVWDocumentInteractor {
            completion()
        }
        self.documentInteractionController?.delegate = self
        self.documentInteractionController?.url = filePath.standardized
        self.documentInteractionController?.presentPreview(animated: true)
    }
    
    // MARK: - UIDocumentInteractionControllerDelegate
        
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self.viewController!
    }
}

fileprivate extension URL {
    var uti: String {
        return (try? self.resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier ?? "public.data"
    }
}

class IONFLVWDocumentInteractor: UIDocumentInteractionController {

    var previewFinished: (() -> Void)
    
    init(presentationFinished: @escaping () -> Void) {
        self.previewFinished = presentationFinished
    }
    
    deinit {
        self.previewFinished()
    }
    
}
