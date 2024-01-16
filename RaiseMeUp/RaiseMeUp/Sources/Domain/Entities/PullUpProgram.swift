//
//  PullUpProgram.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/28/23.
//

import Foundation

struct PullUpProgram {
    let program: [TrainingLevel]
}

struct TrainingLevel: Identifiable {
    let id: String
    let name: String
    let description: String
    let routine: [DailyRoutine]
}

struct DailyRoutine: Identifiable {
    let id: UUID = UUID()
    let day: String
    let routine: [Int]
}
