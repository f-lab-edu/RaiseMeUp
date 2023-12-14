//
//  ExerciseCounterMainView.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 12/14/23.
//

import UIKit

final class ExerciseCounterMainView: UIView {
    let startButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "Start"
        config.contentInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .largeTitle)
        button.backgroundColor = .yellow
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        layout()
        
        super.updateConstraints()
    }
    
    // MARK: - Add Subviews
    private func addSubviews() {
        self.addSubview(startButton)
    }
    
    // MARK: - Layout
    private func layout() {
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
