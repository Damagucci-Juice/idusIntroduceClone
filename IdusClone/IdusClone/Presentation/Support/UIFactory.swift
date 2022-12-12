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
        (0..<5).forEach { _ in array.append(ReviewView()) }
        return array
    }
}
