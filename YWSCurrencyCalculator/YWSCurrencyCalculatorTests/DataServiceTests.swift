//
//  DataServiceTests.swift
//  YWSCurrencyCalculatorTests
//
//  Created by 양원식 on 4/15/25.
//

import XCTest
@testable import YWSCurrencyCalculator

final class DataServiceTests: XCTestCase {
    
    var dataService: DataService!
    
    override func setUpWithError() throws {
        dataService = DataService()
    }
    
    override func tearDownWithError() throws {
        dataService = nil
    }
    
    /// 실제 API에서 환율 데이터를 성공적으로 받아오는지 테스트
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
        
        // XCTest는 기본적으로 동기 테스트 기반이라 결과를 기다려주지 않으면 테스트가 끝나버려서 실패.
        wait(for: [expectation], timeout: 5.0)
    }
    
    /// 실패 상황 테스트 - 잘못된 URL을 가정
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
