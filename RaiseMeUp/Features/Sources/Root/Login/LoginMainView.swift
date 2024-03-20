//
//  LoginMainView.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/23/23.
//

import UIKit
import AuthenticationServices

final class LoginMainView: UIView {
    var appleLoginButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func layout() {
        self.addSubview(appleLoginButton)
        self.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            appleLoginButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25),
            appleLoginButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25),
            appleLoginButton.heightAnchor.constraint(equalToConstant: 60),
            appleLoginButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
