//
//  LargeButtonViewController.swift
//  DailyPaper
//
//  Created by ys on 2022/11/11.
//

import UIKit

class LargeButtonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(testButton)
    }
    

    private lazy var testButton: LargeButton = {
        let button = LargeButton()
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 20)
        button.setTitle("Play", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(doAction), for: .touchUpInside)
        return button
    }()
    
    @objc private func doAction() {
        dqLog("")
    }

}

// 主要是来增大点击响应区域，默认是增大15的距离

class LargeButton: UIButton {
    
    init(offSet: CGFloat = 15) {
        super.init(frame: .zero)
        
        self.offSet = offSet
    }
    
    private var offSet: CGFloat = 15
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return self.bounds.insetBy(dx: -offSet, dy: -offSet).contains(point)
    }
    
}
