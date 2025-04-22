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

    private var allRates: [(String, Double)] = []
    private let service = DataService()

    func send(action: Action) {
        switch action {
        case .fetch:
            state?(State(isLoading: true, filteredRates: []))
            service.fetchData { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        let sorted = data.rates.sorted { $0.key < $1.key }
                        self?.allRates = sorted
                        self?.state?(State(isLoading: false, filteredRates: sorted))
                    case .failure:
                        self?.state?(State(isLoading: false, filteredRates: [], errorMessage: "데이터를 불러올 수 없습니다."))
                    }
                }
            }
        case .search(let query):
            if query.isEmpty {
                state?(State(isLoading: false, filteredRates: allRates))
                return
            }

            let filtered = allRates.filter { (code, _) in
                let country = ExchangeRateMapper.countryName(for: code)
                return code.lowercased().contains(query.lowercased()) ||
                       country.lowercased().contains(query.lowercased())
            }
            state?(State(isLoading: false, filteredRates: filtered))
        }
    }
}
