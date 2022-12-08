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
        label.font = .smallTitle
        label.textColor = .label
    }
    
    private let amount = UILabel().then { label in
        label.font = .roundedNumber
        label.textColor = .darkGray
    }
    
    private let totalAmount = UILabel().then { label in
        label.font = .smallScript
        label.textColor = .lightGray
        label.text = "out of 5"
    }
    
    init(appDetail: AppIntroduction) {
        self.appDetail = appDetail
        super.init(frame: CGRect(x: 0, y: 0, width: .zero, height: .zero))
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("coder is not used")
    }
}

extension RatingReviewView {
    private func setupLayout() {
        
    }
    
    private func setupAttribute() {
        amount.text = appDetail.trackContentRating
    }
}
