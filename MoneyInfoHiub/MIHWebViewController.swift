import UIKit
import WebKit

class MIHWebViewController: UIViewController {

	var webView = WKWebView()
	var linkURL:URL?

    override func viewDidLoad() {
        super.viewDidLoad()
		self.webView.frame = self.view.bounds
		self.webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		self.view.addSubview(self.webView)
		if let linkURL = self.linkURL {
			self.webView.load(URLRequest(url: linkURL))
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
