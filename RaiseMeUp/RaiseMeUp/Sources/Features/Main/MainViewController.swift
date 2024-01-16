//
//  MainViewController.swift
//  RaiseMeUp
//
//  Created by Sh Hong on 2023/11/21.
//

import UIKit
import Combine
import OSLog

final class MainViewController: UIViewController {
    
    private var mainView: MainView {
        return self.view as! MainView
    }

    private let viewModel: MainViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private let titleLocalized = String(localized: "MAIN_TITLE_LABEL",
    defaultValue: "Just Do It!",
    comment: "메인 화면의 타이틀 텍스트")
    
    var dataSource: UICollectionViewDiffableDataSource<TrainingLevel.ID, DailyRoutine.ID>!
    
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
        configureDataSource()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.isFinishLoaded
            .sink { completion in
                switch completion {
                case .finished:
                    OSLog.message(.info, log: .info, "Stream completed successfully.")
                case .failure(let error):
                    OSLog.message(.error, log: .error, "Stream encountered an error: \(error)")
                }
            } receiveValue: { [weak self] value in
                self?.apply(value)
            }
            .store(in: &cancellables)
    }
    
    func apply(_ sectionIdentifiers: [TrainingLevel.ID]) {
        var currentSnapshot = dataSource.snapshot()
        
        for sectionIdentifier in sectionIdentifiers {
            currentSnapshot.appendSections([sectionIdentifier])
            guard let section = self.viewModel.sectionStore.fetchByID(sectionIdentifier) else { return }
            let items = section.routine
            currentSnapshot.appendItems(items.map(\.id))
        }
        dataSource.apply(currentSnapshot, animatingDifferences: true)
    }
}

extension MainViewController {
    private func configureDataSource() {
        let headerRegistration = UICollectionView.SupplementaryRegistration<ProgramListHeaderView>(elementKind: ElementKind.sectionHeader) { [weak self] supplementaryView, _, indexPath in
            
            guard let sectionID = self?.dataSource.snapshot().sectionIdentifiers[indexPath.section],
                  let section = self?.viewModel.sectionStore.fetchByID(sectionID)
            else { return }
            
            supplementaryView.bind(
                section.name,
                subTitle: section.description
            )
        }
        let cellRegistration = UICollectionView.CellRegistration<ProgramCollectionViewCell, DailyRoutine.ID> { [weak self] cell, indexPath, routineID in
            guard let routine = self?.viewModel.routineStore.fetchByID(routineID) else { return }
            let viewModel = ProgramTableViewCellModel(routine)
            cell.bind(viewModel)
        }
        
        dataSource = UICollectionViewDiffableDataSource<TrainingLevel.ID, DailyRoutine.ID>(collectionView: mainView.programListView) { collectionView, indexPath, identifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
        
        dataSource.supplementaryViewProvider = { collectionView, _, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
    }
}
