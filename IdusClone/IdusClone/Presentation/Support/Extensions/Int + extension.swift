//
//  Int + extension.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/09.
//

import Foundation

extension Int {
    var toStringWithComma: String {
        var result: [String] = []
        for (i, value) in Array(String(self)).reversed().enumerated() {
            if i % 3 == 0 && i > 0{
                result.append(",")
            }
            result.append(String(value))
        }
        return result.reversed().reduce("")  { $0 + $1 }
    }
}
