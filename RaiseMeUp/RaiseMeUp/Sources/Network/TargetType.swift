//
//  TargetType.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 12/28/23.
//

import Foundation

public typealias HTTPMethod = String
public typealias HTTPHeaders = [String: String]

public protocol TargetType {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var path: String { get }
    var parameters: RequestParams? { get }
}

public enum RequestParams {
    case query(_ parameter: Encodable?)
    case body(_ parameter: Encodable?)
}

public extension TargetType {
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: baseURL)?.appendingPathComponent(path) else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        
        // Headers 설정
        headers.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }
        
        // Parameters 설정
        switch parameters {
        case .query(let request):
            guard let request = request
            else {
                throw URLError(.badURL)
            }
            let queryItems = request.toDictionary().map { dictionary in
                let queryItem = dictionary.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
                return queryItem
            }
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = queryItems
            urlRequest.url = components?.url
        case .body(let request):
            guard let request = request
            else {
                throw URLError(.badURL)
            }
            do {
                let jsonData = JSONEncoder().encode(request)
                urlRequest.httpBody = jsonData
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                throw error
            }
        default:
            break
        }
        
        return urlRequest
    }
}

public extension Encodable {
    func toDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any]
    }
}
