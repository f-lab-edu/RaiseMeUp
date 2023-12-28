//
//  TrainingDataSource.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/28/23.
//

import Foundation

struct TrainingDataSource: TrainingDataSourceProtocol {
    private let provider: Provider
    
    public init() {
        self.provider = Provider()
    }
    
    func trainingProgram(completion: @escaping (Result<PullUpProgramDTO, Error>) -> Void) {
        do {
            let urlRequest = try TrainingTarget.program.asURLRequest()
            provider.request(urlRequest) { result in
                completion(result)
            }
        } catch {
            completion(.failure(error))
        }
    }
}

enum TrainingTarget {
    case program
}

extension TrainingTarget: TargetType {
    var baseURL: String {
        return "https://my-json-server.typicode.com/"
    }
    
    var method: HTTPMethod {
        return "GET"
    }
    
    var headers: HTTPHeaders {
        let headers = HTTPHeaders()
        return headers
    }
    
    var path: String {
        return "Peter1119/PullUp_DB/db"
    }
    
    var parameters: RequestParams? {
        switch self {
        case .program:
            return nil
        }
    }
}
