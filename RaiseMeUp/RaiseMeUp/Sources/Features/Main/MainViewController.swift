//
//  MainViewController.swift
//  RaiseMeUp
//
//  Created by Sh Hong on 2023/11/21.
//

import UIKit

final class MainViewController: UIViewController {
    
    private var mainView: MainView {
        return self.view as! MainView
    }
    
    private let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = MainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.programTableView.delegate = self
        mainView.programTableView.dataSource = self
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ProgramTableHeaderView()
        let section = viewModel.section(at: IndexPath(row: 0, section: section))
        headerView.bind(section.name, subTitle: section.description)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProgramTableViewCell.defaultReuseIdentifier) as? ProgramTableViewCell else { return UITableViewCell() }
        let section = viewModel.section(at: indexPath)
        let item = section.routine[indexPath.row]
        let cellModel = ProgramTableViewCellModel(item)
        
        cell.bind(cellModel)
        
        return cell
    }
}
