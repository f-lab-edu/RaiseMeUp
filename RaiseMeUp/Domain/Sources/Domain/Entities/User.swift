//
//  User.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/23/23.
//

import Foundation

public struct User {
    public let name: String
    public let email: String
    
    public init(
        name: String,
        email: String
    ) {
        self.name = name
        self.email = email
    }
}
