//
//  TrainingUseCase.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/28/23.
//

import Foundation

protocol TrainingUseCase {
    func getProgramList() async throws -> PullUpProgram
}
