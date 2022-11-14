//
//  ViewController.swift
//  DailyPaper
//
//  Created by ys on 2022/10/28.
//

import UIKit


class ViewController: UIViewController {
    
    enum DataType: String {
        case popTask
        case audioRecorder
        case normalAlert
        case bottomAlert
        case floatWindow
        case largeButton
        case advancedSwift
        case randomDowloadImage
        case zegoPlay
    }
    
    private let items: [DataType] = [
        .popTask,
        .audioRecorder,
        .normalAlert,
        .bottomAlert,
        .floatWindow,
        .largeButton,
        .advancedSwift,
        .randomDowloadImage,
        .zegoPlay
    ]
    
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            
            tableView.backgroundColor = .white
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // 测试 window 浮窗（需要强引用）
    lazy var floatCornerWindow: PopWindow = {
        let window = PopWindow(frame: CGRect(x: 250, y: 400, width: 100, height: 100))
        window.roundCorners(.allCorners, radius: 100/2)
        return window
    }()
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.item].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch items[indexPath.item] {
        case .popTask:
            let task1 = PopWindowTask(type: .unset) { [weak self] in
                let alert = UIAlertController(title: "这是第一个的弹窗", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
                    PopWindowQueue.dequeue()
                })
                self?.present(alert, animated: true)
            }
            PopWindowQueue.enqueue(task1)
            
            let task2 = PopWindowTask(type: .unset) { [weak self] in
                let alert = UIAlertController(title: "这是第二的弹窗", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
                    PopWindowQueue.dequeue()
                })
                self?.present(alert, animated: true)
            }
            PopWindowQueue.enqueue(task2)
            
        case .audioRecorder:
            performSegue(withIdentifier: "audioRecorder", sender: self)
        case .normalAlert:
            let pop = NormalAlertView(title: "Love", message: "I love peace I love peace I love peace I love peace I love peace I love peace I love peace")
            pop.present()
        case .bottomAlert:
            let pop = DemoBottomAlert(frame: .zero)
            pop.present()
        case .floatWindow:
            windowLog(order: 0)

            floatCornerWindow.isHidden.toggle() // 单纯的显示window而已
//            floatCornerWindow.makeKeyAndVisible() // 替换 application 的 keyWindow
            
            windowLog(order: 2)
        case .largeButton:
            let vc = LargeButtonViewController()
            navigationController?.pushViewController(vc, animated: true)
        case .advancedSwift:
            let vc = SwiftViewController()
            navigationController?.pushViewController(vc, animated: true)
        case .randomDowloadImage:
            let vc = RandomImageViewController()
            navigationController?.pushViewController(vc, animated: true)
        case .zegoPlay:
            let vc = ZegoDemoViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
