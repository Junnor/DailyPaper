//
//  AlertContainer.swift
//  Flala
//
//  Created by ys on 2022/3/29.
//

import UIKit
import SnapKit

// Base
class AlertContainer: UIView {
    
    // 设置容器view, 如果不设置，默认添加到 keyWindow
    weak var parentContainer: UIView?
    
    func present(_ completion: (() -> Void)? = nil) {
        show(true, completion: completion)
    }
    
    func show(_ show: Bool, completion: (() -> Void)? = nil) {
        if superview == nil {
            if let container = parentContainer {
                container.addSubview(self)
            } else {
                topMostView?.addSubview(self)
            }
        }
        
        UIView.animate(withDuration: 0.25) {
            self.animation(show: show)
        } completion: { _ in
            self.completion(show: show, completion: completion)
        }
        
    }
    
    // 下面两个方法可以覆盖实现自定义设置
    
    func animation(show: Bool) {
        self.backgroundView.alpha = show ? 1 : 0
        if show {
            self.containerView.transform = .identity
            self.containerView.alpha = 1
        } else {
            self.containerView.alpha = 0
        }
    }
    
    func completion(show: Bool, completion: (() -> Void)? = nil) {
        completion?()
        if !show {
            self.containerView.transform = CGAffineTransform(scaleX: self.ratio, y: self.ratio)
            self.removeFromSuperview()
        }
    }
    
    // 0.0 - 1.0 黑的透明度
    var darkValue: CGFloat = 0.58 {
        didSet {
            backgroundView.backgroundColor = UIColor.black.withAlphaComponent(darkValue)
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
    
    private lazy var containerWidth: CGFloat = 315
    private lazy var ratio = ((UIScreen.main.bounds.width-containerWidth)/2+containerWidth)/containerWidth
    
    init(contentWidth: CGFloat = UIScreen.main.bounds.width-60) {
        super.init(frame: UIScreen.main.bounds)
        
        self.containerWidth = contentWidth
        configureUI()
    }
    
    private func configureUI() {
        addSubview(backgroundView)
        addSubview(containerView)
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(containerWidth)
        }
        containerView.alpha = 0
        
        containerView.layer.cornerRadius = 16
        containerView.layer.masksToBounds = true
        
        containerView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        
        addGestureRecognizer(bgTap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var bgTap = UITapGestureRecognizer(target: self, action: #selector(preventTapPass))

    var passTapGesture = false {
        didSet {
            if passTapGesture {
                bgTap.cancelsTouchesInView = false
            }
        }
    }
    
    @objc func preventTapPass() {
    }
    
}



