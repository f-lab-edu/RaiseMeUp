//
//  MainCoordinator.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/27/23.
//

import UIKit

final class MainCoordinator: MainCoordinatorProtocol, CoordinatorFinishDelegate {
    var finishDelegate: CoordinatorFinishDelegate?

    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    var type: CoordinatorType { .main }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let dataSource = TrainingDataSource()
        let repository = TrainingRepository(trainingDataSource: dataSource)
        let useCase = Training(repository: repository)
        let viewModel = MainViewModel(useCase: useCase)
        viewModel.coordinator = self
        let viewController = MainViewController(viewModel: viewModel)
        self.navigationController.viewControllers = [viewController]
    }
    
    func presentExerciseCounter(routine: [Int]) {
        let coordinator = ExerciseCounterCoordinator(
            navigationController: navigationController,
            routine: routine
        )
        childCoordinators.append(coordinator)
        coordinator.finishDelegate = self
        coordinator.start()
    }
    
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        guard case .exerciseCounter = childCoordinator.type else {
            return
        }
        self.childCoordinators.removeAll()
        self.navigationController.popViewController(animated: true)
    }
    
    func finish() {
        
    }
}
