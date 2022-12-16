//
//  DefaultTableDataSource.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/16.
//

import UIKit

final class DefaultTableDataSource: NSObject, UITableViewDataSource {
    let viewModel = MainViewModel()
    
    var onTapped: (AppIntroduction) -> Void = { _ in }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifer, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.setupAttribute(viewModel.data[indexPath.row])
        cell.selectedBackgroundView = .init(backgroundColor: .clear)
        return cell
    }
}

extension DefaultTableDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onTapped(viewModel.data[indexPath.row])
    }    
}
