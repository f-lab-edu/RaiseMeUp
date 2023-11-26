//
//  KeyChainType.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/26/23.
//

import Foundation

enum KeychainType {
    case accessToken
    
    var toString: String {
        switch self {
        case .accessToken:
            return "accessToken"
        }
    }
}
