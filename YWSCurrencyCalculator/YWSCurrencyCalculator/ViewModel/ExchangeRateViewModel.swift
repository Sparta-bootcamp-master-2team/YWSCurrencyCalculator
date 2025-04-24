//
//  ExchangeRateViewModel.swift
//  YWSCurrencyCalculator
//
//  Created by 양원식 on 4/18/25.
//

import Foundation

final class ExchangeRateViewModel: ViewModelProtocol {
    enum Action {
        case fetch
        case search(query: String)
    }

    struct State {
        var isLoading: Bool = false
        var filteredRates: [(String, Double)] = []
        var errorMessage: String? = nil
    }

    var state: ((State) -> Void)?
    private(set) var currentState: State = .init()

    private var allRates: [(String, Double)] = []
    private let service = DataService()

    private var favorites: Set<String> = []

    private func sortRates(_ rates: [String: Double]) -> [(String, Double)] {
        rates.map { ($0.key, $0.value) }
            .sorted {
                let isFav1 = favorites.contains($0.0)
                let isFav2 = favorites.contains($1.0)
                if isFav1 && !isFav2 { return true }
                if !isFav1 && isFav2 { return false }
                return $0.0 < $1.0
            }
    }

    func send(action: Action) {
        switch action {
        case .fetch:
            currentState.isLoading = true
            state?(currentState)
            service.fetchData { [weak self] result in
                DispatchQueue.main.async {
                    guard let self else { return }
                    switch result {
                    case .success(let data):
                        self.favorites = Set(CoreDataManager.shared.getAllFavorites())

                        var manipulatedRates = data.rates

                        #if DEBUG
                        manipulatedRates["AED"] = 3.70
                        manipulatedRates["AFN"] = 72.5
                        manipulatedRates["ALL"] = 84.9
                        manipulatedRates["AMD"] = 391.8
                        manipulatedRates["ANG"] = 1.77
                        manipulatedRates["AOA"] = 925.0
                        manipulatedRates["ARS"] = 1100.0
                        manipulatedRates["AUD"] = 1.54
                        manipulatedRates["AWG"] = 1.80
                        #endif

                        let updatedRates = manipulatedRates.map { code, newRate -> (String, Double) in
                            #if DEBUG
                            if code == "USD" {
                                print("[MOCK] \(code) 적용 중: \(newRate)")
                            }
                            #endif

                            let _ = RateChangeHelper.direction(for: code, newRate: newRate)
                            CoreDataManager.shared.updateOrInsertRate(code: code, newRate: newRate)
                            return (code, newRate)
                        }

                        let sorted = self.sortRates(Dictionary(uniqueKeysWithValues: updatedRates))
                        self.allRates = sorted
                        self.currentState = State(isLoading: false, filteredRates: sorted)
                        self.state?(self.currentState)


                    case .failure:
                        self.currentState = State(isLoading: false, filteredRates: [], errorMessage: "데이터를 불러올 수 없습니다.")
                        self.state?(self.currentState)
                    }
                }
            }

        case .search(let query):
            if query.isEmpty {
                currentState.filteredRates = sortRates(Dictionary(uniqueKeysWithValues: allRates))
            } else {
                let filtered = allRates.filter { (code, _) in
                    let country = ExchangeRateMapper.countryName(for: code)
                    return code.lowercased().contains(query.lowercased()) ||
                           country.lowercased().contains(query.lowercased())
                }
                currentState.filteredRates = filtered
            }
            state?(currentState)
        }
    }
}
