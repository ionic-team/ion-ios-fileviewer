import Foundation

class IONFLVWFileDownloader {

    static func downloadFile(url: URL, completion: @escaping (_ success: Bool, _ inner: IONFLVWURLCompletionHandler) -> Void) {
        URLSession.shared.downloadTask(with: url, completionHandler: { (location, response, error) in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                  let tempLocation = location, error == nil else {
                completion(false, { throw IONFLVWError.downloadFailed })
                return
            }

            guard let resolvedFileName = fileName(forRequestUrl: url, response: response) else {
                completion(false, { throw IONFLVWError.missingFileExtension })
                return
            }

            let destinationUrl = uniqueDestinationURL(forFileName: resolvedFileName)
            let fileResult = IONFLVWFileResult(name: resolvedFileName, destinationUrl: destinationUrl)

            do {
                try FileManager.default.moveItem(at: tempLocation, to: destinationUrl)
                completion(true, { return fileResult })
            } catch {
                completion(false, { throw IONFLVWError.downloadFailed })
            }
        }).resume()
    }

    /// The request URL's own path doesn't always carry the real file name/extension - e.g. CDN or
    /// image-proxy URLs (`.../image?url=%2Fpath%2Fto%2Ffile.png`) embed it inside a query parameter
    /// instead. When that's the case, fall back to what the server tells us about the downloaded
    /// content (`Content-Disposition`, or a MIME-type-based guess) via `URLResponse.suggestedFilename`.
    private static func fileName(forRequestUrl url: URL, response: URLResponse?) -> String? {
        if !url.pathExtension.isEmpty {
            return url.deletingPathExtension().lastPathComponent + "." + url.pathExtension
        }
        guard let suggested = response?.suggestedFilename,
              !(suggested as NSString).pathExtension.isEmpty else {
            return nil
        }
        return suggested
    }

    private static func uniqueDestinationURL(forFileName fileName: String) -> URL {
        let fileExtension = (fileName as NSString).pathExtension
        let baseName = (fileName as NSString).deletingPathExtension
        return FileManager.default.temporaryDirectory
            .appendingPathComponent(baseName + UUID().uuidString)
            .appendingPathExtension(fileExtension)
    }
}
