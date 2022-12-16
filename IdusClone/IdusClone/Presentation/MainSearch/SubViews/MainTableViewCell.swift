//
//  MainTableViewCell.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/16.
//

import SnapKit
import UIKit
import Then

final class MainTableViewCell: UITableViewCell {

    static var identifer: String {
        String(describing: Self.self)
    }
    
    private let appImageView = UIImageView().then { imageview in
        imageview.backgroundColor = .progressBackground
        imageview.layer.cornerRadius = 10
        imageview.clipsToBounds = true
    }
    
    private let titleLabel = UILabel().then { label in
        label.font = .smallTitle
    }
    
    private let primaryGenreLabel = UILabel().then { label in
        label.font = .ratingCount
        label.textColor = .secondaryLabel
    }
    
    private let fiveStarView = FiveStarView(ratingAmount: 0, isContinues: true)
    
    private let ratingCountLabel = UILabel().then { label in
        label.font = .ratingCount
        label.textColor = .lightGray
    }
    
    private let downloadButton = UIButton().then { button in
        button.setImage(UIImage(systemName: "chevron.right")?.tinted(with: .lightGray), for: .normal)
        button.setTitleColor(.tintColor, for: .normal)
        button.layer.cornerRadius = Const.mediumSpacing
        button.clipsToBounds = true
    }
    
    private let infoStackView = UIStackView().then { stack in
        stack.axis = .vertical
        stack.spacing = Const.minimumSpacing
        stack.distribution = .equalSpacing
        stack.alignment = .leading
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAddSubview()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        appImageView.image = .remove
        titleLabel.text = .none
        primaryGenreLabel.text = .none
        fiveStarView.ratingAmount = 0
        ratingCountLabel.text = .none
    }
    
    public func setupAttribute(_ appInfo: AppIntroduction) {
        appImageView.load(url: appInfo.artworkULR100)
        titleLabel.text = appInfo.appName
        fiveStarView.ratingAmount = appInfo.averagedUserRating.roundUnder1()
        ratingCountLabel.text = appInfo.userRatingCountString
        primaryGenreLabel.text = appInfo.primaryGenreName
        downloadButton.addAction(UIAction(handler: { _ in
            
        }), for: .touchUpInside)
    }
    
    private func setupAddSubview() {
        addSubviews([appImageView, infoStackView, downloadButton, ratingCountLabel])
        infoStackView.addArrangedSubviews([
            titleLabel,
            primaryGenreLabel,
            fiveStarView
        ])
    }
    
    private func setupLayout() {
        appImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(Const.largeSpacing)
            make.bottom.equalToSuperview().inset(Const.largeSpacing)
            make.width.equalTo(appImageView.snp.height)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(appImageView)
            make.leading.equalTo(appImageView.snp.trailing).offset(Const.mediumSpacing)
            make.width.equalTo(150)
        }
        
        downloadButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Const.largeSpacing)
            make.centerY.equalTo(infoStackView)
        }
        
        fiveStarView.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(80)
        }
        
        ratingCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(fiveStarView.snp.trailing).offset(Const.mediumSpacing)
            make.bottom.equalTo(infoStackView)
        }
    }
}
