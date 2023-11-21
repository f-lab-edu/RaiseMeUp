//
//  LoginViewController.swift
//  RaiseMeUp
//
//  Created by Sh Hong on 2023/11/21.
//

import UIKit
import AuthenticationServices

final class LoginViewController: UIViewController {
    
    let appleLoginButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction(handler: { action in
            
        }), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        
    }
    
    // MARK: - Layout
    private func layout() {
        self.view.addSubview(appleLoginButton)
        self.view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            appleLoginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            appleLoginButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}
