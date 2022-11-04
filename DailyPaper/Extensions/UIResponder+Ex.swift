//
//  UIResponder+Ex.swift
//  DailyPaper
//
//  Created by ys on 2022/11/4.
//

import UIKit


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
