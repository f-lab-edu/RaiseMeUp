//
//  ProgramTableViewCellModel.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/30/23.
//

import Foundation
import Domain

struct ProgramTableViewCellModel {
    let day: String
    let routine: String
    let isRestDay: Bool
    
    init(_ model: DailyRoutine) {
        self.day = model.day
        self.isRestDay = model.routine.isEmpty
        
        if model.routine.isEmpty {
            self.routine = "오늘은 쉬는 날"
        } else {
            let result = model.routine.map { String($0) }.joined(separator: "-")
            self.routine = result
        }
    }
}
