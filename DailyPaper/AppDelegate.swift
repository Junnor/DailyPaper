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

