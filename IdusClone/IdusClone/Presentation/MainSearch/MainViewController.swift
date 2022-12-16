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
    
    private let tableView = UITableView().then { tableView in
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifer)
        tableView.separatorColor = .clear
    }
    
    private let datasource = DefaultTableDataSource()
    
    private let searchBarDelegate = DefaultSearchBarDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpSearchController()
        setupAddSubView()
        setupBiding()
        setupAttribute()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
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
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "App Store"
    }
    private func setupAddSubView() {
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupAttribute() {
        tableView.dataSource = datasource
        tableView.delegate = datasource
    }
    
    private func setupBiding() {
        searchBarDelegate.onSearched = { [unowned self] appInfo in
            self.navigationController?.pushViewController(AppDetailViewController(appInfo), animated: false)
        }
        
        datasource.viewModel.onUpdate = { [unowned self] in
            Task {
                tableView.reloadData()
            }
        }
        
        datasource.onTapped = { [unowned self] appIntro in
            Task {
                navigationController?.pushViewController(AppDetailViewController(appIntro), animated: true)
            }
        }
    }
}
