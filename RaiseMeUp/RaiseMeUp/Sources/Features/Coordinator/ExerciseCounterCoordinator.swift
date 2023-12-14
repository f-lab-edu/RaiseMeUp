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
    private var routine: [Int]
    
    init(
        navigationController: UINavigationController,
        routine: [Int]
    ) {
        self.navigationController = navigationController
        self.routine = routine
    }
    
    func start() {
        let viewController = ExerciseCounterViewController()
        var dataStore = viewController.router?.dataStore
        dataStore?.routine = self.routine
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func finish() {
        self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }

}
