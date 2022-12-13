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
    
    private let reviewScrollView = UIScrollView().then { scrollView in
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
    }

    private let reviewScrollViewContainer = UIStackView().then { stackView in
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
    
//    lazy var downloadButton = BasePaddingButton(primaryAction: .init(handler: { _ in
//        print("GET! GET")
//    })).then { button in
//        button.setTitle("GET", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = .tintColor
//        button.layer.cornerRadius = button.intrinsicContentSize.height / 2
//        button.clipsToBounds = true
//        button.titleLabel?.font = .totalRating
//    }
    lazy var downloadButton = BasePaddingButton(padding: UIEdgeInsets(top: 2, left: 30, bottom: 2, right: 30)).then { button in
        button.addAction(.init(handler: { _ in
            print("GET! GET")
        }), for: .touchUpInside)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .tintColor
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.titleLabel?.font = .totalRating
    }
    
    lazy var ratingView = RatingProgressView(appDetail: appDetail)
    
    private lazy var whatNewView = WhatNewView(currentVersion: appDetail.version,
                                               updateDate: appDetail.currentVersionReleaseDate,
                                               newDescription: appDetail.releaseNotes)
    
    private lazy var informationView = InformationView(appDetail: appDetail)
    
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
        navigationItem.setRightBarButtonItems([downButton, labelButton], animated: false)
        navigationItem.titleView = imageView
    }
    
    private func setupAddSubView() {
        view.addSubview(defaultScrollView)
        defaultScrollView.addSubview(contentView)
        contentView.addSubviews([representView, ratingView, reviewScrollView, whatNewView, informationView])
        reviewScrollView.addSubview(reviewScrollViewContainer)
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
            make.height.equalTo(130)
        }
        
        uiFactory.makeDivider { divider in
            view.addSubview(divider)
            divider.snp.makeConstraints { make in
                make.top.equalTo(representView.snp.bottom).offset(Const.xLargeSpacing)
                make.leading.equalTo(contentView).offset(Const.largeSpacing)
                make.trailing.equalTo(contentView).inset(Const.largeSpacing)
                make.height.equalTo(Const.dividerHeight)
            }
        }
        
        ratingView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(representView)
            make.top.equalTo(representView.snp.bottom).offset(Const.mediumSpacing)
            make.height.equalTo(165)
        }
        
        reviewScrollView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(Const.mediumSpacing)
            make.trailing.equalTo(contentView).inset(Const.mediumSpacing)
            make.top.equalTo(ratingView.snp.bottom)
            make.height.equalTo(200)
        }

        reviewScrollViewContainer.snp.makeConstraints { make in
            make.top.bottom.equalTo(reviewScrollView)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        uiFactory.makeReviewCard().forEach { view in
            reviewScrollViewContainer.addArrangedSubview(view)
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
        self.defaultScrollView.delegate = defaultScrollDelegate
        defaultScrollDelegate.vc = self
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
        }
    }
}
