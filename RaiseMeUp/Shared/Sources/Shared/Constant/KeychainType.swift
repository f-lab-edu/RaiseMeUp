//
//  KeyChainType.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/26/23.
//

import Foundation

public enum KeychainType {
    case accessToken
    
    var keychainIdentifier: String {
        switch self {
        case .accessToken:
            return "accessToken"
        }
    }
}
