//
//  ExerciseList.swift
//  RaiseMeUp-PROD
//
//  Created by 홍석현 on 2/10/24.
//

import SwiftUI
import Domain

struct ExerciseList: View {
    @ObservedObject var viewModel: ExerciseViewModel
    
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
                        Button(action: {
                            viewModel.selectRoutine(routine)
                        }, label: {
                            let rowModel = ProgramTableViewCellModel(routine)
                            ExerciseRow(
                                routine: rowModel
                            )
                        })
                        .buttonStyle(.plain)
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
                repository: MockTrainingRepository()
                )
            )
    }
}
