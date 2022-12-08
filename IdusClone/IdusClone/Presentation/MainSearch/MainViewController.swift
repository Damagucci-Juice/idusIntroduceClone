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
        let progressView = ProgressBarView(progressRating: 0.2)
        view.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.leading.trailing.centerY.equalToSuperview()
            make.height.equalTo(10)
        }
        
    }
    
    private func setUpSearchController() {
        self.navigationItem.titleView = searchBar
        searchBarDelegate.viewController = self
        searchBar.delegate = self.searchBarDelegate
    }
    
}
