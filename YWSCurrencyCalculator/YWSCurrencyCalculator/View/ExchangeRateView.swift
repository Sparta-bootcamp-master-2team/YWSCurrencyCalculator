//
//  CurrencyCalculatorView.swift
//  YWSCurrencyCalculator
//
//  Created by 양원식 on 4/16/25.
//

import UIKit
import SnapKit

/// 환율 화면의 메인 뷰입니다.
/// - UISearchBar와 UITableView를 포함하며, SnapKit을 사용해 오토레이아웃을 구성합니다.
class ExchangeRateView: UIView {
    
    // MARK: - UI Components
    
    private let titleLable: UILabel = {
        let label = UILabel()
        label.text = "환율 정보"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 30, weight: .bold)
        
        return label
    }()
    
    /// 통화 검색을 위한 검색바입니다.
    /// - placeholder: "통화 검색"
    /// - 배경 이미지를 제거하여 깔끔한 디자인 적용
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "통화 검색"
        searchBar.backgroundImage = UIImage() // 상단 라인 제거
        return searchBar
    }()
    
    /// 환율 데이터를 표시할 테이블 뷰입니다.
    /// - 셀: ExchangeRateCell
    /// - separator: single line
    /// - rowHeight: 60
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 60
        tableView.register(ExchangeRateCell.self, forCellReuseIdentifier: "ExchangeRateCell")
        return tableView
    }()
    
    // MARK: - Initializers
    
    /// 코드 기반 초기화 메서드입니다. UI 구성 메서드를 호출합니다.
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    /// 스토리보드 사용 시 호출되며, 해당 뷰는 코드로만 초기화되므로 구현되지 않습니다.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    /// UI 컴포넌트들을 뷰에 추가하고 SnapKit을 통해 오토레이아웃을 설정합니다.
    private func setUI() {
        addSubview(titleLable)
        addSubview(searchBar)
        addSubview(tableView)
        
        titleLable.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).offset(16)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
