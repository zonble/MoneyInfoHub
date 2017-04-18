import UIKit

let APIEndPoint: URL! = URL(string: "http://www.3wyp.com/adjs/u95-tw/aditem.js")

protocol MIHAPIManagerDelegate {
	func APIManager(_ APIManager: MIHAPIManager, didFailUpdateWithError error: Error)
	func APIManagerDidUpdate(_ APIManager: MIHAPIManager)
}

struct MIHCard {
	var linkURL: URL?
	var title: String = ""
	var imageURL: URL?
	var imageWidth = 0
}

class MIHAPIManager: NSObject {
	static let shared = MIHAPIManager()
	var delegate: MIHAPIManagerDelegate?
	var cards = [MIHCard]()

	fileprivate var currentTask: URLSessionDataTask?

	func update() {
		currentTask?.cancel()
		currentTask = URLSession.shared.dataTask(with: APIEndPoint) { data, response, error in
			if let error = error {
				DispatchQueue.main.async {
					self.delegate?.APIManager(self, didFailUpdateWithError: error)
				}
				return
			}
			guard let data = data else {
				return
			}
			let text = String(data: data, encoding: String.Encoding.utf8)
			let pattern = "<a href=\"(.*)\" target=\"_blank\"><img alt=\"(.*)\" src=\"(.*)\" style=\"width: (.*)px;\" /></a>"

			var newCards = [MIHCard]()
			if let regEx = try? NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0)) {
				let matches = regEx.matches(in: text!, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, text!.characters.count))
				for match in matches {
					let link = (text! as NSString).substring(with: match.rangeAt(1))
					let linkURL = URL(string: link)
					let title = (text! as NSString).substring(with: match.rangeAt(2))
					let imageURLString = (text! as NSString).substring(with: match.rangeAt(3))
					let imageURL = URL(string: imageURLString)
					let imageWidthString = (text! as NSString).substring(with: match.rangeAt(4))
					let imageWitdh = Int(imageWidthString)
					var card = MIHCard()
					card.linkURL = linkURL
					card.title = title
					card.imageURL = imageURL
					card.imageWidth = imageWitdh ?? 0
					newCards.append(card)
				}
			}
			self.cards = newCards
			DispatchQueue.main.async {
				self.delegate?.APIManagerDidUpdate(self)
			}
		}
		currentTask?.resume()
	}

}
