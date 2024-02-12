//
//  ExerciseRow.swift
//  RaiseMeUp-PROD
//
//  Created by 홍석현 on 2/6/24.
//

import SwiftUI

struct ExerciseRow: View {
    var routine: ProgramTableViewCellModel
    
    var body: some View {
        HStack {
            Text(routine.day)
            Spacer()
            Text(routine.routine)
        }
    }
}

#Preview {
    ExerciseRow(
        routine: ProgramTableViewCellModel(
            DailyRoutine(
                day: "Day 02",
                routine: [3, 2, 1, 1]
            )
        )
    )
}
