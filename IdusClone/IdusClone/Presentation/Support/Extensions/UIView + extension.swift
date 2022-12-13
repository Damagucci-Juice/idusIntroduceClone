//
//  UIView + extension.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/08.
//
import Then
import UIKit

extension UIView {
    convenience init(backgroundColor: UIColor) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
    }
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
    
    func hstack(_ views: UIView...) {
        let hstack = UIStackView().then { hstack in
            hstack.axis = .horizontal
            hstack.distribution = .fillEqually
            hstack.frame = self.frame
        }
        hstack.addArrangedSubviews(views)
        addSubview(hstack)
    }
    
    func vstack(_ views: UIView...) {
        let vstack = UIStackView().then { vstack in
            vstack.axis = .vertical
            vstack.distribution = .fillEqually
            vstack.frame = self.frame
        }
        vstack.addArrangedSubviews(views)
        addSubview(vstack)
    }
    
}

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
