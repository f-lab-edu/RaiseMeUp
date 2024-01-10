//
//  MainViewController.swift
//  RaiseMeUp
//
//  Created by Sh Hong on 2023/11/21.
//

import UIKit
import Combine

final class MainViewController: UIViewController {
    
    private var mainView: MainView {
        return self.view as! MainView
    }
    
    private let viewModel: MainViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private let titleLocalized = String(localized: "MAIN_TITLE_LABEL",
    defaultValue: "Just Do It!",
    comment: "메인 화면의 타이틀 텍스트")
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = titleLocalized
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = MainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.$program
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.mainView.programListView.reloadData()
            }
            .store(in: &cancellables)
    }
}
