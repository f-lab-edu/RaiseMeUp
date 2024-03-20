//
//  RoundedDecorationView.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 1/16/24.
//

import UIKit

final class RoundedBackgroundView: UICollectionReusableView {
    static let backgroundDecorationIdentifier = "backgroundDecoration"
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        backgroundColor = .lightGray.withAlphaComponent(0.3)
        layer.cornerRadius = 16
        layer.masksToBounds = true
    }
}
