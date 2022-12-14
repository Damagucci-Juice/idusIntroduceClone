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
        let alpha: CGFloat = 1 - (offset / safeAreaTop)
        let reverseAlpha = 1 - alpha
        
        vc.representView.alpha = alpha
        vc.inAppPurchaseLabel.alpha = reverseAlpha
        vc.downloadButton.alpha = reverseAlpha
        titleView.alpha = reverseAlpha
    }
}
