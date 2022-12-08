//
//  ProgressBarView.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/08.
//
import SnapKit
import UIKit
import Then

final class ProgressBarView: UIView {
    private let progressRating: Double
    private let backgroundView = UIView().then { view in
        view.backgroundColor = .lightGray
        view.clipsToBounds = true
        view.layer.cornerRadius = 4.5
    }
    private let foregroundView = UIView().then { view in
        view.backgroundColor = .darkGray
    }
    
    init(progressRating: Double) {
        self.progressRating = progressRating
        super.init(frame: CGRect(x: 0, y: 0, width: .zero, height: .zero))
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("only use init(frame)")
    }
}

extension ProgressBarView {
    private func setupLayout() {
        self.addSubview(backgroundView)
        backgroundView.addSubview(foregroundView)
        
        backgroundView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.height.equalTo(10)
        }
        
        foregroundView.snp.makeConstraints { make in
            make.leading.height.equalTo(backgroundView)
            make.width.equalTo(backgroundView).multipliedBy(progressRating)
        }
    }
}
