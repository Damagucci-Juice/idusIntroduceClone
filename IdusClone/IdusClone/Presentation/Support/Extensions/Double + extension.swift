//
//  Double + extension.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/08.
//

import Foundation

extension Double {
    func roundUnder1() -> Double {
        return (self * 10).rounded() / 10
    }
}
