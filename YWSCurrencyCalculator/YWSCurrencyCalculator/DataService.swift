//
//  DataService.swift
//  YWSCurrencyCalculator
//
//  Created by 양원식 on 4/15/25.
//

import Foundation

/// 네트워크 통신 중 발생할 수 있는 에러를 정의한 열거형입니다.
/// - Note: `Equatable`은 테스트 코드에서 비교를 가능하게 하기 위해 채택됩니다.
enum DataError: Error, Equatable {
    /// 로컬 파일을 찾을 수 없음
    case fileNotFound
    /// JSON 디코딩 실패
    case parsingFailed
    /// 유효하지 않은 URL
    case invalidURL
    /// HTTP 상태 코드가 200번대가 아님
    case badStatus(code: Int)
    /// 알 수 없는 에러
    case unknown
}

/// 실시간 환율 데이터를 가져오는 네트워크 서비스 클래스입니다.
/// 외부 API로부터 데이터를 받아 `ExchangeRateData` 모델로 디코딩하며,
/// 결과는 Result 타입의 클로저를 통해 전달됩니다.
class DataService {
    
    /// 환율 API로부터 데이터를 비동기로 가져옵니다.
    ///
    /// - Parameter completion: 결과를 반환하는 클로저입니다.
    /// 성공 시 `.success(ExchangeRateData)`를 반환하며,
    /// 실패 시 `.failure(DataError)` 또는 `Error`를 반환합니다.
    func fetchData(completion: @escaping (Result<ExchangeRateData, Error>) -> Void) {
        
        /// API의 기본 URL (USD 기준 환율)
        guard let url = URL(string: "https://open.er-api.com/v6/latest/USD") else {
            completion(.failure(DataError.invalidURL))
            return
        }
        
        // URLRequest 설정
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // 비동기 네트워크 요청
        URLSession.shared.dataTask(with: request) { data, response, error in
            let successRange = 200..<300
            
            // 네트워크 에러 발생 시
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // 응답 및 데이터 유효성 확인
            guard let data = data,
                  let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(DataError.unknown))
                return
            }
            
            // HTTP 상태 코드 확인
            guard successRange.contains(httpResponse.statusCode) else {
                completion(.failure(DataError.badStatus(code: httpResponse.statusCode)))
                return
            }
            
            // JSON 파싱 시도
            do {
                let decoded = try JSONDecoder().decode(ExchangeRateData.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(DataError.parsingFailed))
            }
        }.resume()
    }
}
