//
//  ProviderProtocol.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 12/28/23.
//

import Foundation

public enum NetworkError: Error {
    case invalidStatusCode
    case noData
    case notReachable
    case timeOut
    case unknown
}


protocol ProviderProtocol {
    func request<T: Decodable>(_ urlRequest: URLRequest, completion: @escaping(Result<T, Error>) -> Void)
}

class Provider: ProviderProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func request<T: Decodable>(_ urlRequest: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode else {
                completion(.failure(NetworkError.invalidStatusCode))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
