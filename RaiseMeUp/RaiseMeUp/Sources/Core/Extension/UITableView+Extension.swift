//
//  UITableView+Extension.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/27/23.
//

import UIKit

extension UITableViewCell: ReusableView { }

extension UITableView {
    /// Register cell with automatically setting Identifier
    public func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    /// Get cell with the default reuse cell identifier
    public func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell: \(T.self) with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return cell
    }
}
