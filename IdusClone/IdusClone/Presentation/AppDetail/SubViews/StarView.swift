//
//  StarView.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/07.
//
import SnapKit
import UIKit
import Then

final class StarView: UIView {
    
    private let highLightedImage = UIImage(systemName: "star.fill")
    private let defaultImage = UIImage(systemName: "star")
    private var highLightColor: UIColor {
        return isContinues ? .lightGray : .highlightedStarLight
    }
    private let isContinues: Bool
    private let ratingAmount: Double
    private let maxStartCount = 5
    private var intNumber: Int { Int(ratingAmount) }
    
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }
    
    init(ratingAmount: Double, isContinues: Bool = false) {
        self.ratingAmount = ratingAmount
        self.isContinues = isContinues
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        isContinues ? setupContinuesLayout()  : setupUncontinuesLayout()
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUncontinuesLayout() {
        for i in 1..<maxStartCount + 1 {
            let imageView = UIImageView()
            imageView.image = i <= intNumber ? highLightedImage : defaultImage
            imageView.setImageColor(color: highLightColor)
            stackView.addArrangedSubview(imageView)
        }
    }
    
    func setupContinuesLayout() {
        
    }
}
