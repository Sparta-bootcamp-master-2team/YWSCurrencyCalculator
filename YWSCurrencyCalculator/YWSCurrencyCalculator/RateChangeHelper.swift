//
//  RateChangeHelper.swift
//  YWSCurrencyCalculator
//
//  Created by 양원식 on 4/24/25.
//
import Foundation

struct RateChangeHelper {
    static func direction(for code: String, newRate: Double) -> RateChangeDirection {
        if let cached = CoreDataManager.shared.getCachedRateObject(for: code) {
            print("[DEBUG] \(code): cached.rate = \(cached.rate), previousRate = \(cached.previousRate?.doubleValue ?? -999)")

            if let oldRate = cached.previousRate?.doubleValue {
                let diff = newRate - oldRate
                print("[DEBUG] \(code): old=\(oldRate), new=\(newRate), diff=\(diff)")

                if abs(diff) <= 0.01 {
                    return .same
                }
                return diff > 0 ? .up : .down
            } else {
                print("[DEBUG] \(code): previousRate is nil")
                return .same
            }
        } else {
            print("[DEBUG] \(code): no CachedRate object found")
            return .same
        }
    }
}


