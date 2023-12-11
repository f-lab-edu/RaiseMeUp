//
//  PullUpProgramDTO.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/27/23.
//

import Foundation

struct PullUpProgramDTO: Decodable {
    var programs: [ProgramDTO]
}

extension PullUpProgramDTO {
    func toDomain() -> PullUpTrainingPlan {
        return PullUpTrainingPlan(
            levels: programs.map { $0.toDomain() }
        )
    }
}

struct ProgramDTO: Decodable {
    let id: String
    let name: String
    let description: String
    let schedule: [[Int?]]
}

extension ProgramDTO {
    func toDomain() -> TrainingLevel {
        let routine = self.schedule.enumerated().map { day, program in
            return DailyRoutine(
                day: "Day \(day + 1)",
                program: program.compactMap { $0 }
            )
        }
        return TrainingLevel(
            id: self.id,
            name: self.name,
            description: self.description,
            routine: routine
        )
    }
}

