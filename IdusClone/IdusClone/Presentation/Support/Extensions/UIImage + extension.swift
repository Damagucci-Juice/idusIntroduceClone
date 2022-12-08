//
//  UIImage + extension.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/07.
//

import Foundation
import UIKit

extension UIImage {
    
    func drawRectangleOnImage(_ amount: CGFloat) -> UIImage {
        let scale: CGFloat = 0
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        draw(at: CGPoint.zero)
        let xPoint = round(size.width * amount * 10) / 10
        let width = round(size.width * (1 - amount) * 10) / 10
        let rectangle = CGRect(x: xPoint, y: 0, width: width, height: size.height)
        
        UIColor.white.setFill()
        UIRectFill(rectangle)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

extension UIImage {
    func tinted(with color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        color.set()
        withRenderingMode(.alwaysTemplate)
            .draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
