//
//  ExerciseCounterCoordinator.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 12/14/23.
//

import UIKit

final class ExerciseCounterCoordinator: ExerciseCounterCoordinatorProtocol {
    var navigationController: UINavigationController
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .exerciseCounter }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = ExerciseCounterViewController()
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func finish() {
        self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }

}
