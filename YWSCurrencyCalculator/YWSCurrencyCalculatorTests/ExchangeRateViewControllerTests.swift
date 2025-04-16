//
//  YWSCurrencyCalculatorTests.swift
//  YWSCurrencyCalculatorTests
//
//  Created by 양원식 on 4/15/25.
//

import XCTest
@testable import YWSCurrencyCalculator

class ExchangeRateViewControllerTests: XCTestCase {
    
    var viewController: ExchangeRateViewController!

    override func setUp() {
        super.setUp()
        viewController = ExchangeRateViewController()
        viewController.loadViewIfNeeded()
    }

    override func tearDown() {
        viewController = nil
    }

    /// filteredRates 기준으로 셀 개수 확인
    func test_numberOfRows_matchesFilteredRatesCount() {
        // given
        let testData: [(String, Double)] = [("USD", 1.0), ("KRW", 1350.23)]
        viewController.setValue(testData, forKey: "exchangeRates")
        viewController.setValue(testData, forKey: "filteredRates")

        let tableView = (viewController.view as? ExchangeRateView)?.tableView

        // when
        let count = viewController.tableView(tableView!, numberOfRowsInSection: 0)

        // then
        XCTAssertEqual(count, testData.count)
    }

    /// Alert 정상 노출 테스트
    func test_showErrorAlert_presentsAlert() {
        // when
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

    /// 검색어 입력 시 필터링 되는지
    func test_searchBar_filtersCurrencyByCodeOrCountry() {
        let testData: [(String, Double)] = [("KRW", 1350.0), ("JPY", 151.2), ("USD", 1.0)]
        viewController.setValue(testData, forKey: "exchangeRates")
        viewController.setValue(testData, forKey: "filteredRates")

        let searchBar = (viewController.view as? ExchangeRateView)?.searchBar

        viewController.searchBar(searchBar!, textDidChange: "KR")

        let filtered = viewController.value(forKey: "filteredRates") as? [(String, Double)]
        XCTAssertEqual(filtered?.count, 1)
        XCTAssertEqual(filtered?.first?.0, "KRW")
    }

    /// 검색 결과 없음일 때 셀 하나만 보여야 함
    func test_searchBar_filtersEmptyResult() {
        let testData: [(String, Double)] = [("KRW", 1350.0), ("JPY", 151.2), ("USD", 1.0)]
        viewController.setValue(testData, forKey: "exchangeRates")
        viewController.setValue(testData, forKey: "filteredRates")

        let searchBar = (viewController.view as? ExchangeRateView)?.searchBar

        viewController.searchBar(searchBar!, textDidChange: "없는값")

        let filtered = viewController.value(forKey: "filteredRates") as? [(String, Double)]
        XCTAssertEqual(filtered?.count, 0)

        let tableView = (viewController.view as? ExchangeRateView)?.tableView
        let count = viewController.tableView(tableView!, numberOfRowsInSection: 0)
        XCTAssertEqual(count, 1) // "검색 결과 없음" 셀
    }
}
