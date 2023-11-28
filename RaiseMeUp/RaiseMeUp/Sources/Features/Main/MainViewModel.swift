//
//  MainViewModel.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/28/23.
//

import Foundation

final class MainViewModel {
    private let useCase: TrainingUseCase
    
    init(useCase: TrainingUseCase) {
        self.useCase = useCase
    }
    
    func loadData() {
        let result = useCase.getProgramList()
        print(result)
    }
}
