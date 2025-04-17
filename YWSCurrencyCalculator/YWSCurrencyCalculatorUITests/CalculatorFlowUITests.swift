//
//  YWSCurrencyCalculatorUITests.swift
//  YWSCurrencyCalculatorUITests
//
//  Created by 양원식 on 4/15/25.
//

import XCTest

final class CalculatorFlowUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    /// 셀 탭 시 환율 계산기 화면으로 전환되는지 테스트
    func test_셀_탭시_환율_계산기_화면으로_전환된다() {
        let table = app.tables.element
        XCTAssertTrue(table.exists)

        let firstCell = table.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists)
        firstCell.tap()

        let navBar = app.navigationBars["환율 계산기"]
        XCTAssertTrue(navBar.waitForExistence(timeout: 2))
    }

    /// 계산기 화면에서 통화 코드가 표시되는지 테스트
    func test_계산기_화면에_통화코드_표시된다() {
        let firstCell = app.tables.cells.element(boundBy: 0)
        firstCell.tap()

        let currencyLabel = app.staticTexts["USD"]
        XCTAssertTrue(currencyLabel.waitForExistence(timeout: 2))
    }

    /// 계산기 화면 UI 요소들(입력창, 버튼, 결과) 존재 여부 테스트
    func test_계산기_화면_UI_컴포넌트_존재여부() {
        let firstCell = app.tables.cells.element(boundBy: 0)
        firstCell.tap()

        XCTAssertTrue(app.textFields["금액을 입력하세요"].exists)
        XCTAssertTrue(app.buttons["변환"].exists)
        XCTAssertTrue(app.staticTexts["USD"].exists)
    }

    /// 계산기에서 2달러 입력 시 환율 결과가 표시되는지 테스트
    func test_환율계산_결과가_정상적으로_표시된다() {
        let firstCell = app.tables.cells.element(boundBy: 0)
        firstCell.tap()

        let inputField = app.textFields["금액을 입력하세요"]
        XCTAssertTrue(inputField.exists)
        inputField.tap()
        inputField.typeText("2")

        let convertButton = app.buttons["변환"]
        XCTAssertTrue(convertButton.exists)
        convertButton.tap()

        let resultLabel = app.staticTexts["환율결과"]
        XCTAssertTrue(resultLabel.waitForExistence(timeout: 2))
        XCTAssertTrue(resultLabel.label.contains("2"))
    }
}
