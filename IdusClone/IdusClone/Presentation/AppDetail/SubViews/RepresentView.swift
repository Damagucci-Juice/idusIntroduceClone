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
        // TODO: - Magic Number X
        imageView.clipsToBounds = true
    }
    
    private let vstack = UIStackView().then { stackView in
        stackView.axis = .vertical
        stackView.spacing = Const.smallSpacing
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
    }
    
    private let hstack = UIStackView().then { stackView in
        stackView.axis = .horizontal
        stackView.spacing = Const.miniSpacing
        stackView.distribution = .equalSpacing
        stackView.alignment = .lastBaseline
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
    
    private lazy var downloadButton = UIButton(primaryAction: .init(handler: { _ in
        self.onDownload()
    })).then { button in
        button.setTitle("GET", for: .normal)
    }
    
    private lazy var shareButton = UIButton(primaryAction: .init(handler: { _ in
        self.onShared()
    })).then { button in
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
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
        hstack.addArrangedSubviews([downloadButton, inAppPurchaseLabel, shareButton])
        vstack.addArrangedSubviews([appNameLabel, artistNameLabel, hstack])
        addSubviews([imageView, vstack])
    }
    private func setupAttribute(_ info: AppIntroduction) {
        imageView.load(url: info.artworkULR512)
        appNameLabel.text = info.appName
        artistNameLabel.text = info.artistName
        imageView.layer.cornerRadius = imageView.frame.height / 7
    }
    private func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(3.5)
            make.height.equalTo(imageView.snp.width)
            make.leading.equalToSuperview().offset(Const.largeSpacing)
            make.top.equalToSuperview().offset(Const.mediumSpacing)
        }
        
        vstack.snp.makeConstraints { make in
            make.centerY.equalTo(imageView)
            make.leading.equalTo(imageView.snp.trailing).offset(Const.mediumSpacing)
            make.trailing.equalToSuperview().inset(Const.largeSpacing)
        }
    }
}
