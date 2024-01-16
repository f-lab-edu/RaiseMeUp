//
//  MainViewModel.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/28/23.
//

import Foundation
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
        do {
            let result = try await useCase.getProgramList()
            OSLog.message(.info, "받아온 데이터 \(result)")
            return result.program
        } catch {
            OSLog.message(.error, log: .network, error.localizedDescription)
            return [] 
        }
    }
    
    func didSelectItemAt(_ itemID: DailyRoutine.ID) {
        guard let routine = routineStore.fetchByID(itemID) else { return }
        coordinator?.presentExerciseCounter(routine: routine.routine)
    }
}
