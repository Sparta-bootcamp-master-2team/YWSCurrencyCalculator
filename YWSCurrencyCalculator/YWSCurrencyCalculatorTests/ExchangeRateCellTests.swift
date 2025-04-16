//
//  Untitled.swift
//  YWSCurrencyCalculator
//
//  Created by 양원식 on 4/16/25.
//

import XCTest
@testable import YWSCurrencyCalculator

/// `ExchangeRateCell`의 `configure(currency:rate:)` 메서드에 대한 단위 테스트입니다.
/// - 셀 내부의 UILabel들이 전달된 데이터로 올바르게 설정되는지 검증합니다.
class ExchangeRateCellTests: XCTestCase {
    
    /// `configure(currency:rate:)` 메서드 호출 시
    /// 통화 코드, 국가명, 환율 값이 각 레이블에 정확하게 반영되는지 테스트합니다.
    ///
    /// - 예상 결과:
    ///   - currencyLabel: "JPY"
    ///   - countryLabel: "일본" (ExchangeRateMapper 사용)
    ///   - rateLabel: "151.2124" (소수점 4자리 포맷팅)
    ///
    /// - 주의: `private` 접근 제어자가 적용된 레이블들에 접근하기 위해 `KVC (Key-Value Coding)`을 사용합니다.
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
        XCTAssertEqual(countryLabel?.text, "일본") // ExchangeRateMapper 기준
        XCTAssertEqual(rateLabel?.text, "151.2124")
    }
}


