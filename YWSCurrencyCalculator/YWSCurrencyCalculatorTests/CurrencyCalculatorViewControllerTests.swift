//
//  YWSCurrencyCalculatorTests.swift
//  YWSCurrencyCalculatorTests
//
//  Created by 양원식 on 4/15/25.
//

import XCTest
@testable import YWSCurrencyCalculator

class CurrencyCalculatorViewControllerTests: XCTestCase {
    
    var viewController: CurrencyCalculatorViewController!

    override func setUp() {
        super.setUp()
        viewController = CurrencyCalculatorViewController()
        viewController.loadViewIfNeeded()
    }

    // 셀 개수 확인
    func test_numberOfRows_matchesExchangeRatesCount() {
        // given
        let testData: [(String, Double)] = [("USD", 1.0), ("KRW", 1350.23)]
        viewController.setValue(testData, forKey: "exchangeRates")  // private 접근 회피용

        let tableView = (viewController.view as? CurrencyCalculatorView)?.tableView

        // when
        let count = viewController.tableView(tableView!, numberOfRowsInSection: 0)

        // then
        XCTAssertEqual(count, testData.count)
    }

    // Alert 표시 확인
    func test_showErrorAlert_presentsAlert() {
        // given
        viewController.loadViewIfNeeded()

        // when (private func 강제 호출)
        viewController.perform(Selector(("showErrorAlert")))

        // then
        let expectation = XCTestExpectation(description: "Alert should be presented")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let presented = self.viewController.presentedViewController as? UIAlertController
            XCTAssertNotNil(presented)
            XCTAssertEqual(presented?.title, "오류")
            XCTAssertEqual(presented?.message, "데이터를 불러올 수 없습니다.")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
}

