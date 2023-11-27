//
//  RootCoordinator.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/27/23.
//

import UIKit

final class RootCoordinator: RootCoordinatorProtocol {
    
    var childCoordinator: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginViewModel = LoginViewModel(
            useCase: Auth(),
            coordinator: RootCoordinator(navigationController: navigationController)
        )
        let viewController = LoginViewController(viewModel: loginViewModel)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openMainCoordinator() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        self.childCoordinator.append(mainCoordinator)
        mainCoordinator.start()
    }
}
