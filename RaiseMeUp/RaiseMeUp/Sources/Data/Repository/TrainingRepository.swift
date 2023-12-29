//
//  TrainingRepository.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/28/23.
//

import UIKit

struct TrainingRepository: TrainingRepositoryProtocol {
    
    private let trainingDataSource: TrainingDataSourceProtocol
    
    init(trainingDataSource: TrainingDataSourceProtocol) {
        self.trainingDataSource = trainingDataSource
    }
    
    func trainingProgram() async throws -> PullUpTrainingPlan {
        return try await trainingDataSource.trainingProgram().toDomain()
    }
}
