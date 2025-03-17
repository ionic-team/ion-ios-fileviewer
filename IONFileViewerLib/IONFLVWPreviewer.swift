import Foundation
import QuickLook
import AVKit

class IONFLVWPreviewer: QLPreviewControllerDataSource {
    
    lazy var previewItem = NSURL()
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func previewMediaContent(url: URL) throws {
        let player = AVPlayer(url: url.standardized)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        viewController?.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }

    // MARK: - QLPreviewController DataSource
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return self.previewItem as QLPreviewItem
    }
}
