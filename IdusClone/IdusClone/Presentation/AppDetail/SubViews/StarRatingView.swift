//
//  StarRatingView.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/08.
//
import SnapKit
import UIKit
import Then

final class StarRatingView: UIView {
    let width: CGFloat = Const.largeSpacing
    private let backgroundView = UIImageView()
    private lazy var foregroundView = UIImageView(image: UIImage(systemName: "star")?
        .resized(to: .init(width: self.width, height: self.width)))
    var ratingAmount: Double
    let color: UIColor
    
    init(ratingAmount: Double, color: UIColor) {
        self.ratingAmount = ratingAmount
        self.color = color
        super.init(frame: CGRect(x: 0, y: 0, width: .zero, height: .zero))
        setupLayout()
        setupAttribute()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StarRatingView {
    private func setupLayout() {
        [backgroundView, foregroundView].forEach { view in
            self.addSubview(view)
        }
        backgroundView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        foregroundView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupAttribute() {
        let tintedImage = UIImage(systemName: "star.fill")?
            .tinted(with: color)?
            .drawRectangleOnImage(ratingAmount)
            .resized(to: .init(width: self.width, height: self.width))
        backgroundView.image = tintedImage
        foregroundView.setImageColor(color: color)
        backgroundView.contentMode = .scaleAspectFit
        foregroundView.contentMode = .scaleAspectFit
    }
}
