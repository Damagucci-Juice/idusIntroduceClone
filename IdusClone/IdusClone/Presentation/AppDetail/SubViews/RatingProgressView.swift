//
//  RatingReviewView.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/07.
//
import SnapKit
import UIKit
import Then

final class RatingProgressView: UIView {
    private let appDetail: AppIntroduction
    
    private let title = UILabel().then { label in
        label.text = "Ratings & Reviews"
        label.font = .mediumTitle
        label.textColor = .label
    }
    
    private let amount = UILabel().then { label in
        label.font = .bigRoundedNumber
        label.textColor = .bigRoundedNumbersColor
        label.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    private let totalAmount = UILabel().then { label in
        label.font = .totalRating
        label.textColor = .gray
        label.text = "out of 5"
    }
    
    private let startStackView = UIStackView().then { stackView in
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = Const.dividerHeight
    }
    
    private let progressStackView = UIStackView().then { stackView in
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = Const.dividerHeight
    }
    
    private let userRatingCount = UILabel().then { label in
        label.font = .ratingCount
        label.textColor = .gray
    }
    
    init(appDetail: AppIntroduction) {
        self.appDetail = appDetail
        super.init(frame: CGRect(x: 0, y: 0, width: .zero, height: .zero))
        setupAddSubviews()
        setupLayout()
        setupAttribute()
        setupStarStackView()
        setupProgressBar()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("coder is not used")
    }
}

extension RatingProgressView {
    
    private func setupAddSubviews() {
        self.addSubviews([title, amount, totalAmount, startStackView, progressStackView, userRatingCount])
    }
    
    private func setupLayout() {
        title.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(Const.largeSpacing)
        }
        
        amount.snp.makeConstraints { make in
            make.leading.equalTo(title)
            make.top.equalTo(title.snp.bottom)
        }
        
        totalAmount.snp.makeConstraints { make in
            make.centerX.equalTo(amount)
            make.top.equalTo(amount.snp.bottom).inset(Const.minimumSpacing)
        }
        
        startStackView.snp.makeConstraints { make in
            make.centerY.equalTo(amount)
            make.leading.equalTo(amount.snp.trailing)
        }
        
        progressStackView.snp.makeConstraints { make in
            make.height.centerY.equalTo(startStackView)
            make.leading.equalTo(startStackView.snp.trailing).offset(Const.miniSpacing)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(Const.largeSpacing)
        }
        
        userRatingCount.snp.makeConstraints { make in
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(Const.xLargeSpacing)
            make.centerY.equalTo(totalAmount)
        }
    }
    
    private func setupAttribute() {
        amount.text = "\(appDetail.averagedUserRating.roundUnder1())"
        amount.setContentCompressionResistancePriority(.required, for: .horizontal)
        userRatingCount.text = "\(appDetail.userRatingCount.toStringWithComma) Ratings"
    }
}

extension RatingProgressView {
    private func setupStarStackView() {
        for i in 0..<5 {
            let stackView = UIStackView().then { stackview in
                stackview.axis = .horizontal
                stackview.alignment = .center
            }

            for j in 1..<6 {
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: .zero, height: .zero))
                imageView.contentMode = .scaleToFill
                let imgString = j > i ? "star.fill" : "star"
                let imgColor: UIColor = j > i ? .starLight : .white
                let image = UIImage(systemName: imgString)?.tinted(with: imgColor)?.resized(to: CGSize(width: 8, height: 8))
                imageView.image = image
                stackView.addArrangedSubview(imageView)
            }
            startStackView.addArrangedSubview(stackView)
        }
    }
    
    private func setupProgressBar() {
        let array: [Double] = [0.85, 0.4, 0.2, 0.1, 0.1]
        array.forEach { rating in
            let bar = ProgressBarView(progressRating: rating)
            progressStackView.addArrangedSubview(bar)
        }
    }
}
