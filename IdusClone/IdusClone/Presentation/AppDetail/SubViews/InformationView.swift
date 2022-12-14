//
//  InformationView.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/07.
//
import SnapKit
import UIKit
import Then

final class InformationView: UIView {

    private let appDetail: AppIntroduction
    
    private let uiFactory = UIFactory()
    
    private var data: [(String, String)] = []
    
    private let title = UILabel().then { label in
        label.text = "Information"
        label.font = .mediumTitle
        label.textColor = .label
    }

    private let stackView = UIStackView().then { stackView in
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = Const.mediumSpacing
    }
    
    init(appDetail: AppIntroduction) {
        self.appDetail = appDetail
        super.init(frame: CGRect(x: 0, y: 0, width: .zero, height: .zero))
        setupAddSubview()
        setupAttribute(appDetail)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension InformationView {
    private func setupAddSubview() {
        self.addSubviews([title, stackView])
    }
    
    private func setupLayout() {
        uiFactory.makeDivider { divider in
            self.addSubview(divider)
            divider.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(Const.largeSpacing)
                make.top.equalToSuperview()
                make.height.equalTo(Const.dividerHeight)
            }
        }
        
        title.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Const.largeSpacing)
            make.top.equalToSuperview().offset(Const.mediumSpacing)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(Const.mediumSpacing)
            make.leading.trailing.equalToSuperview().inset(Const.largeSpacing)
            make.bottom.equalToSuperview()
        }
        data.forEach { (key, value) in
            uiFactory.makeInfoRow(key, value) { stackView in
                self.stackView.addArrangedSubview(stackView)
                uiFactory.makeDivider { divider in
                    self.stackView.addArrangedSubview(divider)
                    divider.snp.makeConstraints { make in
                        make.leading.trailing.equalToSuperview()
                        make.height.equalTo(Const.dividerHeight)
                    }
                }
            }
        }
    }
    
    private func setupAttribute(_ appDetail: AppIntroduction) {
        let first = [
            "Provider", "Size", "Category",
            "Compatibility", "Languages", "Age Rating",
            "In-App Purchases", "Copyright"
        ]
        
        var version: String
        if appDetail.minimumOSVersion >= 14 {
            if #available(iOS 14.0, *) {
                version = "Works on this iPhone"
            } else {
                version = "This app is unavailable"
            }
        } else {
            version = "This app is unavailable"
        }
        
        let second = [
            appDetail.artistName,
            appDetail.fileSizeBytes,
            appDetail.primaryGenreName,
            version,
            appDetail.languageCodes.joined(separator: " and "),
            appDetail.contentAdvisoryRating,
            "Yes",
            appDetail.sellerName
        ]
        for (index, key) in first.enumerated() {
            data.append((key, second[index]))
        }
    }
}
