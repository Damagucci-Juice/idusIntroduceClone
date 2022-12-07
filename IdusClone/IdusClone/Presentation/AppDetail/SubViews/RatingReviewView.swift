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
    private let title = UILabel().then { label in
        label.text = "Ratings & Reviews"
        label.font = .smallTitle
        label.textColor = .label
    }
    
    private let amount = UILabel().then { label in
        label.font = .roundedNumber
        label.textColor = .darkGray
        label.text = "4.8"
    }
    
    private let totalAmount = UILabel().then { label in
        label.font = .smallScript
        label.textColor = .lightGray
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("coder is not used")
    }
    
    
}
