
import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if let firstViewController = window?.rootViewController as? PersonsViewController {
            firstViewController.fileUtils = FileUtils()
        }
        
        return true
    }
}

