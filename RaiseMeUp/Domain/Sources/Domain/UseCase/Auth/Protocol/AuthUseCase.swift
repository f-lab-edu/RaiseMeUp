//
//  AuthUseCase.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/26/23.
//

import Foundation
import AuthenticationServices
import Shared
import RMNetwork

protocol AuthUseCase {
    func saveAppleIDToken(with credential: ASAuthorizationAppleIDCredential) -> Result<User, KeychainError>
}
