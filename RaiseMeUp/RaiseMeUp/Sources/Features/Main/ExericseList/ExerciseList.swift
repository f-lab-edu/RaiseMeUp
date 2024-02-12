//
//  ExerciseList.swift
//  RaiseMeUp-PROD
//
//  Created by 홍석현 on 2/10/24.
//

import SwiftUI

struct ExerciseList: View {
    @StateObject var viewModel: ExerciseViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.program) { program in
                Section(
                    header: ExerciseListHeader(
                        title: program.name,
                        subTitle: program.description
                    )
                ) {
                    ForEach(program.routine) { routine in
                        let rowModel = ProgramTableViewCellModel(routine)
                        ExerciseRow(
                            routine: rowModel
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    ExerciseList(viewModel: MockViewModel())
}

final class MockViewModel: ExerciseViewModel {
    init() {
        super.init(
            useCase: Training(
                repository: TrainingRepository(
                    trainingDataSource: TrainingDataSource())
                )
            )
        
        self.program = [
            TrainingLevel(
                id: UUID().uuidString,
                name: "Starter",
                description: "여긴 해당 설명이 들어갑니다.",
                routine: [
                    DailyRoutine(day: "Day 01", routine: [3,2,1,1]),
                    DailyRoutine(day: "Day 01", routine: [3,2,1,1]),
                    DailyRoutine(day: "Day 01", routine: [3,2,1,1]),
                    DailyRoutine(day: "Day 01", routine: [3,2,1,1]),
                    DailyRoutine(day: "Day 01", routine: [3,2,1,1])
                ]
            ),
            TrainingLevel(
                id: UUID().uuidString,
                name: "Starter",
                description: "여긴 해당 설명이 들어갑니다.",
                routine: [
                    DailyRoutine(day: "Day 01", routine: [3,2,1,1]),
                    DailyRoutine(day: "Day 01", routine: [3,2,1,1]),
                    DailyRoutine(day: "Day 01", routine: [3,2,1,1]),
                    DailyRoutine(day: "Day 01", routine: [3,2,1,1]),
                    DailyRoutine(day: "Day 01", routine: [3,2,1,1])
                ]
            ),
            TrainingLevel(
                id: UUID().uuidString,
                name: "Starter",
                description: "여긴 해당 설명이 들어갑니다.",
                routine: [
                    DailyRoutine(day: "Day 01", routine: [3,2,1,1]),
                    DailyRoutine(day: "Day 01", routine: [3,2,1,1]),
                    DailyRoutine(day: "Day 01", routine: [3,2,1,1]),
                    DailyRoutine(day: "Day 01", routine: [3,2,1,1]),
                    DailyRoutine(day: "Day 01", routine: [3,2,1,1])
                ]
            )
        ]
    }
}
