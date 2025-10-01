//
//  SceneDelegate.swift
//  DeliveryApp
//
//  Created by Karina Kinzhigaliyeva on 02.09.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let mainVC = MainViewController()
        mainVC.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "house"), tag: 0)
        
        let secondVC = UIViewController()
        secondVC.view.backgroundColor = .white
        secondVC.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(systemName: "trash"), tag: 1)
        
        
        let thirdVC = UIViewController()
        thirdVC.view.backgroundColor = .white
        thirdVC.tabBarItem = UITabBarItem(title: "Заказы", image: UIImage(systemName: "bag"), tag: 2)
        
        let fourthVC = UIViewController()
        fourthVC.view.backgroundColor = .white
        fourthVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), tag: 3)
        
        let nav1 = UINavigationController(rootViewController: mainVC)
        let nav2 = UINavigationController(rootViewController: secondVC)
        let nav3 = UINavigationController(rootViewController: thirdVC)
        let nav4 = UINavigationController(rootViewController: fourthVC)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [nav1, nav2, nav3, nav4]
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

}

