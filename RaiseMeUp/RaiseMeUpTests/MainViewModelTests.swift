//
//  MainViewModelTests.swift
//  RaiseMeUpTests
//
//  Created by 홍석현 on 1/3/24.
//

import XCTest
import Foundation

@testable import RaiseMeUp

let mockTrainingPlan = PullUpProgram(levels: [
    TrainingLevel(id: "0", name: "비기너", description: "시작하는 사람들을 위한 운동 플랜", routine: [
        DailyRoutine(day: "1일차", program: [3, 2, 2, 1]),
        DailyRoutine(day: "2일차", program: [4, 3, 2, 1]),
        DailyRoutine(day: "3일차", program: [4, 3, 3, 2]),
        DailyRoutine(day: "4일차", program: [5, 3, 3, 2])
    ]),
    TrainingLevel(id: "1", name: "중간자", description: "꽤나 하는 사람들을 위한 운동 플랜", routine: [
        DailyRoutine(day: "1일차", program: [10, 8, 8, 5]),
        DailyRoutine(day: "2일차", program: [10, 9, 8, 5]),
        DailyRoutine(day: "3일차", program: [10, 9, 7, 6]),
        DailyRoutine(day: "4일차", program: [10, 9, 8, 7])
    ]),
    TrainingLevel(id: "2", name: "고도자", description: "고수를 위한 운동 플랜", routine: [
        DailyRoutine(day: "1일차", program: [20, 15, 15, 10]),
        DailyRoutine(day: "2일차", program: [20, 17, 17, 15]),
        DailyRoutine(day: "3일차", program: [20, 18, 15, 12]),
        DailyRoutine(day: "4일차", program: [20, 18, 18, 15])
    ])
])


class MockTrainingUseCase: TrainingUseCase {
    var getProgramListCalled = false
    var mockProgramListResult: PullUpProgram = mockTrainingPlan
    
    func getProgramList() async throws -> PullUpProgram {
        getProgramListCalled = true
        return mockProgramListResult
    }
}


class MockViewModelTests: XCTestCase {
    var viewModel: MainViewModel!
    var mockUseCase: MockTrainingUseCase!
    
    override func setUp() {
        super.setUp()
        
        mockUseCase = MockTrainingUseCase()
        viewModel = MainViewModel(useCase: mockUseCase)
        
        viewModel.loadPrograms()
        let expectation = XCTestExpectation(description: "Load programs")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        super.tearDown()
    }
    
    func test_데이터를불러오는데성공을한다() async {
        // Given
        let expectedTrainingPlan = mockTrainingPlan
        
        // When
        let trainingPlan = await viewModel.loadData()
        
        XCTAssertTrue(mockUseCase.getProgramListCalled, "프로그램 호출 메서드가 불렸다.")
        XCTAssertEqual(trainingPlan.count, expectedTrainingPlan.program.count, "예상하는 데이터가 들어왔다.")
    }
    
    func test_섹션의갯수가유즈케이스에있는데이터의갯수와동일하다() {
        // Given
        let expectedSectionCount = mockTrainingPlan.program.count
        
        // When
        let sectionCount = viewModel.numberOfSection()
        
        // Then
        XCTAssertTrue(mockUseCase.getProgramListCalled, "프로그램 호출 메서드가 불렸다.")
        XCTAssertEqual(expectedSectionCount, sectionCount, "리스트의 섹션 갯수가 동일하게 떨어진다.")
    }
}
