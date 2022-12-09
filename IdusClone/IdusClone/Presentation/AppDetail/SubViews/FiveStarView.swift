//
//  StarView.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/07.
//
import SnapKit
import UIKit
import Then

final class FiveStarView: UIView {
    
    private let highLightedImage = UIImage(systemName: "star.fill")
    private let defaultImage = UIImage(systemName: "star")
    private var highLightColor: UIColor {
        return isContinues ? .lightGray : .highlightedStarLight
    }
    private let isContinues: Bool
    var ratingAmount: Double {
        didSet {
            setupLayout()
        }
    }
    private let maxStartCount = 5
    private var intNumber: Int { Int(ratingAmount) }
    
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }
    
    init(ratingAmount: Double, isContinues: Bool = false) {
        self.ratingAmount = ratingAmount
        self.isContinues = isContinues
        super.init(frame: CGRect(x: 0, y: 0, width: .max, height: .max))
        setupLayout()
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        for i in 1..<maxStartCount + 1 {
            var amount: Double = i <= intNumber ? 1.0 : 0.0
            if i > intNumber && Double(i) <= ceil(ratingAmount) {
               let temp = ratingAmount - Double(intNumber)
                amount = round(temp * 10) / 10
            }
            let view = StarRatingView(ratingAmount: amount, color: highLightColor)
            stackView.addArrangedSubview(view)
        }
    }
}
