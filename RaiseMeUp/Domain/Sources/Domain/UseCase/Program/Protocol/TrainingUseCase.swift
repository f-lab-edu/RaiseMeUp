//
//  TrainingUseCase.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/28/23.
//

import Foundation

public enum TrainingError: Error {
    case emptyData
    case notConnected
    case unknown
}

public protocol TrainingUseCase {
    func getProgramList() async -> Result<PullUpProgram, TrainingError>
}
