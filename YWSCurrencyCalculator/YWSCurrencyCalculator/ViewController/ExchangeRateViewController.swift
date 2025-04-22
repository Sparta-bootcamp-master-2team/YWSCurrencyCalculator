//
//  ViewController.swift
//  YWSCurrencyCalculator
//
//  Created by 양원식 on 4/15/25.
//

import UIKit

final class ExchangeRateViewController: UIViewController {
    private let exchangeRateView = ExchangeRateView()
    private let viewModel = ExchangeRateViewModel()

    override func loadView() {
        view = exchangeRateView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "환율 정보"
        view.backgroundColor = .white

        exchangeRateView.searchBar.delegate = self
        exchangeRateView.tableView.dataSource = self
        exchangeRateView.tableView.delegate = self

        viewModel.state = { [weak self] state in
            if let error = state.errorMessage {
                self?.showErrorAlert(message: error)
            } else {
                self?.exchangeRateView.tableView.reloadData()
            }
        }

        viewModel.send(action: .fetch)
    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "오류", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}

extension ExchangeRateViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.send(action: .search(query: searchText))
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension ExchangeRateViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currentState.filteredRates.isEmpty ? 1 : viewModel.currentState.filteredRates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let filtered = viewModel.currentState.filteredRates

        if filtered.isEmpty {
            let cell = UITableViewCell()
            cell.textLabel?.text = "검색 결과 없음"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = .gray
            return cell
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExchangeRateCell") as? ExchangeRateCell else {
            return UITableViewCell()
        }

        let (currency, rate) = filtered[indexPath.row]
        cell.configure(currency: currency, rate: rate)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filtered = viewModel.currentState.filteredRates
        guard !filtered.isEmpty else { return }

        let (code, rate) = filtered[indexPath.row]
        let calculatorVC = CalculatorViewController(currencyCode: code, rate: rate)
        navigationController?.pushViewController(calculatorVC, animated: true)
    }
}

