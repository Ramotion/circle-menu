//
//  CircleMenu.swift
//  ButtonTest
//
//  Created by Alex K. on 14/01/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

// MARK: helpers

@warn_unused_result
public func Init<Type>(value: Type, @noescape block: (object: Type) -> Void) -> Type {
    block(object: value)
    return value
}

// MARK: Protocol 

@objc protocol CircleMenuDelegate {
    // don't change button.tag
    optional func circleMenu(circleMenu: CircleMenu, willDisplay button: CircleMenuButton, atIndex: Int)
}

// MARK: CircleMenu
public class CircleMenu: UIButton {
    
    // MARK: properties
    
    @IBInspectable var buttonsCount: Int = 3
    @IBInspectable var duration: Double = 2
    @IBInspectable var distance: Float = 100 // distance betwen center button and buttons
    
    @IBOutlet weak var delegate: AnyObject? //CircleMenuDelegate
    
    lazy var buttons: [CircleMenuButton] = {
        var buttons = [CircleMenuButton]()
        
        
        let step: Float = 360.0 / Float(self.buttonsCount)
        for index in 0..<self.buttonsCount {
            
            var angle: Float = Float(index) * step
            let button = Init(CircleMenuButton(
                size: self.bounds.size,
                circleMenu: self,
                distance:Float(self.bounds.size.height/2.0),
                angle: angle)) {
                    
                $0.tag = index
                $0.addTarget(self, action: "buttonHandler:", forControlEvents: UIControlEvents.TouchUpInside)
                $0.alpha = 0
            }
            buttons.append(button)
        }
        
        return buttons
    }()
    
    // MARK: life cicle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addActions()
    }
    
    // MARK: create 
    
    private func createMovingObject(
        size: CGSize,
        distance: Float,
        angle: Float,
        duration: Double,
        additionAngle: Float) {
            let object = CircleMenuButton(size: size, circleMenu: self, distance: distance, angle: angle)
            object.rotationLayerAnimation(angle + 360.0 + additionAngle, duration: duration)
    }
    
    // MARK: configure
    
    private func addActions() {
        self.addTarget(self, action: "onTap", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    // MARK: helpers
    
    public func buttonsIsShown() -> Bool {
        for button in buttons {
            if button.alpha == 0 {
                return false
            }
        }
        return true
    }
    
    // MARK: actions
    func onTap() {
        buttonsAnimationShow(isShow: !buttonsIsShown(), duration: 0.3)
    }
    
    func buttonHandler(sender: CircleMenuButton) {
        let circle = CircleMenuLoader(
                            radius: CGFloat(distance),
                            strokeWidth: bounds.size.height,
                            circleMenu: self,
                            color: sender.backgroundColor!)
        
        if let container = sender.superview { // rotation animation
            sender.rotationLayerAnimation(container.angleZ + 360, duration: duration)
            container.superview?.bringSubviewToFront(container)
        }
        
        circle.fillAnimation(duration, startAngle: Float(360.0) / Float(buttons.count) * Float(sender.tag - 1))
        circle.hideAnimation(0.3, delay: duration)
        
        scaleAnimation(layer, toValue: 0, duration: 0.3)
        buttonsAnimationShow(isShow: false, duration: 0, delay: duration)
        scaleAnimation(layer, toValue: 1, duration: 0.3, delay: duration)
    }
    
    // MARK: animations
    
    private func buttonsAnimationShow(isShow isShow: Bool, duration: Double, delay: Double = 0) {
        let step: Float = 360.0 / Float(self.buttonsCount)
        for index in 0..<self.buttonsCount {
            let button = buttons[index]
            let angle: Float = Float(index) * step
            if isShow == true {
                delegate?.circleMenu?(self, willDisplay: button, atIndex: index)
                
                button.rotatedZ(angle: angle, animated: false, delay: delay)
                button.showAnimation(distance, duration: duration, delay: delay)
            } else {
                button.hideAnimation(self.bounds.size.width / 2.0, duration: duration, delay: delay)
            }
        }
    }
    
    private func scaleAnimation(layer: CALayer, toValue: CGFloat, duration: Double, delay: Double = 0) {
        let aniamtion = Init(CABasicAnimation(keyPath: "transform.scale")) {
            $0.toValue = toValue
            $0.duration = duration
            $0.fillMode = kCAFillModeForwards
            $0.removedOnCompletion = false
            $0.beginTime = CACurrentMediaTime() + delay
        }
        layer.addAnimation(aniamtion, forKey: nil)
    }
}

// MARK: extension

extension Float {
    var radians: Float {
        return self * (Float(180) / Float(M_PI))
    }
    
    var degres: Float {
        return self  * Float(M_PI) / 180.0
    }
}

extension UIView {
    
    var angleZ: Float {
        let radians: Float = atan2(Float(self.transform.b), Float(self.transform.a))
        return radians.radians
    }
}
