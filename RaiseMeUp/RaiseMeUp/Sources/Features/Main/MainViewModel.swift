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
    
    @Published public var program: [TrainingLevel] = []
    private var cancellables = Set<AnyCancellable>()
    
    public weak var coordinator: MainCoordinatorProtocol?
    
    init(useCase: TrainingUseCase) {
        self.useCase = useCase
        
        loadPrograms()
    }
    
    func loadPrograms() {
        Task {
            let result = await loadData()
            DispatchQueue.main.async {
                self.program = result
            }
        }
    }
    
    func loadData() async -> [TrainingLevel] {
        do {
            let result = try await useCase.getProgramList()
            return result.levels
        } catch {
            OSLog.message(.error, log: .network, error.localizedDescription)
            return [] 
        }
    }
    
    func numberOfSection() -> Int {
        return program.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return program[section].routine.count
    }
    
    func section(at section: Int) -> TrainingLevel {
        let section = program[section]
        return section
    }
    
    func didSelectRowAt(at indexPath: IndexPath) {
        self.coordinator?.presentExerciseCounter(routine: program[indexPath.section].routine[indexPath.row].program)
    }
}
