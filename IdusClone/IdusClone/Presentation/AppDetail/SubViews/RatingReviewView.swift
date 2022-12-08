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
        setupStarStackView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("coder is not used")
    }
}

extension RatingReviewView {
    
    private func setupLayout() {
        self.addSubviews([title, amount, totalAmount, startStackView])
        
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
        
        startStackView.snp.makeConstraints { make in
            make.centerY.equalTo(amount)
            make.leading.equalTo(amount.snp.trailing).offset(Const.largeSpacing)
            
        }
    }
    
    private func setupAttribute() {
        amount.text = "\(appDetail.averagedUserRating.roundUnder1())"
        amount.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
}

extension RatingReviewView {
    private func setupStarStackView() {
        for i in 0..<5 {
            let stackView = UIStackView().then { stackview in
                stackview.axis = .horizontal
                stackview.alignment = .center
                stackview.spacing = 2
                stackview.distribution = .equalSpacing
            }

            for j in 1..<6 {
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: .zero, height: .zero))
                imageView.contentMode = .scaleToFill
                let imgString = j > i ? "star.fill" : "star"
                let imgColor: UIColor = j > i ? .gray : .white
                let image = UIImage(systemName: imgString)?.tinted(with: imgColor)?.resized(to: CGSize(width: 8, height: 8))
                imageView.image = image
                stackView.addArrangedSubview(imageView)
            }
            startStackView.addArrangedSubview(stackView)
        }
    }
}
