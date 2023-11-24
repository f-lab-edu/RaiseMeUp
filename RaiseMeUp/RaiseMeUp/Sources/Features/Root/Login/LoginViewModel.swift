//
//  LoginViewModel.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/23/23.
//

import Foundation
import AuthenticationServices

final class LoginViewModel {
    @Published var loginResult: Result<User, Error>?
    
    func requestAppleLogin(credential: ASAuthorizationAppleIDCredential) {
        let familyName = credential.fullName?.familyName ?? String()
        let givenName = credential.fullName?.givenName ?? String()
        let fullName = familyName + givenName
        let email = credential.email ?? String()
        
        guard let appleIDToken = credential.identityToken else {
            print("Unable to fetch identity token")
            return
        }
        
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
            return
        }
        
        let user = User(name: fullName, email: email)
        self.loginResult = Result.success(user)
    }
    
    func presentAppleAuthorizationController(delegate: ASAuthorizationControllerDelegate & ASAuthorizationControllerPresentationContextProviding) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = delegate
        authorizationController.presentationContextProvider = delegate
        authorizationController.performRequests()
    }
}
