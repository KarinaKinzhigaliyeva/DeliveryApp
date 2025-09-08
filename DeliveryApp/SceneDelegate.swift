//
//  SceneDelegate.swift
//  DeliveryApp
//
//  Created by Karina Kinzhigaliyeva on 02.09.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

        func scene(_ scene: UIScene,
                   willConnectTo session: UISceneSession,
                   options connectionOptions: UIScene.ConnectionOptions) {

            guard let windowScene = (scene as? UIWindowScene) else { return }

            let window = UIWindow(windowScene: windowScene)
            let rootVC = MainViewController()
            let navController = UINavigationController(rootViewController: rootVC)

            window.rootViewController = navController
            self.window = window
            window.makeKeyAndVisible()
        }

}

