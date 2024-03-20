//
//  TrainingRepository.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/28/23.
//

import UIKit
import Shared
import Domain

public struct TrainingRepository: TrainingRepositoryProtocol {
    
    private let trainingDataSource: TrainingDataSourceProtocol
    
    public init(trainingDataSource: TrainingDataSourceProtocol) {
        self.trainingDataSource = trainingDataSource
    }
    
    public func trainingProgram() async throws -> PullUpProgram {
        do {
            return try await trainingDataSource.trainingProgram().toDomain()
        } catch let error as NetworkError {
            switch error {
            case .invalidStatusCode, .notReachable, .timeOut:
                throw TrainingError.notConnected
            case .noData:
                throw TrainingError.emptyData
            case .unknown:
                throw TrainingError.unknown
            }
        } catch {
            throw TrainingError.unknown
        }
        
    }
}
