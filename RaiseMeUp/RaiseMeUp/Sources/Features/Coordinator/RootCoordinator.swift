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
}

extension RootCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        
        if let _ = childCoordinator as? LoginCoordinator {
            self.childCoordinators.removeAll()
            self.navigationController.viewControllers = []
            self.openMainCoordinator()
        }
    }
}
