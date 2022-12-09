//
//  ViewController.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/05.
//
import SnapKit
import UIKit
import Then

final class MainViewController: UIViewController {
    
    private let searchBar = UISearchBar().then {
        let appCode = (Bundle.main.object(forInfoDictionaryKey: "AppCode") as? String) ?? "앱코드"
        $0.placeholder = "\(appCode)를 입력해주세요"
    }
    
    public let networkManager = NetworkManager()
    
    private let searchBarDelegate = DefaultSearchBarDelegate()
    
    private let scrollView = UIScrollView().then { scrollView in
        scrollView.isPagingEnabled = true
    }
    
    private let scrollViewContainer = UIStackView().then { stackView in
        stackView.axis = .horizontal
        stackView.spacing = Const.mediumSpacing
    }
    
    //MARK: - Start 3, This 3 views will disappear.
    private let redView = UIView().then { view in
        view.backgroundColor = .red
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
    }
    private let blueView = UIView().then { view in
        view.backgroundColor = .blue
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
    }
    private let greenView = UIView().then { view in
        view.backgroundColor = .green
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
    }
    // MARK: - End 3
    
    let appDetail = AppIntroduction(id: 123, appName: "123", sellerName: "123", isGameCenterEnabled: false, screenshotURLs: [], artworkULR60: URL(string: "123")!, artworkULR512: URL(string: "123")!, artworkULR100: URL(string: "123")!, releaseNotes: "123", artistID: 123, artistName: "123", genres: [], price: 0.0, resultDescription: "123", primaryGenreName: "123", primaryGenreID: 123, currentVersionReleaseDate: Date.now, contentAdvisoryRating: "123", trackContentRating: "123", minimumOSVersion: "", languageCodes: [], fileSizeBytes: "", sellerURL: URL(string: "123")!, formattedPrice: "123", averagedUserRating: 4.7924325734, userRatingCount: 19170, version: "123123423")
    
    lazy var ratingView = RatingProgressView(appDetail: appDetail)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpSearchController()
        setupAddSubView()
        setupLayout()
        setupAttribute()
    }
    
    private func setUpSearchController() {
        self.navigationItem.titleView = searchBar
        searchBarDelegate.viewController = self
        searchBar.delegate = self.searchBarDelegate
    }
}

extension MainViewController {
    private func setupAddSubView() {
        self.view.addSubview(ratingView)
        self.view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.addArrangedSubviews([blueView, redView, greenView])
    }
    
    private func setupLayout() {
        ratingView.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(150)
        }
        
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(ratingView).inset(Const.mediumSpacing)
            make.top.equalTo(ratingView.snp.bottom)
            make.height.equalTo(200)
        }
        
        scrollViewContainer.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(scrollView)
        }
        
        redView.snp.makeConstraints { make in
            make.width.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.90)
            make.height.equalTo(scrollView)
        }
        blueView.snp.makeConstraints { make in
            make.width.equalTo(redView)
        }
        greenView.snp.makeConstraints { make in
            make.width.equalTo(redView)
        }
    }
    
    private func setupAttribute() {
        
    }
}
