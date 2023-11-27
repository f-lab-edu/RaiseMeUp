//
//  Coordinator.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/27/23.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    var childCoordinators: [Coordinator] { get set }
    var type: CoordinatorType { get }

    func start()
    func finish()
}
