//
//  LoginCoordinator.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/27/23.
//

import UIKit

final class LoginCoordinator: LoginCoordinatorProtocol {
    var navigationController: UINavigationController
    var finishDelegate: CoordinatorFinishDelegate?
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .login }
    init(
        navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginViewModel = LoginViewModel(
            useCase: Auth(),
            coordinator: self
        )
        let viewController = LoginViewController(viewModel: loginViewModel)
        self.navigationController.viewControllers = [viewController]
    }
    
    func finish() {
        self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}
