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
        self.view.backgroundColor = .white
        
        setupTableView()
        fetchData()
    }
    
    // 테이블뷰 설정
    private func setupTableView() {
        currencyView.tableView.dataSource = self
        currencyView.tableView.delegate = self
    }
    
    // API 호출
    private func fetchData() {
        let service = DataService()
        service.fetchData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.exchangeRates = data.rates.sorted { $0.key < $1.key } // 정렬 후 표기
                    self?.currencyView.tableView.reloadData()
                case .failure:
                    self?.showErrorAlert()
                }
            }
        }
    }
    
    // 에러 발생 시 알림
    private func showErrorAlert() {
        let alert = UIAlertController(title: "오류", message: "데이터를 불러올 수 없습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
    
}
extension CurrencyCalculatorViewController: UITableViewDataSource, UITableViewDelegate {
    
    // exchangeRates의 개수만큼 셀 생성
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchangeRates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as? CurrencyCell else {
            return UITableViewCell()
        }

        let (currency, rate) = exchangeRates[indexPath.row]
        cell.configure(currency: currency, rate: rate)
        return cell
    }
}


