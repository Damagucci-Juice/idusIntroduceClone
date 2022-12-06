//
//  ViewController.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/05.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        let appCode = (Bundle.main.object(forInfoDictionaryKey: "AppCode") as? String) ?? "앱코드"
        searchBar.placeholder = "\(appCode)를 입력해주세요"
        return searchBar
    }()
    
    public let networkManager = NetworkManager()
    
    private let searchBarDelegate = DefaultSearchBarDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpSearchController()
    }
    
    private func setUpSearchController() {
        self.navigationItem.titleView = searchBar
        searchBarDelegate.viewController = self
        searchBar.delegate = self.searchBarDelegate
    }
    
}
