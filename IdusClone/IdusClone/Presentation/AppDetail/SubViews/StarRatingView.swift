//
//  StarRatingView.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/08.
//
import SnapKit
import UIKit
import Then

class StarRatingView: UIView {
    private let backgroundView = UIImageView()
    private let foregroundView = UIImageView(image: UIImage(systemName: "star"))
    var ratingAmount: Double
    let color: UIColor
    
    init(ratingAmount: Double, color: UIColor) {
        self.ratingAmount = ratingAmount
        self.color = color
        super.init(frame: CGRect(x: 0, y: 0, width: .zero, height: .zero))
        
        let tintedImage = UIImage(systemName: "star.fill")?
            .tinted(with: color)?
            .drawRectangleOnImage(ratingAmount)
        backgroundView.image = tintedImage
        [backgroundView, foregroundView].forEach { view in
            self.addSubview(view)
        }
        backgroundView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        foregroundView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        foregroundView.setImageColor(color: color)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
