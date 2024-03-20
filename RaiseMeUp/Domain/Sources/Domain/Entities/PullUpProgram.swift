//
//  PullUpProgram.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/28/23.
//

import Foundation

public struct PullUpProgram {
    public let program: [TrainingLevel]
    
    public init(program: [TrainingLevel]) {
        self.program = program
    }
}

public struct TrainingLevel: Identifiable {
    public var id: String
    public var name: String
    public var description: String
    public var routine: [DailyRoutine]
    
    public init(
        id: String,
        name: String,
        description: String,
        routine: [DailyRoutine]
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.routine = routine
    }
}

public struct DailyRoutine: Identifiable {
    public let id: UUID = UUID()
    public let day: String
    public let routine: [Int]
    
    public init(
        day: String,
        routine: [Int]
    ) {
        self.day = day
        self.routine = routine
    }
}
