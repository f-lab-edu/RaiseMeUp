//
//  NetworkError.swift
//
//
//  Created by 홍석현 on 3/20/24.
//

import Foundation

public enum NetworkError: Error {
    case invalidStatusCode
    case noData
    case notReachable
    case timeOut
    case unknown
}
