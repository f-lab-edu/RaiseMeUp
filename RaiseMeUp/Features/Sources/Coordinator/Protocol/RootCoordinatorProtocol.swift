//
//  RootCoordinatorProtocol.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/27/23.
//

import UIKit
import Shared

public protocol RootCoordinatorProtocol: Coordinator {
    func openMainCoordinator()
    func openLoginCoordinator()
}
