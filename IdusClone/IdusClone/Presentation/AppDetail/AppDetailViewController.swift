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
    
    private let reviewScrollView = UIScrollView().then { scrollView in
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
    }

    private let reviewScrollViewContainer = UIStackView().then { stackView in
        stackView.axis = .horizontal
        stackView.spacing = Const.smallSpacing
    }
    
    lazy var ratingView = RatingProgressView(appDetail: appDetail)
    
    private lazy var whatNewView = WhatNewView(currentVersion: appDetail.version,
                                               updateDate: appDetail.currentVersionReleaseDate,
                                               newDescription: appDetail.releaseNotes)
    
    private lazy var informationView = InformationView(appDetail: appDetail)
    
    private let appDetail: AppIntroduction
    
    private let uiFactory = UIFactory()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ detail: AppIntroduction) {
        self.appDetail = detail
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupAddSubView()
        setupAttribute()
        setupLayout()
    }
}

extension AppDetailViewController {
    
    private func setupNavigation() {
        let titleView = UIImageView()
        titleView.load(url: appDetail.artworkULR60)
        titleView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        titleView.layer.cornerRadius = 5
        titleView.clipsToBounds = true
        navigationItem.titleView = titleView
    }
    
    private func setupAddSubView() {
        view.addSubview(defaultScrollView)
        defaultScrollView.addSubview(contentView)
        contentView.addSubviews([ratingView, reviewScrollView, whatNewView, informationView])
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
        
        ratingView.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(contentView)
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
}
