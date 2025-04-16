//
//  CurrencyCalculatorView.swift
//  YWSCurrencyCalculator
//
//  Created by 양원식 on 4/16/25.
//

import UIKit
import SnapKit

class ExchangeRateView: UIView {
    
    // MARK: - UI Components
    // 뷰에 들어갈 컴포넌트들을 정의하는 공간
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.text = "통화 검색"
        searchBar.backgroundImage = UIImage()
        
        return searchBar
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 60
        tableView.register(ExchangeRateCell.self, forCellReuseIdentifier: "ExchangeRateCell")
        return tableView
    }()
    
    // MARK: - Initializers
    // init(frame:) 또는 required init?(coder:) 구현
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    // 뷰 설정 관련 함수들 (뷰 계층 설정, 스타일 설정 등)
    
    private func setUI() {
        /// 뷰 계층 구성 (addSubview)
        addSubview(searchBar)
        addSubview(tableView)
        
        /// 오토레이아웃 설정 (SnapKit 등)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Action
    // 버튼 등 액션 연결 및 함수
    
    // MARK: - Public Methods
    // 외부에서 이 뷰에 접근하는 API 제공 (ex: updateLabel(with:))
    
    // MARK: - Private Methods
    // 내부 로직 처리용 메서드들
    
}
