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

struct TrainingLevel {
    let id: String
    let name: String
    let description: String
    let routine: [DailyRoutine]
}

struct DailyRoutine {
    let day: String
    let routine: [Int]
}
