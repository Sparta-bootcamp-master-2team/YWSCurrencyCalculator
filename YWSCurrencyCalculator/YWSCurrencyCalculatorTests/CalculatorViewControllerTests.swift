//
//  CalculatorViewControllerTests.swift
//  YWSCurrencyCalculator
//
//  Created by 양원식 on 4/17/25.
//

import XCTest
@testable import YWSCurrencyCalculator

final class CalculatorViewControllerTests: XCTestCase {
    
    func test_초기화시_전달받은_데이터가_정상적으로_세팅되는지() {
        let vc = CalculatorViewController(currencyCode: "USD", rate: 1350.0)
        _ = vc.view
        XCTAssertEqual(vc.currencyCode, "USD")
        XCTAssertEqual(vc.rate, 1350.0)
    }
    
    func test_빈_입력시_Alert_표시된다() {
        let vc = CalculatorViewController(currencyCode: "KRW", rate: 1350.0)
        _ = vc.view
        vc.calculatorView.amountTextField.text = ""
        vc.perform(Selector(("handleConvert")))
        
        let alert = vc.presentedViewController as? UIAlertController
        XCTAssertEqual(alert?.message, "금액을 입력해주세요")
    }
    
    func test_숫자가_아닌_입력시_Alert_표시된다() {
        let vc = CalculatorViewController(currencyCode: "KRW", rate: 1350.0)
        _ = vc.view
        vc.calculatorView.amountTextField.text = "abc"
        vc.perform(Selector(("handleConvert")))
        
        let alert = vc.presentedViewController as? UIAlertController
        XCTAssertEqual(alert?.message, "올바른 숫자를 입력해주세요")
    }
    
    func test_정상입력시_결과_정상출력() {
        let vc = CalculatorViewController(currencyCode: "KRW", rate: 1350.0)
        _ = vc.view
        vc.calculatorView.amountTextField.text = "2"
        vc.perform(Selector(("handleConvert")))
        
        let result = vc.calculatorView.resultLabel.text
        XCTAssertEqual(result, "2.00 USD = 2700.00 KRW")
    }
}
