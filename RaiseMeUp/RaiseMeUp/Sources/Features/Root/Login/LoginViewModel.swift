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
        let userIdentifier = credential.user
        
        let email = credential.email ?? "이메일 입력"
        let fullName = "\(String(describing: credential.fullName))"
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
