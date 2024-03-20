//
//  RUButton.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 12/29/23.
//

import UIKit

class RUButton: UIButton {
    
    enum Style {
        case start
        case end
        
        var text: String {
            switch self {
            case .start:
                return "START"
            case .end:
                return "END"
            }
        }
        
        var textColor: UIColor {
            switch self {
            case .start, .end:
                return .white
            }
        }
        
        var backgroundColor: UIColor {
            switch self {
            case .start:
                return .red
            case .end:
                return .blue
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    convenience init(style: RUButton.Style) {
        var config = UIButton.Configuration.plain()
        let attributedString = AttributedString(
            style.text,
            attributes: AttributeContainer([
                .font: UIFont.systemFont(ofSize: 50, weight: .semibold),
                .foregroundColor: style.textColor
            ])
        )
        config.attributedTitle = attributedString
        config.contentInsets = .init(
            top: 16,
            leading: 32,
            bottom: 16,
            trailing: 32
        )
        
        self.init(configuration: config)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = true
        self.layer.cornerCurve = .continuous
        self.backgroundColor = style.backgroundColor
        
        self.configurationUpdateHandler = { [weak self] btn in
            switch btn.state {
            case .highlighted:
                self?.animateButton(isHighlighted: true)
            default:
                self?.animateButton(isHighlighted: false)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.layer.cornerRadius = self.bounds.height / 2
    }
}

extension RUButton {
    private func animateButton(isHighlighted: Bool) {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = 0.1
        animation.repeatCount = 1
        animation.autoreverses = false
        animation.toValue = isHighlighted ? 0.95 : 1.0
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        self.layer.add(animation, forKey: "transform.scale")
    }
}
