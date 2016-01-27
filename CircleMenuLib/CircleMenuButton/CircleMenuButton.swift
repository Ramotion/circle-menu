//
//  CircleMenuButton.swift
//  ButtonTest
//
//  Created by Alex K. on 18/01/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

public class CircleMenuButton: UIButton {
    
    // MARK: properties
    
    var container: UIView?
    
    // MARK: life cicle
    
    init(size: CGSize, circleMenu: CircleMenu, distance: Float, angle: Float = 0) {
        super.init(frame: CGRect(origin: CGPointZero, size: size))
        
        self.backgroundColor = UIColor(colorLiteralRed: 0.79, green: 0.24, blue: 0.27, alpha: 1)
        self.layer.cornerRadius = size.height / 2.0
        
        let aContainer = createContainer(CGSize(width: size.width, height:CGFloat(distance)), circleMenu: circleMenu)
        aContainer.addSubview(self)
        container = aContainer
        
        self.rotatedZ(angle: angle, animated: false)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: configure
    
    private func createContainer(size: CGSize, circleMenu: CircleMenu) -> UIView {

        guard circleMenu.superview != nil else { fatalError("wront circle menu")}
        
        let container = Init(UIView(frame:CGRect(origin: CGPointZero, size: size))) {
            $0.backgroundColor = UIColor.clearColor()
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        }
        circleMenu.superview!.insertSubview(container, belowSubview: circleMenu)
        
        // added constraints
        let height = NSLayoutConstraint(item: container,
                                   attribute: .Height,
                                   relatedBy: .Equal,
                                      toItem: nil,
                                   attribute: .Height,
                                  multiplier: 1,
                                    constant: size.height)
        height.identifier = "height"
        container.addConstraint(height)
        
        container.addConstraint(NSLayoutConstraint(item: container,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .Width,
            multiplier: 1,
            constant: size.width))
        
        circleMenu.superview!.addConstraint(NSLayoutConstraint(item: circleMenu,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: container,
            attribute: .CenterX,
            multiplier: 1,
            constant:0))
        
        circleMenu.superview!.addConstraint(NSLayoutConstraint(item: circleMenu,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: container,
            attribute: .CenterY,
            multiplier: 1,
            constant:0))
    
        return container
    }
    
    // MARK: public 
    
    public func rotatedZ(angle angle: Float, animated: Bool, duration: Double = 0) {
        guard container != nil else {fatalError("contaner don't create")}
        
        let rotateTransform = CATransform3DMakeRotation(CGFloat(angle.degres), 0, 0, 1)
        if animated {
            UIView.animateWithDuration(
                duration,
                delay: 0,
                options: UIViewAnimationOptions.CurveEaseInOut,
                animations: { () -> Void in
                    self.container!.layer.transform = rotateTransform
                },
                completion: nil)
        } else {
            container!.layer.transform = rotateTransform
        }
    }
}

// MARK: Animations

extension CircleMenuButton {
    
    public func showAnimation(distance: Float, duration: Double) {
        let heightConstraint = self.container?.constraints.filter {$0.identifier == "height"}.first
    
        guard heightConstraint != nil else {
            return
        }
        self.transform = CGAffineTransformMakeScale(0, 0)
        self.container?.layoutIfNeeded()
        
        self.alpha = 1
        
        heightConstraint?.constant = CGFloat(distance)
        UIView.animateWithDuration(
            duration,
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0,
            options: UIViewAnimationOptions.CurveLinear,
            animations: { () -> Void in
                self.container!.layoutIfNeeded()
                self.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: { (success) -> Void in
        })
    }

    public func hideAnimation(distance: CGFloat, duration: Double, delay: Double = 0) {
        let heightConstraint = self.container?.constraints.filter {$0.identifier == "height"}.first
        
        guard heightConstraint != nil else {
            return
        }
        
        UIView.animateWithDuration(
            duration,
            delay: delay,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: { () -> Void in
                self.transform = CGAffineTransformMakeScale(0.01, 0.01)
            }, completion: { (success) -> Void in
                heightConstraint?.constant = CGFloat(distance)
                self.alpha = 0
        })
    }
    
    public func changeDistance(distance: CGFloat, animated: Bool, duration: Double = 0, delay: Double = 0) {
        let heightConstraint = self.container?.constraints.filter {$0.identifier == "height"}.first
        
        guard heightConstraint != nil else {
            return
        }
        
        heightConstraint?.constant = distance
        
        UIView.animateWithDuration(
            duration,
            delay: delay,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: { () -> Void in
                self.container!.layoutIfNeeded()
            },
            completion: nil)
    }
    
//    public func tapAnimation(byAngle angle: Float, duration: Double, distance: Float) {
//        if let _ = container {
////            rotatedZ(angle: aContainer.angleZ + angle, animated: true, duration: duration)
//            rotationLayerAnimation(angle, duration: duration)
////            changeDistance(self.bounds.size.height / 2.0, animated: true, duration: 0.2, delay: duration - 0.2)
//        }
//    }
    
    // MARK: layer animation
    
    public func rotationLayerAnimation(angle: Float, duration: Double) {
        if let aContainer = container {
            let rotation = Init(CABasicAnimation(keyPath: "transform.rotation")) {
                $0.duration = NSTimeInterval(duration)
                $0.toValue = (angle.degres)
                $0.fillMode = kCAFillModeForwards
                $0.removedOnCompletion = false
                $0.delegate = self
            }
            aContainer.layer.addAnimation(rotation, forKey: "rotation")
        }
    }
    
    public override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if let aContainer = container {
            aContainer.removeFromSuperview()
        }
    }
}
