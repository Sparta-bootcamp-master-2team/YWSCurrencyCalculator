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
        // given
        let vc = CalculatorViewController(currencyCode: "USD", rate: 1350.0)

        // when
        _ = vc.view // viewDidLoad 실행

        // then
        XCTAssertEqual(vc.currencyCode, "USD")
        XCTAssertEqual(vc.rate, 1350.0)
    }
}
