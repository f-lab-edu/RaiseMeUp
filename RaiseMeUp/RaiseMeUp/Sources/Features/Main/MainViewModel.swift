//
//  MainViewModel.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/28/23.
//

import UIKit
import OSLog
import Combine

final class MainViewModel {
    private let useCase: TrainingUseCase
    
    var sectionStore: AnyModelStore<TrainingLevel> = AnyModelStore([])
    var routineStore: AnyModelStore<DailyRoutine> = AnyModelStore([])
    private var cancellables = Set<AnyCancellable>()
    
    public weak var coordinator: MainCoordinatorProtocol?
    
    var isFinishLoaded = PassthroughSubject<[TrainingLevel.ID], NSError>()
    
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
            return data.program
        case .failure(let error):
            switch error {
            case .emptyData:
                OSLog.message(.error, "데이터가 없음")
            case .notConnected, .unknown:
                OSLog.message(.error, "인터넷 연결이 불안정합니다.\n다시 시도해주세요.")
            }
            return []
        }
    }
    
    func didSelectItemAt(_ itemID: DailyRoutine.ID) {
        guard let routine = routineStore.fetchByID(itemID) else { return }
        coordinator?.presentExerciseCounter(routine: routine.routine)
    }
}
