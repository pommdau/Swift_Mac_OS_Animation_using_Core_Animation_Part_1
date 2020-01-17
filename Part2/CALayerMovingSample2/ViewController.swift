//
//  ViewController.swift
//  CALayerMovingSample2
//
//  Created by HIROKI IKEUCHI on 2020/01/17.
//  Copyright © 2020年 hikeuchi. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var coloredView: ColoredView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
//            self.moveViewWithoutAnimation()
//            self.moveViewWithAnimationDefaultDuration()
//            self.moveViewWithAnimationCustomDuration()
//            self.moveWithWithNestedAnimations()
            self.animatorProxyAndKeyframeAnimations()
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func moveViewWithoutAnimation(){
        var origin = self.coloredView.frame.origin
        origin.x += 300
        self.coloredView.setFrameOrigin(origin)
    }
    
    func moveViewWithAnimationDefaultDuration(){
        var origin = self.coloredView.frame.origin
        origin.x += 300
        self.coloredView.animator().setFrameOrigin(origin)
    }

    func moveViewWithAnimationCustomDuration(){
        NSAnimationContext.beginGrouping()
        NSAnimationContext.current.duration = 3.0   // アニメーション時間を3.0sに
        NSAnimationContext.current.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.linear)    // 一定速度で移動
        var origin = self.coloredView.frame.origin
        origin.x += 300
        self.coloredView.animator().setFrameOrigin(origin)
        NSAnimationContext.endGrouping()
    }
    
    func moveWithWithNestedAnimations(){
        NSAnimationContext.beginGrouping()
        NSAnimationContext.current.duration = 3.0
        var origin = self.coloredView.frame.origin
        origin.x += 300
        self.coloredView.animator().setFrameOrigin(origin)
        
        /////////////////////////////////////////////////
        NSAnimationContext.beginGrouping()
        NSAnimationContext.current.duration = 4.0
        var size = self.coloredView.frame.size
        size.height *= 2
        size.width *= 2
        self.coloredView.animator().setFrameSize(size)
        NSAnimationContext.endGrouping()
        /////////////////////////////////////////////////
        
        NSAnimationContext.endGrouping()
    }
    
    
    func animatorProxyAndKeyframeAnimations(){
        // 1. 移動のアニメーション
        let posAnimation = CAKeyframeAnimation()
        posAnimation.duration = 3.0
        let x = self.coloredView.frame.origin.x
        let y = self.coloredView.frame.origin.y
        posAnimation.values = [CGPoint(x: x    , y: y),
                               CGPoint(x: x+100, y: y),
                               CGPoint(x: x+200, y: y),
                               CGPoint(x: x+400, y: y+200)]
        posAnimation.keyTimes = [0.0,0.5,0.8,1.0]
        posAnimation.timingFunctions = [CAMediaTimingFunction(name:CAMediaTimingFunctionName.linear),
                                        CAMediaTimingFunction(name:CAMediaTimingFunctionName.linear),
                                        CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)]
        posAnimation.autoreverses = true
        posAnimation.repeatCount = Float.greatestFiniteMagnitude
        
        // 2. 拡大のアニメーション
        let sizeAnimation = CABasicAnimation(keyPath: "frameSize")
        sizeAnimation.fromValue = self.coloredView.frame.size
        sizeAnimation.toValue = CGSize(width: 50, height: 50)
        sizeAnimation.duration = 3.0
        sizeAnimation.autoreverses = true
        sizeAnimation.repeatCount = Float.greatestFiniteMagnitude
        
        // CustomViewに2つのアニメーションをセットする
        var existingAnimations = self.coloredView.animations
        existingAnimations["frameOrigin"] = posAnimation
        existingAnimations["frameSize"] = sizeAnimation
        self.coloredView.animations = existingAnimations
        //self.coloredView.animator().setFrameOrigin(CGPoint(x: x+400, y: y))
        self.coloredView.animator().frame = CGRect(x: x+400, y: y+200, width: 50, height: 50)
    }
}

