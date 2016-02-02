//
//  CircleMenu.swift
//  ButtonTest
//
// Copyright (c) 18/01/16. Ramotion Inc. (http://ramotion.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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

    // call before animation
    optional func circleMenu(circleMenu: CircleMenu, buttonWillSelected button: CircleMenuButton, atIndex: Int)

    // call after animation
    optional func circleMenu(circleMenu: CircleMenu, buttonDidSelected button: CircleMenuButton, atIndex: Int)
}

// MARK: CircleMenu
public class CircleMenu: UIButton {
    
    // MARK: properties
    
    @IBInspectable var buttonsCount: Int = 3
    @IBInspectable var duration: Double = 2 // circle animation duration 
    @IBInspectable var distance: Float = 100 // distance betwen center button and buttons
    
    @IBOutlet weak var delegate: AnyObject? //CircleMenuDelegate
    
    var buttons: [CircleMenuButton]?
    
    var customIconView: UIImageView!
    
    // MARK: life cicle
    init(frame: CGRect,
        normalIcon: String?,
        selectedIcon: String?,
        buttonsCount: Int = 3,
        duration: Double = 2,
        distance: Float = 100) {
        super.init(frame: frame)
        
        if let _ = normalIcon {
            setImage(UIImage(named: normalIcon!), forState: .Normal)
        }
        
        if let _ = selectedIcon {
            setImage(UIImage(named: selectedIcon!), forState: .Selected)
        }
    
        self.buttonsCount = buttonsCount
        self.duration = duration
        self.distance = distance
        
        addActions()
        addCustomImageView()
        setImage(UIImage(), forState: .Normal)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        addActions()
        addCustomImageView()        
        setImage(UIImage(), forState: .Normal)
    }
    
    // MARK: create
    
    private func createButtons() -> [CircleMenuButton] {

        var buttons = [CircleMenuButton]()

        let step: Float = 360.0 / Float(self.buttonsCount)
        for index in 0..<self.buttonsCount {

            let angle: Float = Float(index) * step
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
    }
    
    private func addCustomImageView() {
        guard let selectedImage = imageForState(.Selected) else {
            return
        }
        
        guard let normalImage = imageForState(.Normal) else {
            return
        }
        
        customIconView = Init(UIImageView(image: normalImage)) {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.highlightedImage = selectedImage
            $0.contentMode = .Center
            $0.userInteractionEnabled = false
        }
        addSubview(customIconView)
        
        // added constraints
        customIconView.addConstraint(NSLayoutConstraint(item: customIconView,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .Height,
            multiplier: 1,
            constant: bounds.size.height))
        
        customIconView.addConstraint(NSLayoutConstraint(item: customIconView,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .Width,
            multiplier: 1,
            constant: bounds.size.width))
        
        addConstraint(NSLayoutConstraint(item: self,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: customIconView,
            attribute: .CenterX,
            multiplier: 1,
            constant:0))
        
        addConstraint(NSLayoutConstraint(item: self,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: customIconView,
            attribute: .CenterY,
            multiplier: 1,
            constant:0))
    }
    
    // MARK: configure
    
    private func addActions() {
        self.addTarget(self, action: "onTap", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    // MARK: helpers
    
    public func buttonsIsShown() -> Bool {
        guard buttons != nil else {
            return false
        }
        
        for button in buttons! {
            if button.alpha == 0 {
                return false
            }
        }
        return true
    }
    
    // MARK: actions
    
    func onTap() {
        if buttonsIsShown() == false {
            buttons = createButtons()
        }
        let isShow = !buttonsIsShown()
        let duration  = isShow ? 0.3 : 0.2
        buttonsAnimationIsShow(isShow: isShow, duration: duration)
        tapBounceAnimation()
        tapRotatedAnimation(0.3, isSelected: isShow)
    }
    
    func buttonHandler(sender: CircleMenuButton) {
        delegate?.circleMenu?(self, buttonWillSelected: sender, atIndex: sender.tag)
        
        let circle = CircleMenuLoader(
                            radius: CGFloat(distance),
                            strokeWidth: bounds.size.height,
                            circleMenu: self,
                            color: sender.backgroundColor!)
        
        if let container = sender.container { // rotation animation
            sender.rotationLayerAnimation(container.angleZ + 360, duration: duration)
            container.superview?.bringSubviewToFront(container)
        }
        
        if let aButtons = buttons {
            circle.fillAnimation(duration, startAngle: -90 + Float(360 / aButtons.count) * Float(sender.tag))
            circle.hideAnimation(0.3, delay: duration)
            
            scaleAnimation(layer, toValue: 0, duration: 0.3)
            buttonsAnimationIsShow(isShow: false, duration: 0, delay: duration)
            scaleAnimation(layer, toValue: 1, duration: 0.3, delay: duration)
           
            if let _ = customIconView {
                let dispatchTime: dispatch_time_t = dispatch_time(
                    DISPATCH_TIME_NOW,
                    Int64(duration * Double(NSEC_PER_SEC)))
                
                dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                    self.customIconView.highlighted = false
                    self.delegate?.circleMenu?(self, buttonDidSelected: sender, atIndex: sender.tag)
                })
            }
        }
    }
    
    // MARK: animations
    
    private func buttonsAnimationIsShow(isShow isShow: Bool, duration: Double, delay: Double = 0) {
        guard buttons != nil else {
            return
        }
        
        let step: Float = 360.0 / Float(self.buttonsCount)
        for index in 0..<self.buttonsCount {
            let button = buttons![index]
            let angle: Float = Float(index) * step
            if isShow == true {
                delegate?.circleMenu?(self, willDisplay: button, atIndex: index)
                
                button.rotatedZ(angle: angle, animated: false, delay: delay)
                button.showAnimation(distance, duration: duration, delay: delay)
            } else {
                button.hideAnimation(duration, delay: delay)
            }
        }
        if isShow == false { // hide buttons and remove
            buttons = nil
        }
    }
    
    private func tapBounceAnimation() {
        self.transform = CGAffineTransformMakeScale(0.9, 0.9)
        UIView.animateWithDuration(
            0.5,
            delay: 0,
            usingSpringWithDamping: 0.3,
            initialSpringVelocity: 5,
            options: UIViewAnimationOptions.CurveLinear,
            animations: { () -> Void in
                self.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: { (success) -> Void in
        })
    }
    
    private func tapRotatedAnimation(duration: Float, isSelected: Bool) {
        
        let angle: Float = 360.0
        
        let rotation = Init(CABasicAnimation(keyPath: "transform.rotation")) {
            $0.duration = NSTimeInterval(duration)
            $0.toValue = (angle.degres)
            $0.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        }
        
        let fade = Init(CATransition()) {
            $0.duration = NSTimeInterval(duration)
            $0.type = kCATransitionFade
            $0.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        }
        
        if let _ = customIconView {
            customIconView.highlighted = isSelected
            
            customIconView.layer.addAnimation(rotation, forKey: nil)
            customIconView.layer.addAnimation(fade, forKey: nil)
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
