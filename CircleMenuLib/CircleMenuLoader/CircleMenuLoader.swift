//
//  CircleMenuLoader.swift
//  CircleMenu
//
//  Created by Alex K. on 27/01/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import Foundation
import UIKit

public class CircleMenuLoader: UIView {
    
    // MARK: properties
    
    var circle: CAShapeLayer?

    // MARK: life cicle
    
    public init(radius: CGFloat, strokeWidth: CGFloat, circleMenu: CircleMenu, color: UIColor) {
        super.init(frame: CGRect(x: 0, y: 0, width: radius, height: radius))
        
        if let aSuperView = circleMenu.superview {
            aSuperView.insertSubview(self, belowSubview: circleMenu)
        }
        
        circle = createCircle(radius, strokeWidth: strokeWidth, color: color)
        createConstraints(circleMenu, radius: radius)
        
        backgroundColor = UIColor.clearColor()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: create
    
    private func createCircle(radius: CGFloat, strokeWidth: CGFloat, color: UIColor) -> CAShapeLayer {
        
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: radius, y: radius),
            radius: CGFloat(radius) - strokeWidth / 2.0,
            startAngle: CGFloat(0),
            endAngle:CGFloat(M_PI * 2),
            clockwise: true)
        
        let circle = Init(CAShapeLayer()) {
            $0.path = circlePath.CGPath
            $0.fillColor = UIColor.clearColor().CGColor
            $0.strokeColor = color.CGColor
            $0.lineWidth = strokeWidth
        }
        
        self.layer.addSublayer(circle)
        return circle
    }
    
    private func createConstraints(circleMenu: CircleMenu, radius: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        // added constraints
        addConstraint(NSLayoutConstraint(item: self,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .Height,
            multiplier: 1,
            constant: radius * 2.0))
        
        addConstraint(NSLayoutConstraint(item: self,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .Width,
            multiplier: 1,
            constant: radius * 2.0))
        
        circleMenu.superview!.addConstraint(NSLayoutConstraint(item: circleMenu,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: self,
            attribute: .CenterX,
            multiplier: 1,
            constant:0))
        
        circleMenu.superview!.addConstraint(NSLayoutConstraint(item: circleMenu,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: self,
            attribute: .CenterY,
            multiplier: 1,
            constant:0))
    }
    
    // MARK: animations
    
    public func fillAnimation(duration: Double, startAngle: Float) {
        guard circle != nil else {
            return
        }
        
        let rotateTransform = CATransform3DMakeRotation(CGFloat(startAngle.degres), 0, 0, 1)
        self.layer.transform = rotateTransform
        
        let animation = Init(CABasicAnimation(keyPath: "strokeEnd")) {
            $0.duration = duration
            $0.fromValue = (0)
            $0.toValue = (1)
        }
        circle?.addAnimation(animation, forKey: nil)
    }
}
