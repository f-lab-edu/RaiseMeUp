//
//  LoginViewModel.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/23/23.
//

import Foundation
import AuthenticationServices
import OSLog

final class LoginViewModel {
    private let useCase: AuthUseCase
    private let coordinator: LoginCoordinatorProtocol?
//    @Published var loginResult: Result<User, KeychainError>?
    
    init(
        useCase: AuthUseCase,
        coordinator: LoginCoordinatorProtocol?
    ) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    func requestAppleLogin(credential: ASAuthorizationAppleIDCredential) {
        let result = self.useCase.saveAppleIDToken(with: credential)
//        self.loginResult = result
        
        switch result {
        case .success:
            guard let coordinator = coordinator else { return }
            self.coordinator?.finishDelegate?.coordinatorDidFinish(childCoordinator: coordinator)
        case .failure(let error):
            let message = error.localizedDescription
            OSLog.message(.info, log: .ui, message)
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
