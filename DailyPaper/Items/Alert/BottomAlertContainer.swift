//
//  BottomAlertContainer.swift
//  Flala
//
//  Created by ys on 2022/3/29.
//

import UIKit
import SnapKit
import SwifterSwift

// 这个需要继承使用

class BottomAlertContainer: UIView {
    
    // 设置容器view, 如果不设置，默认添加到 keyWindow
    weak var parentContainer: UIView?
    
    // 回调完成，show = true 显示完成， show = false 视图消失
    var completionDone: ((_ show: Bool) -> Void)?
    
    // 0.0 - 1.0 黑的透明度
    var darkValue: CGFloat = 0.58 {
        didSet {
            backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.58)
        }
    }
    
    func present(completion: (() -> Void)? = nil) {
        show(true, completion: completion)
    }
    
    func show(_ show: Bool, completion: (() -> Void)? = nil) {
        if superview == nil {
            if let container = parentContainer {
                container.addSubview(self)
            } else {
                UIApplication.shared.keyWindow?.addSubview(self)
            }
        }
        if show {
            beforeShowFunc()
        }
        
        UIView.animate(withDuration: 0.3) {
            self.animationFunc(show: show)
        } completion: { _ in
            self.completionDone?(show)
            self.completionFunc(show: show, completion: completion)
        }
        
    }
    
    // 可以在下面两个方法里面添加自定义实现
    func beforeShowFunc() {
        
    }
    
    func animationFunc(show: Bool) {
        self.backgroundView.alpha = show ? 1 : 0
        self.containerView.frame.origin.y = show ? UIScreen.main.bounds.height-self.containerHeight : UIScreen.main.bounds.height
    }
    
    func completionFunc(show: Bool, completion: (() -> Void)? = nil) {
        completion?()
        if !show {
            self.removeFromSuperview()
        }
    }
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.58)
        view.alpha = 0 // hide
        return view
    }()
    
    private(set) lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var containerHeight: CGFloat = 200
    
    init(contentHeight: CGFloat) {
        super.init(frame: UIScreen.main.bounds)
        
        self.containerHeight = contentHeight
        configureUI()
    }
    
    private func configureUI() {
        addSubview(backgroundView)
        addSubview(containerView)

        backgroundView.frame = UIScreen.main.bounds
        
        containerView.frame = UIScreen.main.bounds
        containerView.frame.size.height = containerHeight
        containerView.frame.origin.y = UIScreen.main.bounds.height
        containerView.roundCorners([.topLeft, .topRight], radius: 8)
        
        let topP = UIView()
        topP.backgroundColor = .clear
        addSubview(topP)
        topP.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(containerView.snp.top)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(gotoTapHide(gesture:)))
        tap.cancelsTouchesInView = false
        topP.addGestureRecognizer(tap)
        let swip = UISwipeGestureRecognizer(target: self, action: #selector(gotoHide))
        swip.direction = .right
        topP.addGestureRecognizer(swip)
        
//        let contianerTap = UITapGestureRecognizer(target: self, action: #selector(preventTapPass))
//        contianerTap.cancelsTouchesInView = false // let subView can touch
//        containerView.addGestureRecognizer(contianerTap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    @objc private func preventTapPass() {
//        dqLog("")
//    }
    
    func appendContentView(_ view: UIView) {
        containerView.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func gotoHide() {
        dqLog("")
        show(false) { [weak self] in
            self?.removeFromSuperview()
        }
    }

    // 子类可能会覆盖
    @objc func gotoTapHide(gesture: UITapGestureRecognizer) {
        dqLog("")
        let p = gesture.location(in: self)
        if p.y < UIScreen.main.bounds.height - containerHeight {
            show(false) { [weak self] in
                self?.removeFromSuperview()
            }
        }
        
    }

    
}



