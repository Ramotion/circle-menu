//
//  CircleMenuTests.swift
//  CircleMenuTests
//
//  Created by Alex K. on 27/01/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

@testable import CircleMenu
import XCTest

class CircleMenuTests: XCTestCase {

    let buttonsCount = 4

    let circleMenu = CircleMenu(
        frame: CGRect(x: 200, y: 200, width: 50, height: 50),
        normalIcon: "icon_menu",
        selectedIcon: "icon_close",
        buttonsCount: 4,
        duration: 4,
        distance: 120)

    let view = UIView()

    override func setUp() {
        super.setUp()
        circleMenu.buttonsCount = buttonsCount
        view.addSubview(circleMenu)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testCircleMenuShowButtons() {
        // given
        XCTAssertNil(circleMenu.buttons, "button doesn't create")

        // when button tap
        circleMenu.onTap()

        // then
        XCTAssertEqual(circleMenu.buttons?.count, buttonsCount, "button is created")
    }

    func testCircleMenuHideButtons() {
        // given
        circleMenu.onTap()

        // when
        circleMenu.onTap()

        // then
        XCTAssertNil(circleMenu.buttons, "button is removed")
    }

    func testCircleMenuHideButtonsAfterAnimation() {
        // given
        circleMenu.onTap()

        // when
        circleMenu.buttonHandler((circleMenu.buttons?.first)! as! CircleMenuButton)

        // then
        XCTAssertNil(circleMenu.buttons, "button is removed")
    }
}
