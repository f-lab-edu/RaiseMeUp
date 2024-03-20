//
//  TrainingRepositoryProtocol.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/28/23.
//

import Foundation

public protocol TrainingRepositoryProtocol {
    func trainingProgram() async throws -> PullUpProgram
}

public class MockTrainingRepository: TrainingRepositoryProtocol {
    
    public init() { }
    public func trainingProgram() async throws -> PullUpProgram {
        return PullUpProgram(program: [
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
        ])
    }
}
