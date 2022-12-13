//
//  DefaultSearchBarDelegate.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/06.
//

import UIKit

final class DefaultSearchBarDelegate: NSObject, UISearchBarDelegate {
    
    var viewController: MainViewController?
    var onSearched: (AppIntroduction) -> Void = { _ in }

    func setup(_ viewController: MainViewController) {
        self.viewController = viewController
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
        let action = UIAction { _ in
            searchBar.text = ""
            searchBar.resignFirstResponder()
            self.viewController?.navigationItem.rightBarButtonItem = nil
        }
        let cancelButton = UIBarButtonItem(systemItem: .cancel, primaryAction: action)
        viewController?.navigationItem.rightBarButtonItem = cancelButton
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.viewController?.navigationItem.rightBarButtonItem = nil
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text,
              let appCode = Bundle.main.object(forInfoDictionaryKey: "AppCode") as? String,
              searchText == appCode
        else {
            let alert = UIAlertController(title: "다시 입력해주세요.", message: "872469884", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Fill", style: .default, handler: { _ in
                let appCode = Bundle.main.object(forInfoDictionaryKey: "AppCode") as? String
                searchBar.text = appCode ?? ""
            }))
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            viewController?.present(alert, animated: false)
            return
        }
        Task {
            guard let results = try await self.viewController?.networkManager.fetchData(searchText) else {
                return
            }
            self.onSearched(results[0].toDomain())
        }
    }
}
