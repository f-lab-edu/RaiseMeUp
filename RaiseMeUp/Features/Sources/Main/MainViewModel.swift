//
//  MainViewModel.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/28/23.
//

import UIKit
import OSLog
import Combine
import Shared
import Domain

final class MainViewModel {
    private let useCase: TrainingUseCase
    
    var sectionStore: AnyModelStore<TrainingLevel> = AnyModelStore([])
    var routineStore: AnyModelStore<DailyRoutine> = AnyModelStore([])
    private var cancellables = Set<AnyCancellable>()
    
    public weak var coordinator: MainCoordinatorProtocol?
    
    var isFinishLoaded = PassthroughSubject<[TrainingLevel.ID], NSError>()
    var showEmptyViewSubject = PassthroughSubject<Bool, Never>()
    var showErrorAlertSubject = PassthroughSubject<String, Never>()
    
    init(useCase: TrainingUseCase) {
        self.useCase = useCase
        
        self.loadPrograms()
    }
    
    func loadPrograms() {
        Task {
            let result = await loadData()
            sectionStore = AnyModelStore(result)
            routineStore = AnyModelStore(result.flatMap(\.routine))
            
            isFinishLoaded.send(result.map(\.id))
        }
    }
    
    func loadData() async -> [TrainingLevel] {
        let result = await useCase.getProgramList()
        switch result {
        case .success(let data):
            if data.program.isEmpty {
                showEmptyView()
                return []
            }
            return data.program
        case .failure(let error):
            switch error {
            case .emptyData:
                showEmptyView()
            case .notConnected, .unknown:
                showErrorAlert()
            }
            return []
        }
    }
    
    func didSelectItemAt(_ itemID: DailyRoutine.ID) {
        guard let routine = routineStore.fetchByID(itemID) else { return }
        coordinator?.presentExerciseCounter(routine: routine.routine)
    }
    
    func showEmptyView() {
        showEmptyViewSubject.send(true)
    }
    
    func showErrorAlert() {
        showErrorAlertSubject.send("인터넷 연결이 불안정합니다.\n다시 시도해주세요.")
    }
}
