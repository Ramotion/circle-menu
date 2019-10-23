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
            red: 1.0 / 255.0 * CGFloat(red),
            green: 1.0 / 255.0 * CGFloat(green),
            blue: 1.0 / 255.0 * CGFloat(blue),
            alpha: CGFloat(alpha))
    }
}

class ViewController: UIViewController, CircleMenuDelegate {

    var colorForHome: UIColor {
        if #available(iOS 13, *) {
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return .systemTeal
            case .light, .unspecified:
                return .systemTeal
            @unknown default:
                return .systemTeal
            }
        }
        return UIColor(red: 0.19, green: 0.57, blue: 1, alpha: 1)
    }

    var colorForSearch: UIColor {
        if #available(iOS 13, *) {
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return .systemGreen
            case .light, .unspecified:
                return .systemGreen
            @unknown default:
                return .systemGreen
            }
        }
        return UIColor(red: 0.22, green: 0.74, blue: 0, alpha: 1)
    }

    var colorForNotifications: UIColor {
        if #available(iOS 13, *) {
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return .systemRed
            case .light, .unspecified:
                return .systemRed
            @unknown default:
                return .systemRed
            }
        }
        return UIColor(red: 0.96, green: 0.23, blue: 0.21, alpha: 1)
    }

    var colorForSettings: UIColor {
        if #available(iOS 13, *) {
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return .systemPurple
            case .light, .unspecified:
                return .systemPurple
            @unknown default:
                return .systemPurple
            }
        }
        return UIColor(red: 0.51, green: 0.15, blue: 1, alpha: 1)
    }

    var colorForNearby: UIColor {
        if #available(iOS 13, *) {
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return .systemOrange
            case .light, .unspecified:
                return .systemOrange
            @unknown default:
                return .systemOrange
            }
        }
        return UIColor(red: 1, green: 0.39, blue: 0, alpha: 1)
    }

    var colorForBackground: UIColor {
        if #available(iOS 13, *) {
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    return UIColor(named: "modeColors")!
                case .light, .unspecified:
                    return UIColor(named: "modeColors")!
                @unknown default:
                    return UIColor(named: "modeColors")!
                }
            } else {
                return UIColor(red: 0.059, green: 0.078, blue: 0.153, alpha: 1)
            }
        }

    var items: [(icon: String, color: UIColor)] = []

    // -------------------------------------------------------

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

        items = [
            ("icon_home", colorForHome),
            ("icon_search", colorForSearch),
            ("notifications-btn", colorForNotifications),
            ("settings-btn", colorForSettings),
            ("nearby-btn", colorForNearby)
        ]

        self.view.backgroundColor = colorForBackground

    }

    // MARK: <CircleMenuDelegate>

    func circleMenu(_: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        button.backgroundColor = items[atIndex].color

        button.setImage(UIImage(named: items[atIndex].icon), for: .normal)

        // set highlited image
        let highlightedImage = UIImage(named: items[atIndex].icon)?.withRenderingMode(.alwaysTemplate)
        button.setImage(highlightedImage, for: .highlighted)
        button.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    }

    func circleMenu(_: CircleMenu, buttonWillSelected _: UIButton, atIndex: Int) {
        print("button will selected: \(atIndex)")
    }

    func circleMenu(_: CircleMenu, buttonDidSelected _: UIButton, atIndex: Int) {
        print("button did selected: \(atIndex)")
    }
}
