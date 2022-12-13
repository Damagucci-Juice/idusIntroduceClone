//
//  ViewController.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/05.
//
import SnapKit
import UIKit
import Then

//    - KakaoTalk: 362057947
//    - YouTube: 544007664
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
        setupNavBar()
        setupAddSubView()
        setupBiding()
        setupAttribute()
        setupLayout()
    }
    
}

extension MainViewController {
    private func setUpSearchController() {
        searchBarDelegate.viewController = self
        searchBar.delegate = self.searchBarDelegate
    }
    
    private func setupNavBar() {
        navigationItem.backButtonTitle = "Search"
        navigationItem.titleView = searchBar
    }
    private func setupAddSubView() {
        
    }
    
    private func setupLayout() {
       
    }
    
    private func setupAttribute() {

    }
    
    private func setupBiding() {
        searchBarDelegate.onSearched = { [unowned self] appInfo in
            self.navigationController?.pushViewController(AppDetailViewController(appInfo), animated: false)
        }
    }
}
