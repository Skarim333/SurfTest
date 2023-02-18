//
//  SceneDelegate.swift
//  SurfTest
//
//  Created by Карим Садыков on 13.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let mainView = MainViewController()
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = mainView
        self.window = window
        window.makeKeyAndVisible()
    }

}

