//
//  ViewController.swift
//  DailyPaper
//
//  Created by ys on 2022/10/28.
//

import UIKit

enum DataType: String {
    case popTask
    case audioRecorder
    case normalAlert
    case bottomAlert
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    private let items: [DataType] = [.popTask, .audioRecorder, .normalAlert, .bottomAlert]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .white
    }
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
        }
    }
    
}
