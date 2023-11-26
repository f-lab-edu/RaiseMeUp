//
//  AuthUseCase.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/26/23.
//

import Foundation

protocol AuthUseCase {
    func saveAppleIDToken(with idToken: String) -> Result<  User, KeychainError>
}
