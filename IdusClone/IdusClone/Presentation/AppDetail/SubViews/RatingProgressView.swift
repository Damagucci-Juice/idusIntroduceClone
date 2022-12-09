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
        stackView.spacing = Const.miniSpacing
    }
    
    private let progressStackView = UIStackView().then { stackView in
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = Const.miniSpacing
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
        self.addSubviews([title, amount, totalAmount, startStackView, progressStackView])
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
            make.top.equalTo(amount.snp.bottom).inset(Const.smallSpacing)
        }
        
        startStackView.snp.makeConstraints { make in
            make.centerY.equalTo(amount).offset(10)
            make.leading.equalTo(amount.snp.trailing).offset(Const.largeSpacing)
        }
        
        progressStackView.snp.makeConstraints { make in
            make.height.centerY.equalTo(startStackView)
            make.leading.equalTo(startStackView.snp.trailing)
            make.width.equalTo(160)
        }
    }
    
    private func setupAttribute() {
        amount.text = "\(appDetail.averagedUserRating.roundUnder1())"
        amount.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
}

extension RatingProgressView {
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
                let image = UIImage(systemName: imgString)?.tinted(with: imgColor)?.resized(to: CGSize(width: 10, height: 10))
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
