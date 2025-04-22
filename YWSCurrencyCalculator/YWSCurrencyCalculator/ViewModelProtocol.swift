//
//  ViewModelProtocol.swift
//  YWSCurrencyCalculator
//
//  Created by 양원식 on 4/18/25.
//

import Foundation

protocol ViewModelProtocol {
    associatedtype Action
    associatedtype State

    var state: ((State) -> Void)? { get set }
    func send(action: Action)
}
