//
//  LoginViewModel.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/23/23.
//

import Foundation
import AuthenticationServices

final class LoginViewModel {
    private let useCase: AuthUseCase
    @Published var loginResult: Result<User, Error>?
    
    init(
        useCase: AuthUseCase,
        loginResult: Result<User, Error>? = nil
    ) {
        self.useCase = useCase
    }
    
    func requestAppleLogin(credential: ASAuthorizationAppleIDCredential) {
        let result = self.useCase.saveAppleIDToken(with: credential)
        self.loginResult = result
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
