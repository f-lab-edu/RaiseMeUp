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
        let dataSource = TrainingDataSource()
        let repository = TrainingRepository(trainingDataSource: dataSource)
        let useCase = Training(repository: repository)
        let viewModel = MainViewModel(useCase: useCase)
        let viewController = MainViewController(viewModel: viewModel)
        self.navigationController.viewControllers = [viewController]
    }
    
    func finish() {
        
    }
}
