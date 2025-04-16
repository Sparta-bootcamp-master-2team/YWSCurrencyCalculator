//
//  DataServiceTests.swift
//  YWSCurrencyCalculatorTests
//
//  Created by 양원식 on 4/15/25.
//

import XCTest
@testable import YWSCurrencyCalculator

/// `DataService`의 API 통신 기능을 검증하는 테스트 클래스입니다.
/// - 정상적으로 데이터를 받아오는지, 오류 상황에서 적절히 실패하는지를 테스트합니다.
final class DataServiceTests: XCTestCase {
    
    /// 테스트 대상인 `DataService` 인스턴스
    var dataService: DataService!
    
    // MARK: - Setup & Teardown
    
    /// 각 테스트 실행 전 호출되어 `DataService` 인스턴스를 초기화합니다.
    override func setUpWithError() throws {
        dataService = DataService()
    }
    
    /// 각 테스트 실행 후 호출되어 `DataService` 인스턴스를 해제합니다.
    override func tearDownWithError() throws {
        dataService = nil
    }
    
    // MARK: - Test Cases
    
    /// 실제 API를 통해 환율 데이터를 성공적으로 받아오는지 테스트합니다.
    ///
    /// - 성공 시:
    ///   - `baseCode`는 "USD" 여야 합니다.
    ///   - `rates` 딕셔너리는 비어 있으면 안 됩니다.
    /// - 실패 시:
    ///   - 테스트는 실패합니다.
    func testFetchExchangeRate_Success() {
        // 비동기 처리 대기용 expectation 생성
        let expectation = XCTestExpectation(description: "환율 데이터를 성공적으로 받아옴")
        
        dataService.fetchData { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.baseCode, "USD", "기준 통화는 USD여야 합니다")
                XCTAssertFalse(data.rates.isEmpty, "rates 딕셔너리가 비어 있으면 안 됩니다")
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail("API 요청 실패: \(error.localizedDescription)")
            }
        }
        
        // 비동기 결과를 기다림
        wait(for: [expectation], timeout: 5.0)
    }
    
    /// 실패 상황 테스트 - 잘못된 URL이 주어졌을 때 실패가 발생하는지 검증합니다.
    ///
    /// `BadDataService`라는 Mock 클래스를 만들어 실패를 유도합니다.
    /// - 실패 시 반환되는 에러가 `.invalidURL`이어야 합니다.
    func testFetchExchangeRate_Failure_invalidURL() {
        let expectation = XCTestExpectation(description: "잘못된 URL로 인해 실패해야 함")
        
        /// 실패를 유도하기 위한 Mock 클래스
        class BadDataService: DataService {
            override func fetchData(completion: @escaping (Result<ExchangeRateData, Error>) -> Void) {
                completion(.failure(DataError.invalidURL))
            }
        }
        
        let badService = BadDataService()
        
        badService.fetchData { result in
            switch result {
            case .success:
                XCTFail("성공하면 안 됩니다. 실패해야 합니다.")
            case .failure(let error):
                if let dataError = error as? DataError {
                    XCTAssertEqual(dataError, DataError.invalidURL)
                } else {
                    XCTFail("예상치 못한 에러 타입: \(error)")
                }
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
}

