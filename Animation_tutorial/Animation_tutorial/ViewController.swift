//
//  ViewController.swift
//  Animation_tutorial
//
//  Created by FelixZhao on 2020/3/12.
//  Copyright © 2020 FelixZhao. All rights reserved.
//

// https://juejin.im/post/5d5bfc59f265da03f77e6c32
// https://swift.gg/2019/08/14/add-fireworks-and-sparks-to-a-uiview/
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        myView.backgroundColor = .red
        myView.center = view.center
        //view.addSubview(myView)
        
        
        
       //CABasicAnimation *a1 = [CABasicAnimation animation];
        let basicAnimation = CABasicAnimation()
        
        //a1.keyPath = @"position";
        basicAnimation.keyPath = "position"
        
        //a1.toValue = [NSValue valueWithCGPoint:CGPointMake(150 + 28, 180 + 28)];
        
        basicAnimation.toValue = CGPoint(x: 200, y: 200)
        
        //a1.duration = 0.5;
        basicAnimation.duration = 2.0
        
        //a1.fillMode = kCAFillModeForwards;
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        
        //a1.removedOnCompletion = NO;
        basicAnimation.isRemovedOnCompletion = false
        
        //[self.view.layer addAnimation:a1 forKey:@"position"];
        
        //myView.layer.add(basicAnimation, forKey: "position")
        
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "position")
        
        let point1 = CGPoint(x: 100, y: 100)
        let point2 = CGPoint(x: 300, y: 100)
        let point3 = CGPoint(x: 300, y: 300)
        let point4 = CGPoint(x: 100, y: 300)
        let point5 = CGPoint(x: 100, y: 100)
        
        keyFrameAnimation.values = [point1,point2,point3,point4,point5]
        
        keyFrameAnimation.duration = 4.0
        keyFrameAnimation.keyTimes = [
            0.0,
            0.4,
            0.5,
            0.75,
            1.0
        ]
        
        keyFrameAnimation.fillMode = .forwards
        keyFrameAnimation.isRemovedOnCompletion = false
        
        myView.layer.add(keyFrameAnimation, forKey: "position1")
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        
   
        let gif = Bundle.main.url(forResource: "a", withExtension: "gif")
        let gifResorce = CGImageSourceCreateWithURL(gif as! CFURL, nil)
        
        let frameCount = CGImageSourceGetCount(gifResorce!)
        
        var frames = [UIImage]()
        
        for i in 0..<frameCount {
            let imageRef = CGImageSourceCreateImageAtIndex(gifResorce!, i, nil)
            let image = UIImage(cgImage: imageRef!)
            
            frames.append(image)
        }
        imageView.animationImages = frames
        imageView.animationDuration = 2
        imageView.startAnimating()
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        btn.center = view.center
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("button", for: .normal)
        btn.backgroundColor = .gray
        
        view.addSubview(btn)
        
        btn.addSubview(imageView)
        
        btn.addTarget(self, action: #selector(clicked), for: .touchUpInside)
        
    }
    
    @objc func clicked() {
        print("按钮被点击了")
    }


}

