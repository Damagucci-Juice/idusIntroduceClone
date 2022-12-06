//
//  ViewController.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/05.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        let manager = NetworkManager()
        Task {
            let results = try await manager.fetchData("872469884")
            print(results.count)
        }
    }
}

