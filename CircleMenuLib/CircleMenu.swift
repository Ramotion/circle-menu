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
    func circleMenu(circleMenu: CircleMenu, button: CircleMenuButton, atIndex: Int)
}

// MARK: CircleMenu
public class CircleMenu: UIButton {
    
    // MARK: properties
    
    @IBInspectable var buttonsCount: Int = 3
    @IBInspectable var duration: Double = 2
    @IBInspectable var distance: Float = 100 // distance betwen center button and buttons
    
    @IBOutlet weak var delegate: CircleMenuDelegate?
    
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
        buttonsAnimationShow(isShow: !buttonsIsShown())
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
    }
    
    // MARK: animations
    
    private func buttonsAnimationShow(isShow isShow: Bool) {
        let step: Float = 360.0 / Float(self.buttonsCount)
        for index in 0..<self.buttonsCount {
            let button = buttons[index]
            let angle: Float = Float(index) * step
            if isShow == true {
                button.rotatedZ(angle: angle, animated: false)
                button.showAnimation(distance, duration: 0.3)
            } else {
                button.hideAnimation(self.bounds.size.width / 2.0, duration: 0.3)
            }
        }
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
