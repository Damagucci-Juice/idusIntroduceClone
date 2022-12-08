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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpSearchController()
//        let starView = FiveStarView(ratingAmount: 4.0, isContinues: true)
//        self.view.addSubview(starView)
//
//        starView.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            make.width.equalTo(100)
//            make.height.equalTo(50)
//        }
//        let progressView = ProgressBarView(progressRating: 0.2)
//        view.addSubview(progressView)
//        progressView.snp.makeConstraints { make in
//            make.leading.trailing.centerY.equalToSuperview()
//            make.height.equalTo(10)
//        }
//
        let appDetail = AppIntroduction(id: 123, appName: "123", sellerName: "123", isGameCenterEnabled: false, screenshotURLs: [], artworkULR60: URL(string: "123")!, artworkULR512: URL(string: "123")!, artworkULR100: URL(string: "123")!, releaseNotes: "123", artistID: 123, artistName: "123", genres: [], price: 0.0, resultDescription: "123", primaryGenreName: "123", primaryGenreID: 123, currentVersionReleaseDate: Date.now, contentAdvisoryRating: "123", trackContentRating: "123", minimumOSVersion: "", languageCodes: [], fileSizeBytes: "", sellerURL: URL(string: "123")!, formattedPrice: "123", averagedUserRating: 4.7924325734, userRatingCount: 239, version: "123123423")
        
        let ratingView = RatingReviewView(appDetail: appDetail)
        self.view.addSubview(ratingView)
        ratingView.snp.makeConstraints { make in
            make.leading.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setUpSearchController() {
        self.navigationItem.titleView = searchBar
        searchBarDelegate.viewController = self
        searchBar.delegate = self.searchBarDelegate
    }
    
}
