//
//  Untitled.swift
//  YWSCurrencyCalculator
//
//  Created by 양원식 on 4/24/25.
//

struct ExchangeRateData: Codable {
    let baseCode: String
    let lastUpdated: String
    let rates: [String: Double]

    enum CodingKeys: String, CodingKey {
        case baseCode = "base_code"
        case lastUpdated = "time_last_update_utc"
        case rates
    }
}
