//
//  ViewController.swift
//  DailyPaper
//
//  Created by ys on 2022/10/28.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        windowTask()
    }


    private func windowTask() {
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
    }
}

