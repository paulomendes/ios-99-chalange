
import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    private static let container: Container = {
        let container = Container()
        
        return container
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if let firstViewController = window?.rootViewController as? PersonsViewController {
            firstViewController.personsDataSource = AppDelegate.container.resolvePersonDataSource()
        }
        
        return true
    }
}

