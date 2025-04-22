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

    func send(action: Action) {
        switch action {
        case .fetch:
            currentState.isLoading = true
            state?(currentState)
            service.fetchData { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        let sorted = data.rates.sorted { $0.key < $1.key }
                        self?.allRates = sorted
                        self?.currentState = State(isLoading: false, filteredRates: sorted)
                        self?.state?(self!.currentState)
                    case .failure:
                        self?.currentState = State(isLoading: false, filteredRates: [], errorMessage: "데이터를 불러올 수 없습니다.")
                        self?.state?(self!.currentState)
                    }
                }
            }
        case .search(let query):
            if query.isEmpty {
                currentState.filteredRates = allRates
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
