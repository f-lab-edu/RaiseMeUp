//
//  MainView.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/28/23.
//

import UIKit

final class MainView: UIView {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    // MARK: - Layout
    private func layout() {
        
    }
}
