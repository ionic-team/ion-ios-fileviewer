import Foundation

class IONFLVWFileDownloader {
    
    static func downloadFile(url: URL, completion: @escaping (_ success: Bool, _ inner: IONFLVWURLCompletionHandler) -> Void) {
        let documentsDirectoryURL = FileManager.default.temporaryDirectory
        let fileExtension = url.pathExtension
        let fileName = url.deletingPathExtension().lastPathComponent
        let destinationUrl = documentsDirectoryURL
            .appendingPathComponent(fileName + UUID().uuidString)
            .appendingPathExtension(fileExtension)
    
        let fileResult = IONFLVWFileResult(name: fileName + "." + url.pathExtension, destinationUrl: destinationUrl)
        
        if FileManager.default.fileExists(atPath: destinationUrl.path) {
            completion(true, { return fileResult })
            return
        }
        URLSession.shared.downloadTask(with: url, completionHandler: { (location, response, error) in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                guard let tempLocation = location, error == nil else { return }
                do {
                    try FileManager.default.moveItem(at: tempLocation, to: destinationUrl)
                    completion(true, { return fileResult })
                } catch {
                    completion(false, { throw IONFLVWError.downloadFailed })
                }
            } else {
                completion(false, { throw IONFLVWError.downloadFailed })
            }
        }).resume()
    }
}
