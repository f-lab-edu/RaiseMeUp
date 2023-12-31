//
//  RootCoordinator.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/27/23.
//

import UIKit

final class RootCoordinator: RootCoordinatorProtocol {

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var type: CoordinatorType { .root }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        loginCoordinator.finishDelegate = self
        self.childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
    }
    
    func finish() {
        
    }

    func openMainCoordinator() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        self.finishDelegate = self
        self.childCoordinators.append(mainCoordinator)
        mainCoordinator.start()
    }
    
    func openLoginCoordinator() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        loginCoordinator.finishDelegate = self
        self.childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
    }
}

extension RootCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        self.navigationController.viewControllers.removeAll()
        self.childCoordinators.removeAll()
        
        switch childCoordinator.type {
        case .login:
            self.openMainCoordinator()
        case .main:
            self.openLoginCoordinator()
        default:
            break
        }
    }
}
