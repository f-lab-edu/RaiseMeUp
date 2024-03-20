//
//  SceneDelegate.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 2023/10/31.
//

import UIKit
import Coordinator
import Root

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var rootCoordinator: RootCoordinatorProtocol?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        let rootNavigationController = self.setUpRootNavigationController(in: scene)
        self.startRootCoordinator(rootNavigationController)
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

extension SceneDelegate {
    private func startRootCoordinator(_ navigationController: UINavigationController) {
        let coordinator = RootCoordinator(navigationController: navigationController)
        self.rootCoordinator = coordinator
        rootCoordinator?.start()
    }
    
    private func setUpRootNavigationController(in scene: UIScene) -> UINavigationController {
        guard let windowScene = (scene as? UIWindowScene) else {
            return UINavigationController()
        }
        let navigationController = UINavigationController()
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
        
        return navigationController
    }
}

