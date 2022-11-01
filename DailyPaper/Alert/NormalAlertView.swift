//
//  NormalAlertView.swift
//  Flala
//
//  Created by ys on 2022/3/29.
//

import UIKit
import SnapKit

enum NormalAlertStyle {
    case oneButton // 居中按钮
    case twoButton // 左右按钮
}

/**
 ----- title -----
 
 ----- detail -----

  button0   button1
 */

// Or

/**
 ----- title -----
 
 ----- detail -----
 
 ----- button -----
 */

class NormalAlertView: AlertContainer {
    
    var leftText: String = "" {
        didSet {
            leftButton.setTitle(leftText, for: .normal)
        }
    }
    var centerText: String = "" {
        didSet {
            centerButton.setTitle(centerText, for: .normal)
        }
    }
    var rightText: String = "" {
        didSet {
            rightButton.setTitle(rightText, for: .normal)
        }
    }
        
    var leftAction: (() -> Void)? = nil
    var centerAction: (() -> Void)? = nil
    var rightAction: (() -> Void)? = nil

    private lazy var contentView: UIView = {
        let view = UIVisualEffectView()
        view.backgroundColor = .white
        
        let textStackView = UIStackView(arrangedSubviews: [titleLabel, messageLabel])
        textStackView.axis = .vertical
        textStackView.spacing = 25
        textStackView.alignment = .center
        textStackView.distribution = .fill
        view.contentView.addSubview(textStackView)

        textStackView.snp.makeConstraints { make in
            make.leading.equalTo(15)
            make.top.equalTo(20)
            make.centerX.equalToSuperview()
        }

        let buttonsStackView = UIStackView(arrangedSubviews: [leftButton, centerButton, rightButton])
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 20
        buttonsStackView.alignment = .fill
        buttonsStackView.distribution = .fillEqually
        view.contentView.addSubview(buttonsStackView)
        
        buttonsStackView.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-20)
            make.height.equalTo(44)
            make.top.equalTo(textStackView.snp.bottom).offset(28)
        }
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 50/255.0, green: 55/255.0, blue: 79/255.0, alpha: 1)
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 171/255.0, green: 176/255.0, blue: 194/255.0, alpha: 1)
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.addTarget(self, action: #selector(toLeft), for: .touchUpInside)
        button.layer.cornerRadius = 44/2
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var centerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ok", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.addTarget(self, action: #selector(toCenter), for: .touchUpInside)
        button.layer.cornerRadius = 44/2
        button.layer.masksToBounds = true
        return button
    }()
    
    
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ok", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.addTarget(self, action: #selector(toRight), for: .touchUpInside)
        button.layer.cornerRadius = 44/2
        button.layer.masksToBounds = true
        return button
    }()

    
    init(title: String?, message: String?, contentWidth: CGFloat = UIScreen.main.bounds.width-60, style: NormalAlertStyle = .twoButton) {
        super.init(contentWidth: min(contentWidth, 315))
                
        containerView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.text = title
        messageLabel.text = message
        
        titleLabel.isHidden =  title == nil
        messageLabel.isHidden =  message == nil
        
        leftButton.isHidden = style != .twoButton
        rightButton.isHidden = style != .twoButton
        centerButton.isHidden = style != .oneButton
    }
    init(title: String?, message: String?, style: NormalAlertStyle = .twoButton) {
        super.init(contentWidth: UIScreen.main.bounds.width - 60)
                
        containerView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        messageLabel.textColor = .darkText
        
        titleLabel.text = title
        messageLabel.text = message
        
        titleLabel.isHidden =  title == nil
        messageLabel.isHidden =  message == nil
        
        leftButton.isHidden = style != .twoButton
        rightButton.isHidden = style != .twoButton
        centerButton.isHidden = style != .oneButton
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    @objc private func toLeft() {
        show(false) { [weak self] in
            self?.leftAction?()
        }
    }
    
    @objc private func toCenter() {
        show(false) { [weak self] in
            self?.centerAction?()
        }
    }
    
    @objc private func toRight() {
        show(false) { [weak self] in
            self?.rightAction?()
        }
    }
    
}
