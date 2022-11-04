//
//  PopWindow.swift
//  DailyPaper
//
//  Created by ys on 2022/11/4.
//

import UIKit


class PopWindow: UIWindow {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .cyan
        windowLevel = UIWindow.Level.statusBar + 100
        rootViewController = UIViewController()
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(toMove(recognizer: )))
        addGestureRecognizer(pan)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc private func toMove(recognizer: UIPanGestureRecognizer) {
        let panView = recognizer.view
        let offsetPoint = recognizer.translation(in: panView) // 1 获得偏移
        recognizer.setTranslation(.zero, in: panView) // 2 重置
        
        // 更新位置
        panView?.center.x += offsetPoint.x
        panView?.center.y += offsetPoint.y
    }
    
}
