import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		self.window = UIWindow(frame: UIScreen.main.bounds)
		let controller = MIHMainTableViewController(style: .grouped)
		let navController = UINavigationController(rootViewController: controller)
		self.window?.rootViewController = navController
		window?.makeKeyAndVisible()
		return true
	}

}

