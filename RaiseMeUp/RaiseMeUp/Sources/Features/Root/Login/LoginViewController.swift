//
//  LoginViewController.swift
//  RaiseMeUp
//
//  Created by Sh Hong on 2023/11/21.
//

import UIKit
import AuthenticationServices
import Combine

final class LoginViewController: UIViewController {
    
    private var cancellables = Set<AnyCancellable>()
    
    private var mainView: LoginMainView {
        return self.view as! LoginMainView
    }
    
    private let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = LoginMainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        bind()
    }
    
    private func bind() {
        self.viewModel.$loginResult
            .sink { result in
                switch result {
                case .success(let user):
                    print(user)
                case .failure(let error):
                    print(error.localizedDescription)
                case .none: 
                    break
                }
            }
            .store(in: &cancellables)
    }
    
    private func setUp() {
        mainView.appleLoginButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.presentAppleAuthorizationController(delegate: self)
        }), for: .touchUpInside)
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIdCredential as ASAuthorizationAppleIDCredential:
            viewModel.requestAppleLogin(credential: appleIdCredential)
        default:
            break
        }
    }
    
    // TODO: - 인증 실패 처리
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
