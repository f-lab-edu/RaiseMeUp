//
//  MainViewModelTests.swift
//  RaiseMeUpTests
//
//  Created by 홍석현 on 1/3/24.
//

import XCTest
import Foundation

@testable import RaiseMeUp

class MockTrainingUseCase: TrainingUseCase {
    var mockData: PullUpProgram
    
    init(mockData: PullUpProgram) {
        self.mockData = mockData
    }
    
    func getProgramList() async throws -> PullUpProgram {
        return mockData
    }
}

class MockViewModelTests: XCTestCase {
    var viewModel: MainViewModel!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
