//
//  CoordinatorFinishDelegate.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/27/23.
//

import Foundation

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}
