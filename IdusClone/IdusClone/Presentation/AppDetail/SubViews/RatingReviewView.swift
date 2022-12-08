//
//  RatingReviewView.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/07.
//
import SnapKit
import UIKit
import Then

final class RatingReviewView: UIView {
    private let appDetail: AppIntroduction
    
    private let title = UILabel().then { label in
        label.text = "Ratings & Reviews"
        label.font = .mediumTitle
        label.textColor = .label
    }
    
    private let amount = UILabel().then { label in
        label.font = .bigRoundedNumber
        label.textColor = .darkGray
    }
    
    private let totalAmount = UILabel().then { label in
        label.font = .smallScript
        label.textColor = .lightGray
        label.text = "out of 5"
    }
    
    private let startStackView = UIStackView().then { stackView in
        stackView.alignment = .trailing
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
    }
    
    private let progressStackView = UIStackView().then { stackView in
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
    }
    
    init(appDetail: AppIntroduction) {
        self.appDetail = appDetail
        super.init(frame: CGRect(x: 0, y: 0, width: .zero, height: .zero))
        setupLayout()
        setupAttribute()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("coder is not used")
    }
}

extension RatingReviewView {
    
    private func setupLayout() {
        self.addSubviews([title, amount, totalAmount])
        
        title.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(Const.largeSpacing)
        }
        
        amount.snp.makeConstraints { make in
            make.leading.equalTo(title)
            make.top.equalTo(title.snp.bottom)
        }
        
        totalAmount.snp.makeConstraints { make in
            make.centerX.equalTo(amount)
            make.top.equalTo(amount.snp.bottom).inset(Const.smallSpacing)
        }
    }
    
    private func setupAttribute() {
        amount.text = "\(appDetail.averagedUserRating.roundUnder1())"
    }
}
