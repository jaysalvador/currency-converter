//
//  WestpacUITests.swift
//  WestpacUITests
//
//  Created by Jay Salvador on 11/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import XCTest

class WestpacUITests: XCTestCase {
    
    // MARK: - Attributes
    
    var app: XCUIApplication!

    override func setUp() {
        
        self.app = XCUIApplication()
    }

    func testCurrencyTextFields() {
                
        self.app.launch()
        
        let textField = self.app.textFields.element
        
        textField.tap()
        app.keys["1"].tap()
        app.keys["0"].tap()
        app.keys["0"].tap()
        app.keys["0"].tap()
        app.keys["."].tap()
        app.keys["."].tap()
        app.keys["2"].tap()
        app.keys["5"].tap()
        
        XCTAssertEqual(textField.value as? String, "1000.25", "Invalid Number (1000.25)")
        
        let cell = self.app.collectionViews.cells["AED"]
        
        cell.tap()
        
        let audCell = self.app.collectionViews.cells["AUD"]
        let audTextField = audCell.textFields.element
        
        audTextField.tap()
        app.keys["Delete"].tap()
        app.keys["Delete"].tap()
        app.keys["Delete"].tap()
        
        XCTAssertEqual(audTextField.value as? String, "1000", "Invalid Number (1000)")
    }
    
    func testCurrencySwitch() {
        
        self.app.launch()
        
        let button = self.app.buttons.element
        
        button.tap()
        
        self.app.swipeUp()
        self.app.swipeUp()
        
        let phpCell = self.app.collectionViews.cells["PHP"]
        phpCell.tap()
        
        let label = self.app.staticTexts["currency"]
        
        XCTAssertEqual(label.label, "PHP", "Invalid Currency (PHP)")
        
        button.tap()
        
        self.app.swipeDown()
        self.app.swipeDown()
        self.app.swipeDown()
        
        let audCell = self.app.collectionViews.cells["BND"]
        audCell.tap()
        
        XCTAssertEqual(label.label, "BND", "Invalid Currency (BND)")
    }

    func testLaunchPerformance() {

        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {

            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
