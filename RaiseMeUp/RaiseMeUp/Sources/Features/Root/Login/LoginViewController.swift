//
//  LoginViewController.swift
//  RaiseMeUp
//
//  Created by Sh Hong on 2023/11/21.
//

import UIKit
import AuthenticationServices
import Combine

import OSLog

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
//        self.viewModel.$loginResult
//            .sink { result in
//                switch result {
//                case .success(let user):
//                    print("다음 뷰로 가시오")
//                case .failure(let error):
//                    print("에러가 떨어졌소")
//                case .none:
//                    break
//                }
//            }
//            .store(in: &cancellables)
    }
    
    private func setUp() {
        mainView.appleLoginButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
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
        let message = error.localizedDescription
        os_log(.info, log: .ui, "%@", message)
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
