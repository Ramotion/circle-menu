//
//  ViewController.swift
//  CircleMenu
//
//  Created by Alex K. on 27/01/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

extension UIColor {
  static func color(_ red: Int, green: Int, blue: Int, alpha: Float) -> UIColor {
    return UIColor(
      colorLiteralRed: Float(1.0) / Float(255.0) * Float(red),
      green: Float(1.0) / Float(255.0) * Float(green),
      blue: Float(1.0) / Float(255.0) * Float(blue),
      alpha: alpha)
  }
}

class ViewController: UIViewController, CircleMenuDelegate {
  
  //    let colors = [UIColor.redColor(), UIColor.grayColor(), UIColor.greenColor(), UIColor.purpleColor()]
  let items: [(icon: String, color: UIColor)] = [
    ("icon_home", UIColor(red:0.19, green:0.57, blue:1, alpha:1)),
    ("icon_search", UIColor(red:0.22, green:0.74, blue:0, alpha:1)),
    ("notifications-btn", UIColor(red:0.96, green:0.23, blue:0.21, alpha:1)),
    ("settings-btn", UIColor(red:0.51, green:0.15, blue:1, alpha:1)),
    ("nearby-btn", UIColor(red:1, green:0.39, blue:0, alpha:1)),
    ]
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // add button
    //        let button = CircleMenu(
    //            frame: CGRect(x: 200, y: 200, width: 50, height: 50),
    //            normalIcon:"icon_menu",
    //            selectedIcon:"icon_close",
    //            buttonsCount: 4,
    //            duration: 4,
    //            distance: 120)
    //        button.backgroundColor = UIColor.lightGrayColor()
    //        button.delegate = self
    //        button.layer.cornerRadius = button.frame.size.width / 2.0
    //        view.addSubview(button)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  // MARK: <CircleMenuDelegate>
  
  func circleMenu(_ circleMenu: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
    button.backgroundColor = items[atIndex].color
    
    button.setImage(UIImage(named: items[atIndex].icon), for: .normal)
    
    // set highlited image
    let highlightedImage  = UIImage(named: items[atIndex].icon)?.withRenderingMode(.alwaysTemplate)
    button.setImage(highlightedImage, for: .highlighted)
    button.tintColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.3)
  }
  
  func circleMenu(_ circleMenu: CircleMenu, buttonWillSelected button: UIButton, atIndex: Int) {
    print("button will selected: \(atIndex)")
  }
  
  func circleMenu(_ circleMenu: CircleMenu, buttonDidSelected button: UIButton, atIndex: Int) {
    print("button did selected: \(atIndex)")
  }
}
