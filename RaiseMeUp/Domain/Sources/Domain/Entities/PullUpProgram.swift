//
//  PullUpProgram.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/28/23.
//

import Foundation

public struct PullUpProgram {
    public let program: [TrainingLevel]
}

public struct TrainingLevel: Identifiable {
    public var id: String
    public var name: String
    public var description: String
    public var routine: [DailyRoutine]
}

public struct DailyRoutine: Identifiable {
    public let id: UUID = UUID()
    public let day: String
    public let routine: [Int]
}
