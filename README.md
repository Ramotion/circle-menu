![header](./header.png)
<img src="https://github.com/Ramotion/circle-menu/blob/master/circle-menu.gif" width="600" height="450" />
<br><br/>

# CircleMenu
[![Twitter](https://img.shields.io/badge/Twitter-@Ramotion-blue.svg?style=flat)](http://twitter.com/Ramotion)
[![CocoaPods](https://img.shields.io/cocoapods/p/CircleMenu.svg)](https://cocoapods.org/pods/CircleMenu)
[![CocoaPods](https://img.shields.io/cocoapods/v/CircleMenu.svg)](http://cocoapods.org/pods/CircleMenu)
[![CocoaPods](https://img.shields.io/cocoapods/metrics/doc-percent/CircleMenu.svg)](https://cdn.rawgit.com/Ramotion/circle-menu/master/docs/index.html)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Ramotion/circle-menu)
[![codebeat badge](https://codebeat.co/badges/6f67da5d-c416-4bac-9fb7-c2dc938feedc)](https://codebeat.co/projects/github-com-ramotion-circle-menu)
[![Travis](https://img.shields.io/travis/Ramotion/circle-menu.svg)](https://travis-ci.org/Ramotion/circle-menu)
[![Donate](https://img.shields.io/badge/Donate-PayPal-blue.svg)](https://paypal.me/Ramotion)

# Check this library on other platforms:
<a href="https://github.com/Ramotion/circle-menu-android"> 
<img src="https://github.com/ramotion/navigation-stack/raw/master/Android_Java@2x.png" width="178" height="81"></a>
<a href="https://github.com/Ramotion/react-native-circle-menu"> 
<img src="https://github.com/ramotion/navigation-stack/raw/master/React Native@2x.png" width="178" height="81"></a>

**Looking for developers for your project?**<br>
This project is maintained by Ramotion, Inc. We specialize in the designing and coding of custom UI for Mobile Apps and Websites.

<a href="mailto:alex.a@ramotion.com?subject=Project%20inquiry%20from%20Github">
<img src="https://github.com/ramotion/gliding-collection/raw/master/contact_our_team@2x.png" width="187" height="34"></a> <br>


The [iPhone mockup](https://store.ramotion.com/product/iphone-x-clay-mockups?utm_source=gthb&utm_medium=special&utm_campaign=circle-menu) available [here](https://store.ramotion.com?utm_source=gthb&utm_medium=special&utm_campaign=circle-menu).

## Try this UI control in action

<a href="https://itunes.apple.com/app/apple-store/id1182360240?pt=550053&ct=gthb-circle-menu&mt=8" > <img src="https://github.com/Ramotion/navigation-stack/raw/master/Download_on_the_App_Store_Badge_US-UK_135x40.png" width="170" height="58"></a>

## Requirements

- iOS 9.0+
- Xcode 9.0.1

## Installation

Just add CircleMenuLib folder to your project.

or use [CocoaPods](https://cocoapods.org) with Podfile:

```ruby
pod 'CircleMenu'
```
or [Carthage](https://github.com/Carthage/Carthage) users can simply add to their `Cartfile`:
```
github "Ramotion/circle-menu"
```

## Usage

##### with storyboard

1) Create a new UIButton inheriting from `CircleMenu`

2) Add images for Normal and Selected state

3) Use delegate method to configure buttons

```swift
func circleMenu(circleMenu: CircleMenu, willDisplay button: UIButton, atIndex: Int)
```

4) Use properties to confiure CircleMenu

```swift
@IBInspectable var buttonsCount: Int = 3
@IBInspectable var duration: Double = 2 // circle animation duration
@IBInspectable var distance: Float = 100 // distance between center button and buttons
```

##### programmatically

```swift
let button = CircleMenu(
  frame: CGRect(x: 200, y: 200, width: 50, height: 50),
  normalIcon:"icon_menu",
  selectedIcon:"icon_close",
  buttonsCount: 4,
  duration: 4,
  distance: 120)
button.delegate = self
button.layer.cornerRadius = button.frame.size.width / 2.0
view.addSubview(button)
```

##### delegate methods

```swift
// configure buttons
optional func circleMenu(circleMenu: CircleMenu, willDisplay button: UIButton, atIndex: Int)

// call before animation
optional func circleMenu(circleMenu: CircleMenu, buttonWillSelected button: UIButton, atIndex: Int)

// call after animation
optional func circleMenu(circleMenu: CircleMenu, buttonDidSelected button: UIButton, atIndex: Int)

// call upon cancel of the menu - fires immediately on button press
optional func menuCollapsed(circleMenu: CircleMenu)

// call upon opening of the menu - fires immediately on button press
optional func menuOpened(circleMenu: CircleMenu)
```


This library is a part of a <a href="https://github.com/Ramotion/swift-ui-animation-components-and-libraries"><b>selection of our best UI open-source projects.</b></a>

## Licence

Circle menu is released under the MIT license.
See [LICENSE](./LICENSE) for details.
<br>

# Get the Showroom App for iOS and Android to give it a try
Try this UI component and more like this in our mobile app. Contact us if interested.

<a href="https://itunes.apple.com/app/apple-store/id1182360240?pt=550053&ct=circle-menu&mt=8" >
<img src="https://github.com/ramotion/gliding-collection/raw/master/app_store@2x.png" width="117" height="34"></a>
<a href="mailto:alex.a@ramotion.com?subject=Project%20inquiry%20from%20Github">
<img src="https://github.com/ramotion/gliding-collection/raw/master/contact_our_team@2x.png" width="187" height="34"></a>
<br>
<br>

Follow us for the latest updates<br>
<a href="https://goo.gl/rPFpid" >
<img src="https://i.imgur.com/ziSqeSo.png/" width="156" height="28"></a>
