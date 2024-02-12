//
//  Training.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/28/23.
//

import Foundation

public struct Training: TrainingUseCase {
    
    private let repository: TrainingRepositoryProtocol
    
    init(repository: TrainingRepositoryProtocol) {
        self.repository = repository
    }
    
    public func getProgramList() async -> Result<PullUpProgram, TrainingError> {
        do {
            let program = try await repository.trainingProgram()
            guard !program.program.isEmpty else { return .failure(.emptyData) }
            
            return .success(program)
        } catch let error as NetworkError {
            switch error {
            case .invalidStatusCode, .notReachable, .timeOut:
                return .failure(.notConnected)
            case .noData:
                return .failure(.emptyData)
            case .unknown:
                return .failure(.unknown)
            }
        } catch {
            return .failure(.unknown)
        }
    }
}
