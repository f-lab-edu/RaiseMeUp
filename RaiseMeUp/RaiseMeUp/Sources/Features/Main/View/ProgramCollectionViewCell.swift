//
//  ProgramCollectionViewCell.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/28/23.
//

import UIKit

final class ProgramCollectionViewCell: UICollectionViewCell {
    
    private enum Metric {
        static let horizontalMargin = 32.0
        static let verticalMargin = 16.0
        static let spacing = 8.0
    }
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .monospacedDigitSystemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private let routineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false 
        label.textColor = .label
        label.font = .monospacedDigitSystemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .right
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
    
    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .separator
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isAccessibilityElement = true
        addSubviews()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public func bind(_ cellModel: ProgramTableViewCellModel) {
        self.dayLabel.text = cellModel.day
        self.routineLabel.text = cellModel.routine
        
        self.routineLabel.textColor = cellModel.isRestDay ? .systemGreen : .label
        self.isUserInteractionEnabled = cellModel.isRestDay == false
        
        self.accessibilityLabel = "오늘의 운동\(cellModel.day), 운동 순서는 \(cellModel.routine)입니다."
        self.accessibilityHint = "더블탭하여 운동을 시작해보세요."
    }
    
    // MARK: - Add Subviews
    private func addSubviews() {
        [dayLabel, routineLabel]
            .forEach {
                self.titleStackView.addArrangedSubview($0)
            }
        self.addSubview(titleStackView)
        self.addSubview(separatorView)
    }
    
    // MARK: - Layout
    private func layout() {
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: self.titleStackView.topAnchor),
            dayLabel.bottomAnchor.constraint(equalTo: self.titleStackView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            routineLabel.topAnchor.constraint(equalTo: self.titleStackView.topAnchor),
            routineLabel.bottomAnchor.constraint(equalTo: self.titleStackView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: Metric.verticalMargin
            ),
            titleStackView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: -Metric.verticalMargin
            ),
            titleStackView.leftAnchor.constraint(
                equalTo: self.leftAnchor,
                constant: Metric.horizontalMargin
            ),
            titleStackView.rightAnchor.constraint(
                equalTo: self.rightAnchor,
                constant: -Metric.horizontalMargin
            ),
        ])
        
        NSLayoutConstraint.activate([
            separatorView.leftAnchor.constraint(
                equalTo: self.leftAnchor,
                constant: Metric.horizontalMargin
            ),
            separatorView.rightAnchor.constraint(
                equalTo: self.rightAnchor, 
                constant: -Metric.horizontalMargin
            ),
            separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
}
