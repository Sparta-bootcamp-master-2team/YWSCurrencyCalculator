//
//  ViewModel.swift
//  YWSCurrencyCalculator
//
//  Created by 양원식 on 4/18/25.
//

final class CalculatorViewModel: ViewModelProtocol {
    enum Action {
        case convert(input: String)
    }

    struct State {
        var resultText: String?
        var errorMessage: String?
    }

    var state: ((State) -> Void)?

    private let currencyCode: String
    private let rate: Double

    init(currencyCode: String, rate: Double) {
        self.currencyCode = currencyCode
        self.rate = rate
    }

    func send(action: Action) {
        switch action {
        case .convert(let input):
            guard !input.isEmpty else {
                state?(State(resultText: nil, errorMessage: "금액을 입력해주세요"))
                return
            }

            guard let amount = Double(input) else {
                state?(State(resultText: nil, errorMessage: "올바른 숫자를 입력해주세요"))
                return
            }

            let result = amount * rate
            let formattedAmount = String(format: "%.2f", amount)
            let formattedResult = String(format: "%.2f", result)
            let resultText = "$ \(formattedAmount) → \(formattedResult) \(currencyCode)"

            state?(State(resultText: resultText, errorMessage: nil))
        }
    }
}
