//
//  AppDetailViewController.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/06.
//

import SnapKit
import UIKit

final class AppDetailViewController: UIViewController {
    
    private let defaultScrollView = UIScrollView().then { scrollView in
        scrollView.showsVerticalScrollIndicator = false
    }
    
    private let contentView = UIView().then { view in }
    
    private let defaultScrollDelegate = DefaultScrollDelegate()
    
    lazy var representView = RepresentView(appDetail: appDetail)
    
    private let sampleImageScrollView = UIScrollView().then { scrollView in
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
    }

    private let sampleImageContainer = UIStackView().then { stackView in
        stackView.axis = .horizontal
        stackView.spacing = Const.smallSpacing
    }
    
    lazy var rankView = RankView(ratingCount: appDetail.userRatingCount,
                                 ratingAmount: appDetail.averagedUserRating,
                                 recommandAge: appDetail.contentAdvisoryRating,
                                 primaryGenre: appDetail.primaryGenreName)
    
    private let appIntroductionLabel = UITextView().then { label in
        label.font = .descriptionText
        label.textColor = .label
//        label.numberOfLines = 3
        label.isUserInteractionEnabled = false
        label.showsVerticalScrollIndicator = false
        label.sizeToFit()
    }
    
    private lazy var moreIntroductionButton = UIButton().then { button in
        button.addAction(UIAction(handler: { [unowned self] _ in
            DispatchQueue.main.async {
                self.appIntroductionLabel.text = self.appDetail.introduction
                self.appIntroductionLabel.snp.updateConstraints { make in
                    make.height.equalTo(1100)
                }
                button.removeFromSuperview()
            }
        }), for: .touchUpInside)
        button.setTitle("more", for: .normal)
        button.setTitleColor(.tintColor, for: .normal)
    }
    
    private let reviewScrollView = UIScrollView().then { scrollView in
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
    }

    private let reviewContainer = UIStackView().then { stackView in
        stackView.axis = .horizontal
        stackView.spacing = Const.smallSpacing
    }
        
    let inAppPurchaseLabel = UILabel().then { label in
        label.numberOfLines = 2
        label.textAlignment = .left
        label.text = """
                    In-App
                    Purchases
                    """
        label.font = .smallText
    }
    
    lazy var downloadButton = BasePaddingButton().then { button in
        button.addAction(.init(handler: { _ in
            print("GET! GET")
        }), for: .touchUpInside)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .tintColor
        button.layer.cornerRadius = 17
        button.clipsToBounds = true
        button.titleLabel?.font = .totalRating
    }
    
    lazy var ratingView = RatingProgressView(appDetail: appDetail)
    
    private lazy var whatNewView = WhatNewView(currentVersion: appDetail.version,
                                               updateDate: appDetail.currentVersionReleaseDate,
                                               newDescription: appDetail.releaseNotes)
    
    private lazy var informationView = InformationView(appDetail: appDetail)
    
    private lazy var availableDeviceLabel = UIStackView().then { stackview in
        stackview.axis = .horizontal
        stackview.distribution = .fillProportionally
    }
    
    private let appDetail: AppIntroduction
    
    private let uiFactory = UIFactory()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ detail: AppIntroduction) {
        self.appDetail = detail
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupAddSubView()
        setupAttribute()
        setupBinding()
        setupLayout()
    }
}

extension AppDetailViewController {
    
    private func setupNavBar() {
        let beutifulMagicNumber: CGFloat = 10
        let navibarHeight = (navigationController?.navigationBar.frame.height ?? 0) - beutifulMagicNumber
        let imageView = UIImageView()
        imageView.load(url: appDetail.artworkULR60)
        imageView.frame = CGRect(x: 0, y: 0, width: navibarHeight, height: navibarHeight)
        imageView.layer.cornerRadius = navibarHeight / 7
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        let labelButton = UIBarButtonItem(customView: inAppPurchaseLabel)
        let downButton = UIBarButtonItem(customView: downloadButton)
        let currWidth = downButton.customView?.widthAnchor.constraint(equalToConstant: 75)
        currWidth?.isActive = true
        let currHeight = downButton.customView?.heightAnchor.constraint(equalToConstant: navibarHeight)
        currHeight?.isActive = true
        
        navigationItem.setRightBarButtonItems([downButton, labelButton], animated: false)
        navigationItem.titleView = imageView
    }
    
    private func setupAddSubView() {
        view.addSubview(defaultScrollView)
        defaultScrollView.addSubview(contentView)
        contentView.addSubviews([
            representView, rankView, ratingView,
            reviewScrollView, whatNewView, informationView,
            sampleImageScrollView, availableDeviceLabel, appIntroductionLabel,
            moreIntroductionButton
        ])
        reviewScrollView.addSubview(reviewContainer)
        sampleImageScrollView.addSubview(sampleImageContainer)
    }
    
    private func setupLayout() {
        defaultScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.width.equalTo(defaultScrollView)
            make.height.equalTo(defaultScrollView).priority(.low)
        }
        
