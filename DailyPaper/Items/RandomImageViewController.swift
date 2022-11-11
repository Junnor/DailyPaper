//
//  RandomImageViewController.swift
//  DailyPaper
//
//  Created by ys on 2022/11/11.
//

import UIKit
import Kingfisher

class RandomImageViewController: UIViewController {
    
    /* 下面是一些随机图片地址
     let randomPicURL = "http://lorempixel.com/400/200"
     let randomPicHolder = "http://placehold.it/350x150"
     let anotherPlaceHolder = "https://placeimg.com/640/480/any"  // 这个可以用
     */

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        

        let iv0 = createImageView(index: 0)
        iv0.kf.setImage(with: URL(string: "https://placeimg.com/\(100+arc4random()%7*100)/\(100+arc4random()%7*100)"))
        
        let iv1 = createImageView(index: 1)
        iv1.kf.setImage(with: URL(string: "https://placeimg.com/\(100+arc4random()%7*100)/\(100+arc4random()%7*100)"))
        
        let iv2 = createImageView(index: 2)
        iv2.kf.setImage(with: URL(string: "https://placeimg.com/\(100+arc4random()%7*100)/\(100+arc4random()%7*100)"))
    }


    func createImageView(index: Int) -> UIImageView {
        let iv = UIImageView(frame: CGRect(x: 120*CGFloat(index) + 20, y: 200, width: 100, height: 100))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
      
        view.addSubview(iv)
        return iv
    }
 

}
