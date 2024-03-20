//
//  RootCoordinator.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/27/23.
//

import UIKit
import Shared
import Coordinator
import Main

final public class RootCoordinator: RootCoordinatorProtocol {

    public var childCoordinators: [Coordinator] = []
    public var navigationController: UINavigationController
    public weak var finishDelegate: CoordinatorFinishDelegate?
    
    public var type: CoordinatorType { .root }

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        if KeychainManager.shared.load(key: .accessToken)?.isEmpty == true {
            let loginCoordinator = LoginCoordinator(navigationController: navigationController)
            loginCoordinator.finishDelegate = self
            self.childCoordinators.append(loginCoordinator)
            loginCoordinator.start()
        } else {
            openMainCoordinator()
        }
    }
    
    public func finish() {
        
    }

    public func openMainCoordinator() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        self.finishDelegate = self
        self.childCoordinators.append(mainCoordinator)
        mainCoordinator.startAtSwiftUI()
    }
    
    public func openLoginCoordinator() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        loginCoordinator.finishDelegate = self
        self.childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
    }
}

extension RootCoordinator: CoordinatorFinishDelegate {
    public func coordinatorDidFinish(childCoordinator: Coordinator) {
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
