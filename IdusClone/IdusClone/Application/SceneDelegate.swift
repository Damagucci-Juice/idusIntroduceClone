//
//  SceneDelegate.swift
//  IdusClone
//
//  Created by YEONGJIN JANG on 2022/12/05.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    static var shared: SceneDelegate?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let navigationContorller = UINavigationController(rootViewController: MainViewController())
        window.rootViewController = navigationContorller
        self.window = window
        window.makeKeyAndVisible()
        Self.shared = self
    }

}

