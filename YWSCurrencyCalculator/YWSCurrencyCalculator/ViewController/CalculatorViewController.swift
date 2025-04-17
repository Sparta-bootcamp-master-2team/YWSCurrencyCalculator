//
//  Untitled.swift
//  YWSCurrencyCalculator
//
//  Created by 양원식 on 4/17/25.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    private let calculatorView = CalculatorView()
    
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
        
    }
}
