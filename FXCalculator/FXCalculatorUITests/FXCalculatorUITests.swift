//
//  FXCalculatorUITests.swift
//  FXCalculatorUITests
//
//  Created by Animesh Mishra on 10/07/19.
//  Copyright © 2019 Animesh Mishra. All rights reserved.
//

import XCTest
@testable import FXCalculator

class FXCalculatorUITests: XCTestCase {
    var fxCalculatorApp: XCUIApplication!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        fxCalculatorApp = XCUIApplication()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTransactionModeSegment() {
        // Use recording to get started writing UI tests.
        fxCalculatorApp.launch()
        let app = fxCalculatorApp
        app?.segmentedControls["Selling"].buttons["Selling"].tap()
        app?.segmentedControls["Selling"].buttons["Buying"].tap()
        app?.staticTexts["Are you buying or selling foreign currency?"].tap()
    }
    
    func testTransactionTypeSegment() {
        fxCalculatorApp.launch()
        let app = fxCalculatorApp
        app?.segmentedControls["Cash"].buttons["Cash"].tap()
        app?.segmentedControls["Cash"].buttons["TelegraphicTransfer"].tap()
        app?.staticTexts["Transaction type:"].tap()
    }
    
    func testOtherCurrencyButton() {
        fxCalculatorApp.launch()
        let app = fxCalculatorApp
        app?.buttons["AED"].tap()
        app?.pickers.pickerWheels["AED (United Arab Emirates)"].swipeUp()
        app?.toolbars["Toolbar"].buttons["Done"].tap()
    }
    
    func testAlert() {
        fxCalculatorApp.launch()
        let app = fxCalculatorApp
        
        
        app?.otherElements.containing(.navigationBar, identifier:"FX Calculator").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).textFields["Enter Value"].tap()
        
        let key = app?.keyboards.keys[";"]
        key?.tap()
        app?.alerts["Incorrect Input"].buttons["OK"].tap()
    }
    
    func testPicker() {
        fxCalculatorApp.launch()
        let app = fxCalculatorApp
        app?.buttons["AED"].tap()
        app?.toolbars["Toolbar"].buttons["Done"].tap()
    }
    
    func testTextField() {
        fxCalculatorApp.launch()
        let app = fxCalculatorApp
        
        let element = app?.otherElements.containing(.navigationBar, identifier:"FX Calculator").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element?.children(matching: .other).element(boundBy: 0).textFields["Enter Value"].tap()
        
        let key = app?.keyboards.keys["1"]
        key?.tap()
        
        let key2 = app?.keyboards.keys["2"]
        key2?.tap()
        
        let returnButton = app?.keyboards.buttons["Return"]
        returnButton?.tap()
        element?.children(matching: .other).element(boundBy: 1).textFields["Enter Value"].tap()
        
        let deleteKey = app?.keyboards.keys["delete"]
        deleteKey?.tap()
        deleteKey?.tap()
        
        
        let key3 = app?.keyboards.keys["9"]
        key3?.tap()
        
        let key4 = app?.keyboards.keys["8"]
        key4?.tap()
        returnButton?.tap()
    }
}
