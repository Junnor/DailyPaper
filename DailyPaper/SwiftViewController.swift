//
//  SwiftViewController.swift
//  DailyPaper
//
//  Created by ys on 2022/11/5.
//

import UIKit

class SwiftViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }
    
    func autoClosureTest() {
        // 普通闭包
        func and(first: Bool, second: () -> Bool) -> Bool {
            guard first else { return false }
            return second()
        }
        
        // 自动闭包
        func autoAnd(first: Bool, second: @autoclosure  () -> Bool) -> Bool {
            guard first else { return false }
            return second()
        }
        
        // 主要类似一个语法糖
        
        let love = and(first: true) {
            3 > 10
        }
        dqLog("love = \(love)")
        
        let peace = autoAnd(first: true, second: 3 > 0)
        dqLog("peace = \(peace)")
    }
    
}
