//
//  BasePaddingButton.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/13.
//

import UIKit

final class BasePaddingButton: UIButton {
    private var padding = UIEdgeInsets(top: Const.minimumSpacing,
                                       left: Const.xxxLargeSpacing,
                                       bottom: Const.minimumSpacing,
                                       right: Const.xxxLargeSpacing)

    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}
