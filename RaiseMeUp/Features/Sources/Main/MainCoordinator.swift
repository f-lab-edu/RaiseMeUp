//
//  MainCoordinator.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/27/23.
//

import UIKit
import SwiftUI
import Shared
import Domain
import Coordinator
import Data
import ExerciseCounter

final public class MainCoordinator: MainCoordinatorProtocol, CoordinatorFinishDelegate {
    public var finishDelegate: CoordinatorFinishDelegate?

    public var childCoordinators: [Coordinator] = []
    
    public var navigationController: UINavigationController
    
    public var type: CoordinatorType { .main }
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let dataSource = TrainingDataSource()
        let repository = TrainingRepository(trainingDataSource: dataSource)
        let useCase = Training(repository: repository)
        let viewModel = MainViewModel(useCase: useCase)
        viewModel.coordinator = self
        let viewController = MainViewController(viewModel: viewModel)
        self.navigationController.viewControllers = [viewController]
    }
    
    public func startAtSwiftUI() {
        let dataSource = TrainingDataSource()
        let repository = TrainingRepository(trainingDataSource: dataSource)
        let useCase = Training(repository: repository)
        let viewModel = ExerciseViewModel(useCase: useCase)
        viewModel.coordinator = self
        let viewController = UIHostingController(
            rootView: ExerciseList(viewModel: viewModel)
        )
        self.navigationController.viewControllers = [viewController]
    }
    
    public func presentExerciseCounter(routine: [Int]) {
        let coordinator = ExerciseCounterRouter(
            navigationController: navigationController,
            routine: routine
        )
        childCoordinators.append(coordinator)
        coordinator.finishDelegate = self
        coordinator.start()
    }
    
    public func coordinatorDidFinish(childCoordinator: Coordinator) {
        guard case .exerciseCounter = childCoordinator.type else {
            return
        }
        self.childCoordinators.removeAll()
        self.navigationController.popViewController(animated: true)
    }
    
    public func finish() {
        
    }
}
