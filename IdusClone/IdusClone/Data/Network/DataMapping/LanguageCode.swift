//
//  LanguageCode.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/13.
//

import Foundation

enum LanguageCode: String, Codable {
    case afghan = "AF"
    case english = "EN"
    case korean = "KO"
    case japanese = "JA"
    case italian = "IT"
    case chinese = "ZH"
    case spanish = "ES"
    case german = "DE"
    case french = "FR"
    
    var capitalized: String {
        return String(describing: self).capitalized
    }
}


