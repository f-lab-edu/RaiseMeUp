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
    private let coordinator: RootCoordinatorProtocol?
//    @Published var loginResult: Result<User, KeychainError>?
    
    init(
        useCase: AuthUseCase,
        coordinator: RootCoordinatorProtocol?
    ) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    func requestAppleLogin(credential: ASAuthorizationAppleIDCredential) {
        let result = self.useCase.saveAppleIDToken(with: credential)
//        self.loginResult = result
        
        switch result {
        case .success(let _):
            self.coordinator?.openMainCoordinator()
        case .failure(let error):
            print(error.localizedDescription)
        }
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
