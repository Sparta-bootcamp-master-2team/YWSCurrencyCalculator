//
//  Untitled.swift
//  YWSCurrencyCalculator
//
//  Created by 양원식 on 4/17/25.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    private let calculatorView = CalculatorView()
    
    override func loadView() {
        self.view = calculatorView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
}
