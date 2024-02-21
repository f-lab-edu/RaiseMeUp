//
//  ExerciseViewModel.swift
//  RaiseMeUp-PROD
//
//  Created by 홍석현 on 2/12/24.
//

import Foundation
import OSLog

class ExerciseViewModel: ObservableObject {
    private let useCase: TrainingUseCase
    public weak var coordinator: MainCoordinatorProtocol?
    
    @Published var program: [TrainingLevel] = []
    
    init(useCase: TrainingUseCase) {
        self.useCase = useCase
        
        fetchProgram()
    }
    
    func fetchProgram() {
        Task {
            let result = await useCase.getProgramList()
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.program = data.program
                }
            case .failure(let error):
                OSLog.message(.error, error.localizedDescription)
            }
        }
    }
    
    func selectRoutine(_ routine: DailyRoutine) {
        coordinator?.presentExerciseCounter(routine: routine.routine)
    }
}
