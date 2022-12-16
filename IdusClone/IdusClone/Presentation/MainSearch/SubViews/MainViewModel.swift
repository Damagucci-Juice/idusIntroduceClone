//
//  MainViewModel.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/16.
//

import Foundation
//    - KakaoTalk: 362057947
//    - YouTube: 544007664
//    - Idus: 872469884
final class MainViewModel {
    var data: [AppIntroduction] = [] {
        didSet {
            onUpdate()
        }
    }
    
    var onUpdate: () -> Void = { }
    
    private let networkManager = NetworkManager()
    
    init() {
        ["362057947", "544007664", "872469884", "1076296181", "284882215"].forEach { id in
            Task {
                let appInfo = try await networkManager.fetchData(id)
                data.append(appInfo[0].toDomain())
            }
        }
    }
}
