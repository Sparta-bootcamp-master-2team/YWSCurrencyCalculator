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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "환율 계산기"
        self.calculatorView.configure(currency: currencyCode, rate: rate)
        
    } 
}
