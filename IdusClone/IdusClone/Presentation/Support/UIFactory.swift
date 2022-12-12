//
//  UIFactory.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/12.
//

import Foundation
import UIKit.UIView
import Then

struct UIFactory {
    func makeDivider(_ completion: (UIView) -> Void) {
        completion(
            UIView().then { view in
                view.backgroundColor = .progressBackground
                view.frame = CGRect(x: 0, y: 0, width: .zero, height: .zero)
        })
    }
    
    func makeReviewCard() -> [UIView] {
        var array: [UIView] = []
        (0..<5).forEach { _ in array.append(ReviewCardView()) }
        return array
    }
    
    func makeInfoRow(_ pre: String, _ post: String, _ completion: (UIStackView) -> Void) {
        let preLabel = UILabel().then { label in
            label.text = pre
            label.font = .descriptionText
            label.textColor = .secondaryLabel
        }
        let postLabel = UILabel().then { label in
            label.text = post
            label.font = .descriptionText
            label.textColor = .label
            label.textAlignment = .right
        }
        
        let stackView = UIStackView().then { stackview in
            stackview.axis = .horizontal
            stackview.alignment = .center
        }
        
        stackView.addArrangedSubviews([preLabel, postLabel])
        
        completion(stackView)
    }
}