        representView.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(contentView)
            make.height.equalTo(150)
        }
        
        uiFactory.makeDivider { divider in
            view.addSubview(divider)
            divider.snp.makeConstraints { make in
                make.top.equalTo(representView.snp.bottom)
                make.leading.equalTo(contentView).offset(Const.largeSpacing)
                make.trailing.equalTo(contentView).inset(Const.largeSpacing)
                make.height.equalTo(Const.dividerHeight)
            }
        }
        
        rankView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView)
            make.top.equalTo(representView.snp.bottom)
            make.height.equalTo(100)
        }
        
        sampleImageScrollView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(Const.mediumSpacing)
            make.trailing.equalTo(contentView).inset(Const.mediumSpacing)
            make.top.equalTo(rankView.snp.bottom)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.65)
        }

        sampleImageContainer.snp.makeConstraints { make in
            make.edges.height.equalToSuperview()
            make.width.equalToSuperview().priority(.low)
        }
        
        appDetail.screenshotURLs.forEach { url in
            let imageView = UIImageView(backgroundColor: .progressBackground)
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = Const.largeSpacing
            imageView.clipsToBounds = true
            imageView.load(url: url)
            sampleImageContainer.addArrangedSubview(imageView)
            
            // 세로 이미지 레이아웃 모드
            imageView.snp.makeConstraints { make in
                make.width.equalTo(self.view.safeAreaLayoutGuide).multipliedBy(0.55)
            }
        }
        
        availableDeviceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Const.xLargeSpacing)
            make.top.equalTo(sampleImageScrollView.snp.bottom).offset(Const.mediumSpacing)
        }
        
        uiFactory.makeDivider { divider in
            view.addSubview(divider)
            divider.snp.makeConstraints { make in
                make.top.equalTo(availableDeviceLabel.snp.bottom).offset(Const.xLargeSpacing)
                make.leading.equalTo(contentView).offset(Const.largeSpacing)
                make.trailing.equalTo(contentView).inset(Const.largeSpacing)
                make.height.equalTo(Const.dividerHeight)
            }
        }
        
        appIntroductionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Const.largeSpacing)
            make.top.equalTo(availableDeviceLabel.snp.bottom).offset(Const.xxxLargeSpacing)
            make.height.equalTo(63)
        }
        
        moreIntroductionButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(appIntroductionLabel)
            make.height.equalTo(appIntroductionLabel).dividedBy(3)
        }
        
        ratingView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(appIntroductionLabel.snp.bottom)
            make.height.equalTo(165)
        }
        
        reviewScrollView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(Const.mediumSpacing)
            make.trailing.equalTo(contentView).inset(Const.mediumSpacing)
            make.top.equalTo(ratingView.snp.bottom)
            make.height.equalTo(200)
        }

        reviewContainer.snp.makeConstraints { make in
            make.edges.height.equalToSuperview()
            make.width.equalToSuperview().priority(.low)
        }
        
        uiFactory.makeReviewCard().forEach { view in
            reviewContainer.addArrangedSubview(view)
            view.snp.makeConstraints { make in
                make.width.equalTo(self.view.safeAreaLayoutGuide).inset(Const.largeSpacing)
                make.height.equalTo(reviewScrollView)
            }
        }

        uiFactory.makeDivider { divider in
            view.addSubview(divider)
            divider.snp.makeConstraints { make in
                make.top.equalTo(reviewScrollView.snp.bottom).offset(Const.xLargeSpacing)
                make.leading.equalTo(contentView).offset(Const.largeSpacing)
                make.trailing.equalTo(contentView).inset(Const.largeSpacing)
                make.height.equalTo(Const.dividerHeight)
            }
        }

        whatNewView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(reviewScrollView.snp.bottom).offset(Const.largeSpacing)
            make.height.equalTo(150)
        }
        
        informationView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(whatNewView.snp.bottom).offset(Const.largeSpacing)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupAttribute() {
        view.backgroundColor = .white
        defaultScrollView.delegate = defaultScrollDelegate
        defaultScrollDelegate.vc = self
        
        // MARK: - AvailableStackView 생성
        if !appDetail.screenshotURLs.isEmpty {
            let label = UILabel().then { label in
                label.text = "iPhone"
                label.font = .fogText
                label.textColor = .lightGray
            }
            let image = UIImage(systemName: "iphone")?.tinted(with: .lightGray)
            let imageView = UIImageView(image: image)
            availableDeviceLabel.addArrangedSubviews([imageView, label])
        }
        appIntroductionLabel.text = appDetail.shortIntroduction
        moreIntroductionButton.backgroundColor = .white
    }
    
    private func setupBinding() {
        Task {
            self.representView.onShared = {
                //TODO: - share 기능 추가
                print("represent shared tapped")
            }
            
            self.representView.onDownload = {
                //TODO: - Download 기능 추가
                print("represent get tapped")
            }
            
            self.informationView.onWebTapped = { [unowned self]  in
                UIApplication.shared.open(self.appDetail.sellerURL)
            }
        }
    }
}
