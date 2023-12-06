//
//  KeychainError.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/27/23.
//

import Foundation

enum KeychainError: Error {
    case noIdentityToken
    case unexpectedPasswordData
    case invalidTokenEncoding
    case unhandledError
}
