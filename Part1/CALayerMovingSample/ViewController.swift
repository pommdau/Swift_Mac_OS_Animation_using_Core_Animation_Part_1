//
//  ViewController.swift
//

import Cocoa

class ViewController: NSViewController {
    
    let circleLayer = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set view to be layer-hosting
        self.view.layer = CALayer()
        self.view.wantsLayer = true
        initializeCircleLayer()
        //        simpleCAAnimationDemo()
        keyFrameAnimationDemo()
        //        groupedAnimationDemo()
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
    func initializeCircleLayer() {
        circleLayer.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        circleLayer.position = CGPoint(x: 50, y: 50)
        circleLayer.backgroundColor = NSColor.red.cgColor
        circleLayer.cornerRadius = 25.0
        self.view.layer?.addSublayer(circleLayer)
    }
    
    func simpleCAAnimationDemo() {
        circleLayer.removeAllAnimations()
        let animation = CABasicAnimation(keyPath: "position")
        let startingPoint = NSValue(point: NSPoint(x: 50, y: 50))
        let endingPoint = NSValue(point: NSPoint(x: 400, y: 50))
        animation.fromValue = startingPoint
        animation.toValue = endingPoint
        animation.repeatCount = Float.greatestFiniteMagnitude
        animation.duration = 3.0
        circleLayer.add(animation, forKey: "linearMovement")
    }
    
    func keyFrameAnimationDemo() {
        circleLayer.removeAllAnimations()
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 280, y: 100))
        path.addCurve(to: CGPoint(x: 320, y: 100), control1: CGPoint(x: 100, y: 400), control2: CGPoint(x: 500, y: 400))
        path.addCurve(to: CGPoint(x: 280, y: 100), control1: CGPoint(x: 600, y: 500), control2: CGPoint(x: 0  , y: 500))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path
        shapeLayer.lineWidth = 3.0
        shapeLayer.fillColor = NSColor.clear.cgColor
        shapeLayer.strokeColor = NSColor.black.cgColor
        self.view.layer?.addSublayer(shapeLayer)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.calculationMode = CAAnimationCalculationMode.linear
        animation.path = path
        animation.repeatCount = Float.greatestFiniteMagnitude
        animation.autoreverses = true
        animation.duration = 5.0
        circleLayer.add(animation, forKey: "KeyFrameMovement")
    }
    
    func groupedAnimationDemo(){
        circleLayer.removeAllAnimations()
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 280, y: 100))
        path.addCurve(to: CGPoint(x: 320, y: 100), control1: CGPoint(x: 100, y: 400), control2: CGPoint(x: 500, y: 400))
        path.addCurve(to: CGPoint(x: 280, y: 100), control1: CGPoint(x: 600, y: 500), control2: CGPoint(x: 0  , y: 500))
        
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path
        shapeLayer.lineWidth = 3.0
        shapeLayer.fillColor = NSColor.clear.cgColor
        shapeLayer.strokeColor = NSColor.black.cgColor
        self.view.layer?.addSublayer(shapeLayer)
        
        let widthAnimation = CAKeyframeAnimation(keyPath: "borderWidth")
        let widthValues = [2.0,4.0,6.0,8.0,6.0,4.0,2.0,4.0,6.0,8.0,6.0,4.0,2.0]
        widthAnimation.values = widthValues
        widthAnimation.calculationMode = CAAnimationCalculationMode.paced
        
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        positionAnimation.calculationMode = CAAnimationCalculationMode.linear
        positionAnimation.path = path
        
        let colorAnimation = CAKeyframeAnimation(keyPath: "backgroundColor")
        let colors = [NSColor.blue.cgColor, NSColor.red.cgColor, NSColor.green.cgColor]
        colorAnimation.values = colors
        colorAnimation.calculationMode = CAAnimationCalculationMode.paced
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [widthAnimation,positionAnimation,colorAnimation]
        groupAnimation.duration = 3.0
        groupAnimation.repeatCount = Float.greatestFiniteMagnitude
        groupAnimation.autoreverses = true
        circleLayer.add(groupAnimation, forKey: "multiAnimation")
    }
}
