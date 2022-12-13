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
              let titleView = vc.navigationItem.titleView,
              let safeAreaTop: CGFloat = SceneDelegate.shared?.window?.safeAreaInsets.top
        else { return }
        let magicalSafeAreaTop: CGFloat = safeAreaTop + (vc.navigationController?.navigationBar.frame.height ?? 0)
        let offset: CGFloat = magicalSafeAreaTop + scrollView.contentOffset.y
        let alpha: CGFloat = 2 - (offset / safeAreaTop)
        vc.representView.alpha = alpha
        titleView.alpha = (1 - alpha) / 1.2
    }
}
