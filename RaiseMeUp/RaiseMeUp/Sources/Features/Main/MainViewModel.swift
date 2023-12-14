//
//  MainViewModel.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/28/23.
//

import Foundation
import OSLog

final class MainViewModel {
    private let useCase: TrainingUseCase
    
    private var program: [TrainingLevel] = []
    public weak var coordinator: MainCoordinatorProtocol?
    
    init(useCase: TrainingUseCase) {
        self.useCase = useCase

        initializeData()
    }
    
    private func initializeData() {
        guard case let .success(plan) = useCase.getProgramList() else { return }
        self.program = plan.levels
    }
    
    func loadData() -> [TrainingLevel] {
        let result = useCase.getProgramList()
        guard case let .success(data) = result else {
            return []
        }
        
        switch result {
        case .success(let data):
            return data.levels
        case .failure(let error):
            OSLog.message(.error, error.localizedDescription)
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
    
    func didSelectRowAt() {
        self.coordinator?.presentExerciseCounter()
    }
}
