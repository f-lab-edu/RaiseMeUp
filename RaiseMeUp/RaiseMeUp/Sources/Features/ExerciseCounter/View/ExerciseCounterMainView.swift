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
    
    lazy var startButton: UIButton = {
        var config = UIButton.Configuration.plain()
        let attributedString = AttributedString(
            "Start",
            attributes: AttributeContainer([
                .font: UIFont.systemFont(ofSize: 50, weight: .semibold),
                .foregroundColor: UIColor.white
            ])
        )
        config.attributedTitle = attributedString
        config.contentInsets = .init(
            top: 16,
            leading: 32,
            bottom: 16,
            trailing: 32
        )
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerCurve = .continuous
        button.backgroundColor = .red
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
        let attributedString = AttributedString(
            "End",
            attributes: AttributeContainer([
                .font: UIFont.systemFont(ofSize: 50, weight: .semibold),
                .foregroundColor: UIColor.white
            ])
        )
        config.attributedTitle = attributedString
        config.contentInsets = .init(
            top: 16,
            leading: 32,
            bottom: 16,
            trailing: 32
        )
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
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
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        startButton.layer.cornerRadius = startButton.bounds.height / 2
        endButton.layer.cornerRadius = endButton.bounds.height / 2
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
