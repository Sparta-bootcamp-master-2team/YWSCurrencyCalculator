//
//  YWSCurrencyCalculatorTests.swift
//  YWSCurrencyCalculatorTests
//
//  Created by 양원식 on 4/15/25.
//

import XCTest
@testable import YWSCurrencyCalculator

/// `ExchangeRateViewController`의 주요 UI 동작 및 필터링 기능을 검증하는 테스트 클래스입니다.
class ExchangeRateViewControllerTests: XCTestCase {
    
    /// 테스트 대상인 뷰컨트롤러
    var viewController: ExchangeRateViewController!

    /// 테스트 실행 전 뷰컨트롤러를 초기화하고 뷰를 로드합니다.
    override func setUp() {
        super.setUp()
        viewController = ExchangeRateViewController()
        viewController.loadViewIfNeeded()
    }

    /// 테스트 종료 후 뷰컨트롤러 인스턴스를 정리합니다.
    override func tearDown() {
        viewController = nil
    }

    /// `filteredRates`에 저장된 데이터 개수와 테이블뷰 셀 개수가 일치하는지 검증합니다.
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

    /// API 요청 실패 시 `showErrorAlert()`를 호출하면 Alert이 정상적으로 표시되는지 검증합니다.
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

    /// 검색어 입력 시 통화 코드 또는 국가명을 기준으로 필터링이 정상 작동하는지 확인합니다.
    func test_searchBar_filtersCurrencyByCodeOrCountry() {
        // given
        let testData: [(String, Double)] = [("KRW", 1350.0), ("JPY", 151.2), ("USD", 1.0)]
        viewController.setValue(testData, forKey: "exchangeRates")
        viewController.setValue(testData, forKey: "filteredRates")
        let searchBar = (viewController.view as? ExchangeRateView)?.searchBar

        // when
        viewController.searchBar(searchBar!, textDidChange: "KR")

        // then
        let filtered = viewController.value(forKey: "filteredRates") as? [(String, Double)]
        XCTAssertEqual(filtered?.count, 1)
        XCTAssertEqual(filtered?.first?.0, "KRW")
    }

    /// 검색어가 결과와 일치하지 않을 경우 `"검색 결과 없음"` 셀 하나만 표시되는지 확인합니다.
    func test_searchBar_filtersEmptyResult() {
        // given
        let testData: [(String, Double)] = [("KRW", 1350.0), ("JPY", 151.2), ("USD", 1.0)]
        viewController.setValue(testData, forKey: "exchangeRates")
        viewController.setValue(testData, forKey: "filteredRates")
        let searchBar = (viewController.view as? ExchangeRateView)?.searchBar

        // when
        viewController.searchBar(searchBar!, textDidChange: "없는값")

        // then
        let filtered = viewController.value(forKey: "filteredRates") as? [(String, Double)]
        XCTAssertEqual(filtered?.count, 0)

        let tableView = (viewController.view as? ExchangeRateView)?.tableView
        let count = viewController.tableView(tableView!, numberOfRowsInSection: 0)
        XCTAssertEqual(count, 1) // "검색 결과 없음" 셀
    }
}

