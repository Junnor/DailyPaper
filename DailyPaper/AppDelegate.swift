//
//  AppDelegate.swift
//  DailyPaper
//
//  Created by ys on 2022/10/28.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
        let navc = UINavigationController(rootViewController: vc)
        window.rootViewController = navc
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }



}


extension UIResponder {
    
    func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    
    var topMostView: UIView? {
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            // UIApplication.shared.windows.first { $0.isKeyWindow }
            return window
        } 
        return nil
    }
    
}

func dqLog<T>(_ message: T,
              file: String = #file,
              method: String = #function,
              line: Int = #line)
{
#if DEBUG
    print("dqdqdq \((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
#endif
}
