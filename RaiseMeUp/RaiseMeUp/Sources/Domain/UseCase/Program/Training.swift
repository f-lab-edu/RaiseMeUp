//
//  Training.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/28/23.
//

import Foundation

struct Training: TrainingUseCase {
    
    private let repository: TrainingRepositoryProtocol
    
    init(repository: TrainingRepositoryProtocol) {
        self.repository = repository
    }
    
    func getProgramList() async throws -> PullUpProgram {
        return try await repository.trainingProgram()
    }
}
