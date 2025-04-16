//
//  Untitled.swift
//  YWSCurrencyCalculator
//
//  Created by 양원식 on 4/16/25.
//

import XCTest
@testable import YWSCurrencyCalculator

class ExchangeRateCellTests: XCTestCase {

    func test_configure_setsLabelsCorrectly() {
        // given
        let cell = ExchangeRateCell(style: .default, reuseIdentifier: "ExchangeRateCell")

        // when
        cell.configure(currency: "JPY", rate: 151.2124)

        // then
        let currencyLabel = cell.value(forKey: "currencyLabel") as? UILabel
        let countryLabel = cell.value(forKey: "countryLabel") as? UILabel
        let rateLabel = cell.value(forKey: "rateLabel") as? UILabel

        XCTAssertEqual(currencyLabel?.text, "JPY")
        XCTAssertEqual(countryLabel?.text, "일본") // CurrencyCountryMapper에서 반환된 국가명
        XCTAssertEqual(rateLabel?.text, "151.2124")
    }
}

