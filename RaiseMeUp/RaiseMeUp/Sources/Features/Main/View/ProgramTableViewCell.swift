//
//  ProgramTableViewCell.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/28/23.
//

import UIKit

final class ProgramTableViewCell: UITableViewCell {
    
    private enum Metric {
        static let horizontalMargin = 16.0
        static let verticalMargin = 8.0
        static let spacing = 4.0
    }
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false 
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private let titleStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = Metric.spacing
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func bind(_ dayTitle: String, routineTitle: String) {
        self.dayLabel.text = dayTitle
        
        if routineTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            self.titleLabel.text = "오늘은 쉬는 날"
        } else {
            self.titleLabel.text = routineTitle
        }
    }
    
    // MARK: - Add Subviews
    private func addSubviews() {
        [dayLabel, titleLabel]
            .forEach {
                self.titleStackView.addArrangedSubview($0)
            }
        self.contentView.addSubview(titleStackView)
    }
    
    // MARK: - Layout
    private func layout() {
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: self.titleStackView.topAnchor),
            dayLabel.bottomAnchor.constraint(equalTo: self.titleStackView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.titleStackView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.titleStackView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: Metric.verticalMargin),
            titleStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Metric.verticalMargin),
            titleStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Metric.horizontalMargin),
            titleStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Metric.horizontalMargin),
        ])
    }
}
