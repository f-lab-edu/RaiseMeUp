//
//  ReusableView.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/27/23.
//

import UIKit

public protocol ReusableView: AnyObject {
    /// Get identifier from class
    static var defaultReuseIdentifier: String { get }
}

public extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        // Set the Identifier from class name
        return NSStringFromClass(self)
    }
}
