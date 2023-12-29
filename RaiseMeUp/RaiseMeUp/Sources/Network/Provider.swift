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
    func request<T: Decodable>(_ urlRequest: URLRequest) async throws -> T
}

class Provider: ProviderProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func request<T: Decodable>(_ urlRequest: URLRequest) async throws -> T {
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode
        else {
            throw NetworkError.invalidStatusCode
        }
        
        guard data.isEmpty == false else {
            throw NetworkError.noData
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
