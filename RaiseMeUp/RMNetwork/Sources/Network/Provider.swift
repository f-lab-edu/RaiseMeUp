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

public protocol ProviderProtocol {
    func request<T: Decodable>(
        _ urlRequest: URLRequest,
        retryCount: Int
    ) async throws -> T
}

public final class Provider: ProviderProtocol {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func request<T: Decodable>(
        _ urlRequest: URLRequest,
        retryCount: Int = 3
    ) async throws -> T {
        var attempts = 0
        while attempts < retryCount {
            do {
                return try await performBasicRequest(urlRequest)
            } catch let error as NetworkError {
                switch error {
                case .timeOut, .notReachable:
                    attempts += 1
                    try await Task.sleep(nanoseconds: 2_000_000_000 * UInt64(attempts))
                default:
                    throw error
                }
            }
        }
        throw NetworkError.timeOut
    }
    
    private func performBasicRequest<T: Decodable>(_ urlRequest: URLRequest) async throws -> T {
        do {
            let (data, response) = try await session.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode
            else {
                throw NetworkError.invalidStatusCode
            }
            
            guard !data.isEmpty else {
                throw NetworkError.noData
            }
            
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error as URLError {
            switch error.code {
            case .notConnectedToInternet:
                throw NetworkError.notReachable
            case .timedOut:
                throw NetworkError.timeOut
            default:
                throw NetworkError.unknown
            }
        } catch {
            throw NetworkError.unknown
        }
    }
}
