//
//  SceneDelegate.swift
//  PokerHelper
//
//  Created by Nikita Luzhbin on 14.05.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        self.window = UIWindow(frame: UIScreen.main.bounds)
        let home = MainTabBar()
        self.window?.rootViewController = home
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
    }
}

