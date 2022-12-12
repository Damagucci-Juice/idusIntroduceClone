//
//  ReviewView.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/09.
//
import SnapKit
import UIKit
import Then

final class ReviewView: UIView {
    private let title = UILabel().then { label in
        label.font = .smallTitle
        label.textColor = .label
    }

    private lazy var fiveStarView = UIStackView().then { stackView in
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
    }
    
    private let reviewDescription = UILabel().then { label in
        label.textColor = .label
        label.font = .descriptionText
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
    private let userName = UILabel().then { label in
        label.textColor = .gray
        label.font = .descriptionText
    }
    private let uploadDate = UILabel().then { label in
        label.textColor = .gray
        label.font = .descriptionText
    }
    
    private let ratingAmount: Int
    
    init(title: String, ratingAmount: Int, reviewDescription: String, userName: String, uploadDate: Date) {
        self.ratingAmount = ratingAmount
        super.init(frame: CGRect(x: 0, y: 0, width: .zero, height: .zero))
        self.title.text = title
        self.reviewDescription.text = reviewDescription
        self.userName.text = userName
        self.uploadDate.text = uploadDate.toRecentDays
        setupAddSubview()
        setupLayout()
        setupAttribute()
    }
    
    convenience init() {
        var dateComponent = DateComponents()
        dateComponent.year = Int.random(in: 2020...2022)
        dateComponent.month = Int.random(in: 1...12)
        dateComponent.day = Int.random(in: 1...30)
        let date = Calendar.current.date(from: dateComponent) ?? Date.now
        let longText = """
                        Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                        """
        self.init(title: "마구마구 운영자님들", ratingAmount: Int.random(in: 1...5), reviewDescription: longText, userName: "유저이름", uploadDate: date)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension ReviewView {
    private func setupAddSubview() {
        addSubviews([title, fiveStarView, reviewDescription, userName, uploadDate])
        drawFivestars()
    }
    
    private func setupLayout() {
        let fiveStarViewWidth: CGFloat = 85
        
        title.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Const.xxLargeSpacing)
            make.top.equalToSuperview().offset(Const.xLargeSpacing)
        }
        fiveStarView.snp.makeConstraints { make in
            make.leading.equalTo(title)
            make.width.equalTo(fiveStarViewWidth)
            make.centerY.equalTo(userName)
        }
        uploadDate.snp.makeConstraints { make in
            make.centerY.equalTo(title)
            make.trailing.equalToSuperview().inset(Const.xxLargeSpacing)
        }
        userName.snp.makeConstraints { make in
            make.trailing.equalTo(uploadDate)
            make.top.equalTo(uploadDate.snp.bottom).offset(Const.smallSpacing)
        }
        reviewDescription.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Const.xxLargeSpacing)
            make.bottom.equalToSuperview().inset(Const.xLargeSpacing)
            make.top.equalTo(userName.snp.bottom).offset(Const.smallSpacing)
        }
    }
    
    private func setupAttribute() {
        self.backgroundColor = .cardBackground
        self.layer.cornerRadius = 10
    }
    
    private func drawFivestars() {
        for i in 1..<6 {
            let imageView = UIImageView()
            let imageStr = i <= ratingAmount ? "star.fill" : "star"
            imageView.image = UIImage(systemName: imageStr)?.tinted(with: .highlightedStarLight)
            imageView.snp.makeConstraints { make in
                make.height.equalTo(imageView.snp.width)
            }
            fiveStarView.addArrangedSubview(imageView)
        }
    }
}
