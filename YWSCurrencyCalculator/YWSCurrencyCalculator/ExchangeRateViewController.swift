//
//  ViewController.swift
//  YWSCurrencyCalculator
//
//  Created by 양원식 on 4/15/25.
//

import UIKit

/// 환율 데이터를 표시하고 검색할 수 있는 메인 화면입니다.
/// - 외부 API로부터 환율 데이터를 받아 테이블 뷰로 출력합니다.
/// - 통화 코드 또는 국가명을 기준으로 실시간 필터링 기능을 지원합니다.
class ExchangeRateViewController: UIViewController {
    
    /// 메인 UI 구성 뷰 (검색바 + 테이블뷰)
    private let exchangeRateView = ExchangeRateView()
    
    /// API로부터 받아온 전체 환율 데이터
    private var exchangeRates: [(String, Double)] = []
    
    /// 필터링된 환율 데이터 (검색 결과에 따라 갱신)
    private var filteredRates: [(String, Double)] = []
    
    /// 뷰가 로드된 후 초기 UI 설정 및 API 호출을 수행합니다.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = exchangeRateView
        self.view.backgroundColor = .white
        
        setupTableView()
        fetchData()
    }
    
    /// 테이블뷰와 검색바에 대한 delegate/dataSource 설정을 수행합니다.
    private func setupTableView() {
        exchangeRateView.tableView.dataSource = self
        exchangeRateView.tableView.delegate = self
        exchangeRateView.searchBar.delegate = self
    }
    
    /// 외부 API로부터 환율 데이터를 가져와 filteredRates에 반영합니다.
    private func fetchData() {
        let service = DataService()
        service.fetchData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.exchangeRates = data.rates.sorted { $0.key < $1.key }
                    self?.filteredRates = self?.exchangeRates ?? []
                    self?.exchangeRateView.tableView.reloadData()
                    
                case .failure:
                    self?.showErrorAlert()
                }
            }
        }
    }
    
    /// 데이터 로딩 실패 시 사용자에게 오류 Alert을 표시합니다.
    private func showErrorAlert() {
        let alert = UIAlertController(title: "오류", message: "데이터를 불러올 수 없습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
extension ExchangeRateViewController: UITableViewDataSource {
    
    /// 섹션 내 셀 개수를 반환합니다.
    /// 검색 결과가 없으면 1 (안내 셀), 결과가 있으면 해당 개수만큼 반환합니다.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRates.isEmpty ? 1 : filteredRates.count
    }
    
    /// 주어진 인덱스에 해당하는 셀을 반환합니다.
    /// 검색 결과가 없을 경우 "검색 결과 없음" 셀을 반환합니다.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if filteredRates.isEmpty {
            let cell = UITableViewCell()
            cell.textLabel?.text = "검색 결과 없음"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = .gray
            cell.selectionStyle = .none
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExchangeRateCell", for: indexPath) as? ExchangeRateCell else {
            return UITableViewCell()
        }
        
        let (currency, rate) = filteredRates[indexPath.row]
        cell.configure(currency: currency, rate: rate)
        return cell
    }
}

extension ExchangeRateViewController: UISearchBarDelegate {
    
    /// 검색어가 변경될 때마다 호출되어 실시간으로 필터링을 수행합니다.
    /// - 검색어가 비어 있으면 전체 데이터를 표시합니다.
    /// - 통화 코드 또는 국가명에 검색어가 포함된 경우 해당 항목만 필터링됩니다.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredRates = exchangeRates
            exchangeRateView.tableView.reloadData()
            return
        }
        
        filteredRates = exchangeRates.filter { (code, _) in
            let country = ExchangeRateMapper.countryName(for: code)
            return code.lowercased().contains(searchText.lowercased()) ||
                   country.lowercased().contains(searchText.lowercased())
        }
        exchangeRateView.tableView.reloadData()
    }
}

