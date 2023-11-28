//
//  TrainingDataSource.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/28/23.
//

import Foundation

enum LocalError: Error {
    case noFile
    case parsingError
}

struct TrainingDataSource: TrainingDataSourceProtocol {
    func trainingProgram() -> Result<PullUpProgramDTO, LocalError> {
        guard let data = self.load() else {
            return .failure(.noFile)
        }
        
        do {
            let program = try JSONDecoder().decode(PullUpProgramDTO.self, from: data)
            return .success(program)
        } catch {
            return .failure(LocalError.parsingError)
        }
    }
}

extension TrainingDataSource {
    fileprivate func load() -> Data? {
        let fileName = "Program"
        let extensionType = "json"
        
        guard let fileLocation = Bundle.main.url(forResource: fileName, withExtension: extensionType) else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileLocation)
            return data
        } catch {
            return nil
        }
    }
}
