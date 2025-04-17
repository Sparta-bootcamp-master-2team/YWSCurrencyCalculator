//
//  CalculatorView.swift
//  YWSCurrencyCalculator
//
//  Created by 양원식 on 4/17/25.
//
import UIKit
import SnapKit

class CalculatorView: UIView {
    
    // MARK: - UI Components
    // 뷰에 들어갈 컴포넌트들을 정의하는 공간
    
    private lazy var labelStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [currencyLable, countryLable])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .center
        
        return stack
    }()
    
    private let titleLable: UILabel = {
        let label = UILabel()
        label.text = "환율 계산기"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 30, weight: .bold)
        
        return label
    }()
    
    private let currencyLable: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        
        return label
    }()
    
    private let countryLable: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        
        return label
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.textAlignment = .center
        textField.placeholder = "금액을 입력하세요"
        
        return textField
    }()
    
    private let convertButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        
        return button
    }()
    
    
    // MARK: - Initializers
    // init(frame:) 또는 required init?(coder:) 구현
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    // 뷰 설정 관련 함수들 (뷰 계층 설정, 스타일 설정 등)
    
    private func setupUI() {
        /// 뷰 계층 구성 (addSubview)
        addSubview(titleLable)
        addSubview(labelStackView)
        addSubview(amountTextField)
        addSubview(convertButton)
        addSubview(resultLabel)
        
        /// 오토레이아웃 설정 (SnapKit 등)
        titleLable.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
        
        amountTextField.snp.makeConstraints { make in
            make.top.equalTo(labelStackView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(44)
        }
        
        convertButton.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(44)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(convertButton.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        /// 스타일 설정 (색상, 폰트, 코너 등)
    }
    
    // MARK: - Action
    // 버튼 등 액션 연결 및 함수
    
    // MARK: - Public Methods
    // 외부에서 이 뷰에 접근하는 API 제공 (ex: updateLabel(with:))
    
    // MARK: - Private Methods
    // 내부 로직 처리용 메서드들
    
}
