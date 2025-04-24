//
//  Untitled.swift
//  YWSCurrencyCalculator
//
//  Created by 양원식 on 4/17/25.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    let calculatorView = CalculatorView()
    private var viewModel: CalculatorViewModel!
    
    var currencyCode: String = ""
    var rate: Double = 0.0
    
    override func loadView() {
        self.view = calculatorView
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        CoreDataManager.shared.saveAppState(screen: "calculator", code: currencyCode)
    }
    


    init(currencyCode: String, rate: Double) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = CalculatorViewModel(currencyCode: currencyCode, rate: rate)
        self.currencyCode = currencyCode
        self.rate = rate
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
        
        viewModel.state = { [weak self] state in
            if let message = state.errorMessage {
                self?.showAlert(message: message)
            } else if let result = state.resultText {
                self?.calculatorView.updateResultLabel(text: result)
            }
        }
    }
    
    @objc private func handleConvert() {
        viewModel.send(action: .convert(input: calculatorView.amountText ?? ""))
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "입력 오류", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
}
