//
//  abacusTests.swift
//  abacusTests
//
//  Created by marcio vinicius dos santos on 28/03/15.
//  Copyright (c) 2015 marcio vinicius dos santos. All rights reserved.
//

import UIKit
import XCTest
import abacus

class abacusTests: XCTestCase {
    
    func testDigitShouldAppendsDigits() {
        var expression = Digit(string: "9")
        XCTAssertEqual("9", expression.display())
        
        expression.addDigit(Digit(string: "1"))
        XCTAssertEqual("91", expression.display())
        
        
        expression.addDigit(Digit(string: "0"))
        XCTAssertEqual("910", expression.display())
    }
    
    func testDigitReturnsItselfAsResult() {
        var digit = Digit(string: "9")
        var result = digit.addEqualsSign()
        
        XCTAssertEqual("9", result.display())
        
        result = digit.addEqualsSign()
        XCTAssertEqual("9", result.display())
        
    }
    
    func testSignShouldDisplaysItsFirstElementWhenThereIsntSecondElement() {
        var digit = Digit(string: "5")
        var Sign = PlusSign()
        XCTAssertEqual("0", Sign.display())
        
        var newSign = digit.addSign(Sign)
        
        XCTAssertEqual("5", newSign.display())
    }
    
    func testSignShouldDisplaysItsSecondElementWhenItExists() {
        var digit = Digit(string: "5")
        var Sign = PlusSign()
        
        var SignWithFirstElement = digit.addSign(Sign)
        SignWithFirstElement.addDigit(Digit(number: 33))
        
        XCTAssertEqual("33", SignWithFirstElement.display())
    }
    
    func testSignShouldGenerateResults() {
        var digit = Digit(string: "5")
        var sign = PlusSign()
        
        var SignWithFirstElement = digit.addSign(sign)
        SignWithFirstElement.addDigit(Digit(number: 33))
        
        XCTAssertEqual("33", SignWithFirstElement.display())
        
        var result = SignWithFirstElement.addEqualsSign()
        XCTAssertEqual("38", result.display())
        
        result = result.addSign(MinusSign())
        
        XCTAssertEqual("38", result.display())
        
        result.addDigit(Digit(number: 10))
        
        XCTAssertEqual("10", result.display())
        
        
        result = result.addEqualsSign()
        
        XCTAssertEqual("28", result.display())
    }
    
    func testEqualsSignShouldRepeatLastNumber(){
        var expression: Expression = Digit(number: 31)
        expression = expression.addEqualsSign()
        
        XCTAssertEqual("31", expression.display())
        
        expression = expression.addEqualsSign()
        
        XCTAssertEqual("31", expression.display())
        
        expression = expression.addDigit(Digit(number: 22))
        
        XCTAssertEqual("22", expression.display())
        
        expression = expression.addEqualsSign()
        
        XCTAssertEqual("22", expression.display())
        
        expression = Digit(number: 2)
        expression = expression.addSign(PlusSign())
        expression = expression.addEqualsSign()
        
        XCTAssertEqual("2", expression.display())
        
        expression = expression.addEqualsSign()
        
        XCTAssertEqual("2", expression.display())
    }
    
    func testMultipleOperationsTogether(){
        var expression: Expression = Digit(string: "3")
        XCTAssertEqual("3", expression.display())
        
        expression = expression.addDigit(Digit(string: "6"))
        XCTAssertEqual("36", expression.display())
        
        expression = expression.addSign(DivideSign())
        XCTAssertEqual("36", expression.display())
        
        expression = expression.addDigit(Digit(string: "3"))
        XCTAssertEqual("3", expression.display())
        
        expression = expression.addSign(TimesSign())
        XCTAssertEqual("12", expression.display())
        
        expression = expression.addDigit(Digit(string: "2"))
        XCTAssertEqual("2", expression.display())
        
        expression = expression.addEqualsSign()
        XCTAssertEqual("24", expression.display())
        
    }
    
    func testMultipleOperationsTogetherBetweenEquals(){
        var expression: Expression = Digit(number: 13)
        XCTAssertEqual("13", expression.display())
        
        expression = expression.addSign(DivideSign())
        XCTAssertEqual("13", expression.display())
        
        expression = expression.addDigit(Digit(string: "2"))
        XCTAssertEqual("2", expression.display())
        
        expression = expression.addEqualsSign()
        XCTAssertEqual("6.5", expression.display())
        
        expression = expression.addEqualsSign()
        XCTAssertEqual("6.5", expression.display())
        
        expression = expression.addDigit(Digit(string: "2"))
        XCTAssertEqual("2", expression.display())
        
        expression = expression.addDigit(Digit(string: "0"))
        XCTAssertEqual("20", expression.display())
        
        expression = expression.addEqualsSign()
        XCTAssertEqual("20", expression.display())
        
    }
    
    func testDot() {
        var expression: Expression = Digit(number: 13)
        XCTAssertEqual("13", expression.display())
        
        expression = expression.addDot()
        XCTAssertEqual("13.0", expression.display())
        
        expression = expression.addDigit(Digit(string: "2"))
        XCTAssertEqual("13.2", expression.display())
        
        expression = expression.addDigit(Digit(string: "4"))
        XCTAssertEqual("13.24", expression.display())
        
        expression = expression.addDigit(Digit(string: "5"))
        XCTAssertEqual("13.245", expression.display())
        
        expression = expression.addDot()
        XCTAssertEqual("13.245", expression.display())
        
        expression = expression.addSign(TimesSign())
        XCTAssertEqual("13.245", expression.display())
        
        expression = expression.addDigit(Digit(string: "2"))
        XCTAssertEqual("2", expression.display())
        
        expression = expression.addEqualsSign()
        XCTAssertEqual("26.49", expression.display())
    }
    
}
