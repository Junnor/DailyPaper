//
//  PopWindowQueue.swift
//  DailyPaper
//
//  Created by ys on 2022/10/28.
//

import UIKit


struct PopWindowTask {
    
    enum WindowType {
        case unset // 未设置
        case leading // 引导图
        case checkIn // 签到
        case matching // 自动匹配
        case chatVip // 聊天vip的弹窗
    }
    
    let type: WindowType
    let task: PopTask
    
    typealias PopTask = () -> Void
    
    func perform() {
        task()
    }
}

// 主要是防止弹窗紊乱叠加，让弹窗一个接着一个弹出

struct PopWindowQueue {
    
    static private var tasks: [PopWindowTask] = [] {
        didSet {
            print("pop tasks = \(tasks)")
        }
    }
    
    // enqueue 和 dequeue 需要配对使用
    // 最好是在确定view消失的时候手动调用 dequeue；
    // 最好不要在 deinit 里面调用 dequeue，因为不确定 view 不显示以后是否有多个引用指向，导致不执行 deinit，阻塞队列以后的弹窗
    
    static func enqueue(_ task: PopWindowTask) {
        // 如果队列是空的，那么立即执行改弹窗
        if tasks.isEmpty {
            task.perform()
        }
        
        tasks.append(task)
    }
    

    @discardableResult
    static func dequeue() -> PopWindowTask? {
        defer {
            if !tasks.isEmpty {
                tasks.removeFirst()
                
                // 如果签到不在最前面，那么移动到队前
                if let index = tasks.firstIndex(where: { $0.type == .checkIn }), index != 0 {
                    let task = tasks.remove(at: index)
                    tasks.insert(task, at: 0)
                }
                
                // new
                if let current = tasks.first {
                    let delay: TimeInterval = (current.type == .matching) ? 10 : 0
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                        current.perform()
                    }
                }
                
            }
        }
        return tasks.first
    }
    
}
