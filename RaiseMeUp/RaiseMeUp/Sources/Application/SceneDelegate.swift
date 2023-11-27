//
//  SceneDelegate.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 2023/10/31.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var rootCoordinator: RootCoordinator?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let navigationController = UINavigationController()
        let coordinator = RootCoordinator(navigationController: navigationController)
        self.rootCoordinator = coordinator
        
        let window = UIWindow(windowScene: windowScene)
        
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
        rootCoordinator?.start()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

