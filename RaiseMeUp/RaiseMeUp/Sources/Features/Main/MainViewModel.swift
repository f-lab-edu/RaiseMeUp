//
//  MainViewModel.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/28/23.
//

import Foundation

final class MainViewModel {
    private let useCase: TrainingUseCase
    
    private var program: [TrainingLevel] = []
    
    init(useCase: TrainingUseCase) {
        self.useCase = useCase
        
        guard case let .success(plan) = useCase.getProgramList() else { return }
        self.program = plan.levels
        
    }
    
    func loadData() -> [TrainingLevel] {
        let result = useCase.getProgramList()
        guard case let .success(data) = result else {
            return []
        }
        return data.levels
    }
    
    func numberOfSection() -> Int {
        return program.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return program[section].routine.count
    }
    
    func section(at indexPath: IndexPath) -> TrainingLevel {
        let section = program[indexPath.section]
        return section
    }
}
