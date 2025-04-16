//
//  Untitled.swift
//  YWSCurrencyCalculator
//
//  Created by 양원식 on 4/16/25.
//

import XCTest
@testable import YWSCurrencyCalculator

class CurrencyCellTests: XCTestCase {

    func test_configure_setsLabelsCorrectly() {
        // given
        let cell = CurrencyCell(style: .default, reuseIdentifier: "CurrencyCell")

        // when
        cell.configure(currency: "JPY", rate: 151.2124)

        // then
        // KVC 방식으로 private UILabel 접근
        let currencyLabel = cell.value(forKey: "currencyLabel") as? UILabel
        let rateLabel = cell.value(forKey: "rateLabel") as? UILabel

        XCTAssertEqual(currencyLabel?.text, "JPY")
        XCTAssertEqual(rateLabel?.text, "151.2124")
    }
}
