//
//  Auth.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/26/23.
//

import Foundation
import AuthenticationServices

struct Auth: AuthUseCase {
    func saveAppleIDToken(with credential: ASAuthorizationAppleIDCredential) -> Result<User, KeychainError> {
        let familyName = credential.fullName?.familyName ?? String()
        let givenName = credential.fullName?.givenName ?? String()
        let fullName = familyName + givenName
        let email = credential.email ?? String()
        
        guard let appleIDToken = credential.identityToken else {
            return .failure(.noIdentityToken)
        }
        
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            return .failure(.invalidTokenEncoding)
        }
        
        guard KeychainManager().save(key: .accessToken, data: idTokenString) else {
            return .failure(.unhandledError)
        }
        
        let user = User(name: fullName, email: email)
        return .success(user)
    }
}
