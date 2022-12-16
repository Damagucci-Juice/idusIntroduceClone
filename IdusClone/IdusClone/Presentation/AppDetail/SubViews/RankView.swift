//
//  RankView.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/14.
//
import SnapKit
import UIKit
import Then

final class RankView: UIView {
    private let uiFactory = UIFactory()
    //MARK: - 첫번째 섹터
    private let ratingCountLabel = UILabel().then { label in
        label.font = .fogText
        label.textColor = .lightGray
    }
    
    private let ratingAmountLabel = UILabel().then { label in
        label.font = .smallRoundedNumber
        label.textColor = .starLight
    }
    
    private let fiveStarRatingView = FiveStarView(ratingAmount: 0.0, isContinues: true)
    
    private let ratingStackView = UIStackView().then { stackView in
        stackView.axis = .vertical
        stackView.spacing = Const.miniSpacing
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
    }
    
    //MARK: - 두번째 섹터
    private let ageLabel = UILabel().then { label in
        label.font = .fogText
        label.textColor = .lightGray
        label.text = "AGE"
    }
    
    private let ageAmountLabel = UILabel().then { label in
        label.font = .smallRoundedNumber
        label.textColor = .starLight
    }
    
    private let yearsOldLabel = UILabel().then { label in
        label.font = .smallText
        label.textColor = .secondaryLabel
        label.text = "Years Old"
    }
    
    private let ageStackView = UIStackView().then { stackView in
        stackView.axis = .vertical
        stackView.spacing = Const.miniSpacing
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
    }
    
    //MARK: - 세번째 섹터
    private let chartLabel = UILabel().then { label in
        label.font = .fogText
        label.textColor = .lightGray
        label.text = "CHART"
    }
    
    private let chartNumberLabel = UILabel().then { label in
        label.font = .smallRoundedNumber
        label.textColor = .starLight
        label.sizeToFit()
    }
    
    private let chartSortLabel = UILabel().then { label in
        label.font = .smallText
        label.textColor = .secondaryLabel
    }
    
    private let chartStackView = UIStackView().then { stackView in
        stackView.axis = .vertical
        stackView.spacing = Const.miniSpacing
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
    }
    
    init(ratingCount: String, ratingAmount: Double, recommandAge: String, rankNumber: Int = 30, primaryGenre: String) {
        super.init(frame: .zero)
        let roundedRating = ratingAmount
        self.ratingCountLabel.text = ratingCount + " RATINGS"
        self.ratingAmountLabel.text = "\(roundedRating)"
        self.fiveStarRatingView.ratingAmount = roundedRating
        self.ageAmountLabel.text = recommandAge
        self.chartNumberLabel.text = "No.\(rankNumber)"
        self.chartSortLabel.text = primaryGenre
        
        setupAddSubview()
        setupAttribute()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RankView {
    private func setupAddSubview() {
        ratingStackView.addArrangedSubviews([ratingCountLabel, ratingAmountLabel, fiveStarRatingView])
        ageStackView.addArrangedSubviews([ageLabel, ageAmountLabel, yearsOldLabel])
        chartStackView.addArrangedSubviews([chartLabel, chartNumberLabel])
        self.addSubviews([ratingStackView, ageStackView, chartStackView, chartSortLabel])
    }
    private func setupAttribute() {
        //MARK: - Chart Number Label attributedString 편집
        let fullText = chartNumberLabel.text ?? ""
        let attribtuedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "No.")
        attribtuedString.addAttributes([.font: UIFont.miniRoundedText as Any], range: range)
        chartNumberLabel.attributedText = attribtuedString
    }
    private func setupLayout() {
        let fiveStarViewWidth: CGFloat = 70
        
        ratingStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Const.largeSpacing)
            make.leading.equalToSuperview().offset(Const.xxxLargeSpacing)
            make.height.equalTo(ageStackView)
        }
        
        fiveStarRatingView.snp.makeConstraints { make in
            make.width.equalTo(fiveStarViewWidth)
            make.height.equalTo(fiveStarRatingView.snp.width).multipliedBy(0.2)
        }
        
        uiFactory.makeDivider { divider in
            self.addSubview(divider)
            divider.snp.makeConstraints { make in
                make.width.equalTo(Const.dividerHeight)
                make.height.equalTo(ratingStackView.snp.height).multipliedBy(0.6)
                make.trailing.equalTo(ageStackView.snp.leading).inset(-Const.xxLargeSpacing)
                make.centerY.equalTo(ratingStackView)
            }
        }
        
        ageStackView.snp.makeConstraints { make in
            make.centerY.top.equalTo(ratingStackView)
            make.centerX.equalToSuperview()
        }
        
        uiFactory.makeDivider { divider in
            self.addSubview(divider)
            divider.snp.makeConstraints { make in
                make.width.equalTo(Const.dividerHeight)
                make.height.equalTo(ratingStackView.snp.height).multipliedBy(0.6)
                make.leading.equalTo(ageStackView.snp.trailing).offset(Const.xxLargeSpacing)
                make.centerY.equalTo(ratingStackView)
            }
        }
        
        chartStackView.snp.makeConstraints { make in
            make.top.equalTo(ratingStackView)
            make.trailing.equalToSuperview().inset(Const.xxxLargeSpacing)
        }
        
        chartSortLabel.snp.makeConstraints { make in
            make.centerY.equalTo(yearsOldLabel)
            make.centerX.equalTo(chartStackView)
        }
    }
}
