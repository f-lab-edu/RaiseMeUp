//
//  MainCoordinator.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/27/23.
//

import UIKit

final class MainCoordinator: Coordinator {
    var finishDelegate: CoordinatorFinishDelegate?

    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    var type: CoordinatorType { .main }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = MainViewController()
        self.navigationController.viewControllers = [viewController]
    }
    
    func finish() {
        
    }
}
