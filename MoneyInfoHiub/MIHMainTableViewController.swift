import UIKit

class MIHMainTableViewController: UITableViewController, MIHAPIManagerDelegate {
	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.backgroundColor = UIColor.white
		self.tableView.backgroundView = UIView()
		self.tableView.backgroundView?.backgroundColor = UIColor.white
		self.tableView.separatorStyle = .none
		self.title = "Money Info Hub"
		self.tableView.register(MIHCardTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
		MIHAPIManager.shared.delegate = self
		MIHAPIManager.shared.update()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	// MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return MIHAPIManager.shared.cards.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
		cell.selectionStyle = .none
		let card = MIHAPIManager.shared.cards[indexPath.row]
		if let cell = cell as? MIHCardTableViewCell {
			cell.card = card
		}
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let controller = MIHWebViewController()
		let card = MIHAPIManager.shared.cards[indexPath.row]
		controller.linkURL = card.linkURL
		controller.title = card.title
		self.navigationController?.pushViewController(controller, animated: true)
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return tableView.bounds.width + 50
	}

	// MARK: - MIHAPIManagerDelegate

	func APIManager(_ APIManager: MIHAPIManager, didFailUpdateWithError error: Error) {
	}

	func APIManagerDidUpdate(_ APIManager: MIHAPIManager) {
		self.tableView.reloadData()
	}
}
