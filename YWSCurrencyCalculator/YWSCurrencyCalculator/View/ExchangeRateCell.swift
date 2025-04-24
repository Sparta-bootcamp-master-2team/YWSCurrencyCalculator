//
//  CurrencyCell.swift
//  YWSCurrencyCalculator
//
//  Created by 양원식 on 4/16/25.
//

import UIKit
import SnapKit

protocol ExchangeRateCellDelegate: AnyObject {
    func ExchangeRateCellDidTapFavorite()
}

/// 환율 정보를 보여주는 커스텀 셀입니다.
/// 통화 코드, 국가명, 환율 값을 수직/수평으로 정렬하여 표시합니다.
class ExchangeRateCell: UITableViewCell {
    
    private var isFavorite: Bool = false
    weak var delegate: ExchangeRateCellDelegate?
    
    // MARK: - UI Components
    
    /// 통화 코드 및 국가명을 수직으로 정렬하는 스택뷰입니다.
    private lazy var labelStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [currencyLabel, countryLabel])
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()
    
    /// 통화 코드 레이블 (예: "KRW")
    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(named: "TextColor") ?? .label
        return label
    }()
    
    /// 국가명 레이블 (예: "대한민국")
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(named: "SecondaryTextColor") ?? .secondaryLabel
        return label
    }()
    
    /// 환율 레이블 (예: "1345.1234")
    private let rateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        label.textColor = UIColor(named: "TextColor") ?? .label
        return label
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = UIColor(named: "FavoriteColor") ?? .systemYellow
        return button
    }()
    
    private let changeDirectionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        imageView.snp.makeConstraints { $0.width.equalTo(20) } // 아이콘 없을 때도 여백 유지
        return imageView
    }()
    
    // MARK: - Initializers
    
    /// 셀 초기화 메서드입니다. SnapKit을 활용해 오토레이아웃을 설정합니다.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "CellBackgroundColor") ?? .systemBackground
        
        setupActions()
        selectionStyle = .none
        
        contentView.addSubview(labelStackView)
        contentView.addSubview(rateLabel)
        contentView.addSubview(changeDirectionImage)
        contentView.addSubview(favoriteButton)
        
        labelStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        rateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(labelStackView.snp.trailing).offset(16)
        }
        
        contentView.addSubview(changeDirectionImage)

        changeDirectionImage.snp.makeConstraints { make in
            make.leading.equalTo(rateLabel.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(favoriteButton.snp.leading).offset(-16)

        }
        favoriteButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
        }

        
        
    }
    
    /// 스토리보드 초기화 지원용 (사용하지 않음)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    /// 셀에 표시할 통화 정보와 환율 데이터를 설정합니다.
    /// - Parameters:
    ///   - currency: 통화 코드 (예: "USD", "KRW")
    ///   - rate: 해당 통화의 환율 값 (소수점 4자리까지 표시됨)
    func configure(currency: String, rate: Double) {
        currencyLabel.text = currency
        countryLabel.text = ExchangeRateMapper.countryName(for: currency)
        rateLabel.text = String(format: "%.4f", rate)

        isFavorite = CoreDataManager.shared.isFavorite(code: currency)
        updateFavoriteImage()

        let direction = RateChangeHelper.direction(for: currency, newRate: rate)
        switch direction {
        case .up:
            changeDirectionImage.image = UIImage(systemName: "arrow.up")?.withRenderingMode(.alwaysTemplate)
            changeDirectionImage.tintColor = .systemGreen
        case .down:
            changeDirectionImage.image = UIImage(systemName: "arrow.down")?.withRenderingMode(.alwaysTemplate)
            changeDirectionImage.tintColor = .systemRed
        case .same:
            changeDirectionImage.image = UIImage(systemName: "minus")?.withRenderingMode(.alwaysTemplate)
            changeDirectionImage.tintColor = .lightGray
        }
    }

    
    private func setupActions() {
        favoriteButton.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
    }


    private func updateFavoriteImage() {
        let imageName = isFavorite ? "star.fill" : "star"
        favoriteButton.setImage(UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        favoriteButton.tintColor = UIColor(named: "FavoriteColor") ?? .systemYellow
    }

    @objc private func didTapFavorite() {
        guard let code = currencyLabel.text else { return }
        isFavorite.toggle()
        updateFavoriteImage()

        if isFavorite {
            CoreDataManager.shared.saveFavorite(code: code)
        } else {
            CoreDataManager.shared.removeFavorite(code: code)
        }

        delegate?.ExchangeRateCellDidTapFavorite()
    }

}
