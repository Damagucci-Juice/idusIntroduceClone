//
//  RepresentView.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/13.
//
import SnapKit
import UIKit
import Then

final class RepresentView: UIView {
    
    private let appDetail: AppIntroduction
    var onDownload: () -> Void = { }
    var onShared: () -> Void = { }
    
    private let imageView = UIImageView().then { imageView in
        imageView.frame = CGRect(x: 0, y: 0, width: .zero, height: .zero)
        imageView.clipsToBounds = true
    }
    
    private let vstack = UIStackView().then { stackView in
        stackView.axis = .vertical
        stackView.spacing = Const.miniSpacing
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
    }
    
    private let hstack = UIStackView().then { stackView in
        stackView.axis = .horizontal
        stackView.spacing = Const.miniSpacing
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
    }
    
    private let appNameLabel = UILabel().then { label in
        label.font = .mediumTitle
        label.textColor = .label
        label.numberOfLines = 2
    }
    
    private let artistNameLabel = UILabel().then { label in
        label.font = .descriptionText
        label.textColor = .secondaryLabel
    }
    
    private let inAppPurchaseLabel = UILabel().then { label in
        label.numberOfLines = 2
        label.textAlignment = .left
        label.text = """
                    In-App
                    Purchases
                    """
        label.font = .smallText
    }
    
    private lazy var downloadButton = BasePaddingButton(primaryAction: .init(handler: { _ in
        self.onDownload()
    })).then { button in
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .tintColor
        button.layer.cornerRadius = button.intrinsicContentSize.height / 2
        button.clipsToBounds = true
        button.titleLabel?.font = .totalRating
    }
    
    private lazy var shareButton = UIButton(primaryAction: .init(handler: { _ in
        self.onShared()
    })).then { button in
        let config = UIImage.SymbolConfiguration(pointSize: .zero ,weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: "square.and.arrow.up", withConfiguration: config)
        button.setImage(largeBoldDoc, for: .normal)
    }
    
    init(appDetail: AppIntroduction) {
        self.appDetail = appDetail
        super.init(frame: .zero)
        setupAddSubview()
        setupAttribute(appDetail)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RepresentView {
    private func setupAddSubview() {
        hstack.addArrangedSubviews([downloadButton, inAppPurchaseLabel])
        vstack.addArrangedSubviews([appNameLabel, artistNameLabel])
        addSubviews([imageView, vstack, hstack, shareButton])
    }
    private func setupAttribute(_ info: AppIntroduction) {
        imageView.load(url: info.artworkULR512)
        appNameLabel.text = info.appName
        artistNameLabel.text = info.artistName
        imageView.layer.cornerRadius = Const.mediumSpacing
    }
    private func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(3.5)
            make.height.equalTo(imageView.snp.width)
            make.leading.equalToSuperview().offset(Const.largeSpacing)
            make.top.equalToSuperview().offset(Const.mediumSpacing)
        }
        
        vstack.snp.makeConstraints { make in
            make.top.equalTo(imageView)
            make.leading.equalTo(imageView.snp.trailing).offset(Const.largeSpacing)
            make.trailing.equalToSuperview().inset(Const.largeSpacing)
        }
        
        hstack.snp.makeConstraints { make in
            make.leading.equalTo(vstack)
            make.bottom.equalTo(imageView).offset(Const.smallSpacing)
        }
        
        shareButton.snp.makeConstraints { make in
            make.trailing.equalTo(vstack)
            make.centerY.equalTo(hstack)
        }
    }
}
