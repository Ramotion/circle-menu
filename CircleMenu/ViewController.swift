//
//  ViewController.swift
//  CircleMenu
//
//  Created by Alex K. on 27/01/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

extension UIColor {
    static func color(red: Int, green: Int, blue: Int, alpha: Float) -> UIColor {
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
                                                    ("icon_back", UIColor.color(234, green: 183, blue: 84, alpha: 1)),
                                                    ("icon_play", UIColor.color(229, green: 94, blue: 75, alpha: 1)),
                                                    ("icon_replay", UIColor.color(99, green: 186, blue: 51, alpha: 1)),
                                                    ("icon_close", UIColor.color(32, green: 164, blue: 203, alpha: 1)),
                                                  ]
    override func viewDidLoad() {
        super.viewDidLoad()

        // add button
        
//        let button = CircleMenu(
//            frame: CGRect(x: 200, y: 200, width: 50, height: 50),
//            normalIcon:"icon_menu",
//            selectedIcon:"icon_close",
//            buttonsCount: 5,
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
    
    func circleMenu(circleMenu: CircleMenu, willDisplay button: CircleMenuButton, atIndex: Int) {
        button.backgroundColor = items[atIndex].color
        button.setImage(UIImage(imageLiteral: items[atIndex].icon), forState: .Normal)
    }
}
