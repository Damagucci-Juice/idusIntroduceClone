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
        label.font = .smallScript
        label.textColor = .label
    }
    private let ratingAmount: Double
    private let reviewDescription: String
    private let userName: String
    private let uploadDate: Date
    
    init(title: String, ratingAmount: Double, reviewDescription: String, userName: String, uploadDate: Date) {
        self.ratingAmount = ratingAmount
        self.reviewDescription = reviewDescription
        self.userName = userName
        self.uploadDate = uploadDate
        super.init(frame: CGRect(x: 0, y: 0, width: .zero, height: .zero))
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension ReviewView {
    private func setupLayout() {
        
    }
}
