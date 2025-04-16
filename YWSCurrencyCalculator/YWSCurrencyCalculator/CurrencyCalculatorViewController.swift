//
//  ViewController.swift
//  YWSCurrencyCalculator
//
//  Created by 양원식 on 4/15/25.
//

import UIKit

class CurrencyCalculatorViewController: UIViewController {
    
    private let currencyView = CurrencyCalculatorView()
    
    // API 결과로 받을 환율 데이터 (정렬 포함)
    private var exchangeRates: [(String, Double)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = currencyView

    }
    
}

