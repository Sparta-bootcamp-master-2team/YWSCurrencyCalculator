//
//  Untitled.swift
//  YWSCurrencyCalculator
//
//  Created by 양원식 on 4/17/25.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    let calculatorView = CalculatorView()
    
    var currencyCode: String = ""
    var rate: Double = 0.0
    
    override func loadView() {
        self.view = calculatorView
    }
    
    init(currencyCode: String, rate: Double) {
        self.currencyCode = currencyCode
        self.rate = rate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "환율 계산기"
        self.calculatorView.configure(currency: currencyCode, rate: rate)
        
        calculatorView.setConvertButtonTarget(self, action: #selector(handleConvert))
    }
    
    @objc private func handleConvert() {
        guard let text = calculatorView.amountText, !text.isEmpty else {
            showAlert(message: "금액을 입력해주세요")
            return
        }

        guard let amount = Double(text) else {
            showAlert(message: "올바른 숫자를 입력해주세요")
            return
        }
        
        let result = amount * rate
        let formattedAmount = String(format: "%.2f", amount)
        let formattedResult = String(format: "%.2f", result)
        calculatorView.updateResultLabel(
            text: "$ \(formattedAmount) → \(formattedResult) \(currencyCode)"
        )
        
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "입력 오류", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }

    
}
