//
//  PullUpProgramDTO.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/27/23.
//

import Foundation
import Domain

public struct PullUpProgramDTO: Decodable {
    private var programs: [ProgramDTO]
}

extension PullUpProgramDTO {
    func toDomain() -> PullUpProgram {
        return PullUpProgram(
            program: programs.map { $0.toDomain() }
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
            var dayString: String {
                if day < 9 {
                    return "Day 0\(day + 1)"
                } else {
                    return "Day \(day + 1)"
                }
            }
            
            return DailyRoutine(
                day: dayString,
                routine: program.compactMap { $0 }
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

