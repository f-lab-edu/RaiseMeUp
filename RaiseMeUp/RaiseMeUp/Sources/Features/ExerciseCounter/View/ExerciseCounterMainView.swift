//
//  ExerciseCounterMainView.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 12/14/23.
//

import UIKit

protocol ExerciseCounterMainViewLister: AnyObject {
    func backgroundViewTapped()
}

final class ExerciseCounterMainView: UIView {
    
    weak var lister: ExerciseCounterMainViewLister?
    
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
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.text = "2"
        label.isHidden = true
        return label
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 50, weight: .semibold)
        label.text = "00:00"
        label.isHidden = true
        return label
    }()
    
    let endButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "End"
        config.contentInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .largeTitle)
        button.backgroundColor = .blue
        button.isHidden = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        addSubviews()
        setBackgroundTappedAction()
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
        self.addSubview(countLabel)
        self.addSubview(timerLabel)
        self.addSubview(endButton)
    }
    
    // MARK: - Layout
    private func layout() {
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            countLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            timerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            endButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            endButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func setBackgroundTappedAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func backgroundViewTapped() {
        lister?.backgroundViewTapped()
    }
}
