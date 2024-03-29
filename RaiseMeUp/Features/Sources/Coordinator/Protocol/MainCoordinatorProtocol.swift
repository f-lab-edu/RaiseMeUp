//
//  MainCoordinatorProtocol.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 12/14/23.
//

import Foundation
import Shared

public protocol MainCoordinatorProtocol: Coordinator {
    func presentExerciseCounter(routine: [Int]) 
}
