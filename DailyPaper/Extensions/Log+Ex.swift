//
//  Log+Ex.swift
//  DailyPaper
//
//  Created by ys on 2022/11/4.
//

import UIKit


func dqLog<T>(_ message: T,
              file: String = #file,
              method: String = #function,
              line: Int = #line)
{
#if DEBUG
    print("dqdqdq \((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
#endif
}

func windowLog(order: Int) {
    print("\(order): windows = \(UIApplication.shared.windows.count)")
    for window in UIApplication.shared.windows {
        print("window = \(window), \nisKeyWindow = \(window.isKeyWindow)")
    }
    print("\n")
}
