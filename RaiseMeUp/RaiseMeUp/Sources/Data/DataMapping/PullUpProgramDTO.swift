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

struct ProgramDTO: Decodable {
    var name: String
    var description: String
    var schedule: [[Int?]]
}
