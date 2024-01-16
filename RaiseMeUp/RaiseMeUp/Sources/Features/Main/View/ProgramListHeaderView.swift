//
//  ProgramListHeaderView.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/30/23.
//

import UIKit

final class ProgramListHeaderView: UICollectionReusableView {
    
    private enum Metric {
        static let horizontalMargin: CGFloat = 16
        static let verticalMargin: CGFloat = 4
        static let labelsSpacing: CGFloat = 8
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func bind(_ title: String, subTitle: String) {
        self.titleLabel.text = title
        self.subTitleLabel.text = subTitle
    }
    
    // MARK: - Add Subviews
    private func addSubviews() {
        [titleLabel, subTitleLabel]
            .forEach {
                self.addSubview($0)
            }
    }
    
    // MARK: - Layout
    private func layout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Metric.verticalMargin),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Metric.horizontalMargin)
        ])
        
        NSLayoutConstraint.activate([
            subTitleLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: Metric.labelsSpacing
            ),
            subTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Metric.horizontalMargin),
            subTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Metric.verticalMargin)
        ])
    }
}
