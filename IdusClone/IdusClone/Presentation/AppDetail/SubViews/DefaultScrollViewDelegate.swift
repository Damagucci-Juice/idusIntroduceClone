//
//  DefaultScrollViewDelegate.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/13.
//

import UIKit

final class DefaultScrollDelegate: NSObject, UIScrollViewDelegate {
    var vc: AppDetailViewController?
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let vc = vc,
              let titleView = vc.navigationItem.titleView
        else { return }
        let safeAreaTop = vc.view.safeAreaInsets.top
        let offset: CGFloat = safeAreaTop + scrollView.contentOffset.y
        let alpha: CGFloat = 1 - (offset / safeAreaTop)
        vc.ratingView.alpha = alpha
        titleView.alpha = 1 - alpha
    }
}
