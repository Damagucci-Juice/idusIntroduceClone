//
//  WhatNewView.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/07.
//

import SnapKit
import UIKit
import Then

final class WhatNewView: UIView {
    private let title = UILabel().then { label in
        label.text = "What's New"
        label.font = .mediumTitle
        label.textColor = .label
    }
    
    private let currentVersion = UILabel().then { label in
        label.font = .ratingCount
        label.textColor = .gray
    }
    
    private let updateDate = UILabel().then { label in
        label.textColor = .gray
        label.font = .descriptionText
    }
    
    private let newDescription = UILabel().then { label in
        label.textColor = .label
        label.font = .descriptionText
        label.numberOfLines = 3
        label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
    
    init(currentVersion: String, updateDate: Date, newDescription: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: .zero, height: .zero))
        self.currentVersion.text = currentVersion
        self.updateDate.text = updateDate.toRecentDays
        self.newDescription.text = newDescription
        setupAddSubview()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        let version = "Version 3.6.0"
        var dateComponent = DateComponents()
        dateComponent.year = Int.random(in: 2020...2022)
        dateComponent.month = Int.random(in: 1...12)
        dateComponent.day = Int.random(in: 1...30)
        let date = Calendar.current.date(from: dateComponent) ?? Date.now
        let longText = """
                        Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                        """
        self.init(currentVersion: version, updateDate: date, newDescription: longText)
    }
}

extension WhatNewView {
    private func setupAddSubview() {
        self.addSubviews([title, currentVersion, updateDate, newDescription])
    }
    
    private func setupLayout() {
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Const.mediumSpacing)
            make.leading.equalToSuperview().offset(Const.largeSpacing)
        }
        currentVersion.snp.makeConstraints { make in
            make.leading.equalTo(title)
            make.top.equalTo(title.snp.bottom).offset(Const.mediumSpacing)
        }
        updateDate.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Const.largeSpacing)
            make.centerY.equalTo(currentVersion)
        }
        newDescription.snp.makeConstraints { make in
            make.leading.equalTo(title)
            make.trailing.equalTo(updateDate)
            make.top.equalTo(currentVersion.snp.bottom).offset(Const.mediumSpacing)
        }
        
    }
}
 
