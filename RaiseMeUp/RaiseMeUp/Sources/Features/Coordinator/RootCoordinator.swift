//
//  RootCoordinator.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/27/23.
//

import UIKit
import Shared

final class RootCoordinator: RootCoordinatorProtocol {

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var type: CoordinatorType { .root }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if KeychainManager.shared.load(key: .accessToken)?.isEmpty == true {
            let loginCoordinator = LoginCoordinator(navigationController: navigationController)
            loginCoordinator.finishDelegate = self
            self.childCoordinators.append(loginCoordinator)
            loginCoordinator.start()
        } else {
            openMainCoordinator()
        }
    }
    
    func finish() {
        
    }

    func openMainCoordinator() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        self.finishDelegate = self
        self.childCoordinators.append(mainCoordinator)
        mainCoordinator.startAtSwiftUI()
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
