//
//  UIImageView + extension.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/06.
//

import Foundation
import UIKit.UIImageView

extension UIImageView {
    func load(url: URL, size: CGSize? = nil) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        if let size = size {
                            self?.image = image.resized(to: size)
                        } else {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
    
    
}

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
