//
//  DemoBottomAlert.swift
//  DailyPaper
//
//  Created by ys on 2022/11/1.
//

import UIKit
import SnapKit

class DemoBottomAlert: BottomAlertContainer {
    
    // 去退出聊天
    var toLeaveGroup: (() -> Void)?
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        view.addSubview(cancelButton)
       
        cancelButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(30)
            make.top.equalTo(30)
        }
        
        return view
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        return button
    }()
    
    
    init(frame: CGRect) {
        super.init(contentHeight: 152)
        
        appendContentView(contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func dismissAction() {
        show(false)
    }
    
}
