//
//  ExerciseCounterRouter.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 12/14/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Shared
import Coordinator

protocol ExerciseCounterRoutingLogic {
    func dismiss()
}

protocol ExerciseCounterDataPassing
{
    var dataStore: ExerciseCounterDataStore? { get }
}

public class ExerciseCounterRouter: NSObject, ExerciseCounterRoutingLogic, ExerciseCounterDataPassing, ExerciseCounterCoordinatorProtocol
{
    
    weak var viewController: ExerciseCounterViewController?
    var dataStore: ExerciseCounterDataStore?
    
    public var navigationController: UINavigationController
    
    public var finishDelegate: CoordinatorFinishDelegate?
    
    public var childCoordinators: [Coordinator] = []
    
    public var type: CoordinatorType { .exerciseCounter }
    private var routine: [Int]
    
    public init(
        navigationController: UINavigationController,
        routine: [Int]
    ) {
        self.navigationController = navigationController
        self.routine = routine
    }
    
    public func start() {
        let viewController = ExerciseCounterViewController()
        let router = self
        viewController.router = self
        dataStore?.routine = router.routine
        router.viewController = viewController
        router.dataStore = viewController.interactor
        viewController.interactor?.routine = routine
        
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    public func finish() {
        self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    func dismiss() {
        finish()
    }
}
