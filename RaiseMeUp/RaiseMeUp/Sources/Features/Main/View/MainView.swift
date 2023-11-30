//
//  MainView.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/28/23.
//

import UIKit

final class MainView: UIView {
    
    let programTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.separatorStyle = .none
        tableView.register(ProgramTableViewCell.self)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .systemBackground
        
        addSubviews()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Add Subviews
    private func addSubviews() {
        self.addSubview(programTableView)
    }
    
    // MARK: - Layout
    private func layout() {
        NSLayoutConstraint.activate([
            programTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            programTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            programTableView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            programTableView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor)
        ])
    }
}
