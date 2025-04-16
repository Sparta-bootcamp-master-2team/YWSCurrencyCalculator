//
//  CurrencyCell.swift
//  YWSCurrencyCalculator
//
//  Created by 양원식 on 4/16/25.
//

import UIKit
import SnapKit

class ExchangeRateCell: UITableViewCell {
    
    // MARK: - UI Components
    // 뷰에 들어갈 컴포넌트들을 정의하는 공간
    private lazy var labelStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [currencyLabel, countryLabel])
        stack.axis = .vertical
        stack.spacing = 4
        
        return stack
    }()
    
    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        
        return label
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        
        return label
    }()
    private let rateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        label.textColor = .label
        
        return label
    }()
    
    // MARK: - Initializers
    // init(frame:) 또는 required init?(coder:) 구현
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.addSubview(labelStackView)
        contentView.addSubview(rateLabel)
        
        labelStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        rateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.leading.equalTo(labelStackView.snp.trailing).offset(16)
            make.width.equalTo(120)
        }
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    // 뷰 설정 관련 함수들 (뷰 계층 설정, 스타일 설정 등)
    
    /// 뷰 계층 구성 (addSubview)
    
    
    /// 오토레이아웃 설정 (SnapKit 등)
    
    
    /// 스타일 설정 (색상, 폰트, 코너 등)
    
    // MARK: - Action
    // 버튼 등 액션 연결 및 함수
    
    // MARK: - Public Methods
    // 외부에서 이 뷰에 접근하는 API 제공 (ex: updateLabel(with:))
    func configure(currency: String, rate: Double) {
        currencyLabel.text = currency
        countryLabel.text = ExchangeRateMapper.countryName(for: currency)
        rateLabel.text = String(format: "%.4f", rate)
    }
    
    // MARK: - Private Methods
    // 내부 로직 처리용 메서드들
}
