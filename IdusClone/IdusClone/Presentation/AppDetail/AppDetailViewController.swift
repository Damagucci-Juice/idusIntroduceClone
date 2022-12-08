//
//  AppDetailViewController.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/06.
//

import SnapKit
import UIKit

final class AppDetailViewController: UIViewController {

    private let label: UILabel = {
        let label = UILabel()
        label.text = "Detail Center"
        label.textColor = .white
        return label
    }()
    
    let appDetail: AppIntroduction
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ detail: AppIntroduction) {
        self.appDetail = detail
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = appDetail.appName
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
