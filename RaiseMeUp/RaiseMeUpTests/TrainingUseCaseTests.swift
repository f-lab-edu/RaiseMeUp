//
//  TrainingUseCaseTests.swift
//  RaiseMeUpTests
//
//  Created by 홍석현 on 1/23/24.
//

import XCTest
import Foundation

@testable import RaiseMeUp_DEV

class MockTrainingRepository: TrainingRepositoryProtocol {
    var mockProgram: PullUpProgram?
    var mockError: NetworkError?
    
    func trainingProgram() async throws -> PullUpProgram {
        if let error = mockError {
            throw error
        }
        if let program = mockProgram {
            return program
        }
        
        throw NetworkError.unknown
    }
}

class TrainingUseCaseTests: XCTestCase {
    var repository: MockTrainingRepository!
    var training: Training!
    
    override func setUp() {
        super.setUp()
        
        repository = MockTrainingRepository()
        training = Training(repository: repository)
    }
    
    override func tearDown() {
        repository = nil
        training = nil
        super.tearDown()
    }
    
    func test_데이터가제대로들어왔을경우Success를방출한다() async {
        // given
        let expectedName = "예상되는 프로그램 이름"
        repository.mockProgram = PullUpProgram(program: [
        TrainingLevel(id: "", name: expectedName, description: "", routine: [])
        ])
        
        // when
        let result = await training.getProgramList()
        
        // then
        switch result {
        case .success(let data):
            XCTAssertFalse(data.program.isEmpty, "받아온 데이터가 비어있음")
            XCTAssertEqual(data.program.first?.name, expectedName)
        case .failure(_):
            XCTFail("에러가 발생함")
        }
    }
    
    func test_프로그램이empty일경우emptyData에러를방출한다() async {
        // given
        repository.mockProgram = PullUpProgram(program: [])
        
        // when
        let result = await training.getProgramList()
        
        // then
        switch result {
        case .success:
            XCTFail("성공으로 떨어지면 안됨")
        case .failure(let error):
            XCTAssertEqual(error, .emptyData)
        }
    }
    
    func test_timeOutError시_notConnected에러방출한다() async {
        // given
        self.setUpWithErrorCase(NetworkError.timeOut)
        
        // when
        let result = await training.getProgramList()
        
        // then
        switch result {
        case .success:
            XCTFail("데이터를 받아오면 안됨")
        case .failure(let error):
            XCTAssertEqual(error, .notConnected)
        }
    }
    
    func test_notReachable시_notConnected에러방출한다() async {
        // given
        self.setUpWithErrorCase(NetworkError.notReachable)
        
        // when
        let result = await training.getProgramList()
        
        // then
        switch result {
        case .success:
            XCTFail("데이터를 받아오면 안됨")
        case .failure(let error):
            XCTAssertEqual(error, .notConnected)
        }
    }
    
    func test_invalidStatusCode시_notConnected에러방출한다() async {
        // given
        self.setUpWithErrorCase(NetworkError.notReachable)
        
        // when
        let result = await training.getProgramList()
        
        // then
        switch result {
        case .success:
            XCTFail("데이터를 받아오면 안됨")
        case .failure(let error):
            XCTAssertEqual(error, .notConnected)
        }
    }
    
    func test_noData시_emptyData에러방출한다() async {
        // given
        self.setUpWithErrorCase(NetworkError.noData)
        
        // when
        let result = await training.getProgramList()
        
        // then
        switch result {
        case .success:
            XCTFail("데이터를 받아오면 안됨")
        case .failure(let error):
            XCTAssertEqual(error, .emptyData)
        }
    }
    
    func test_unknown시_unknown에러방출한다() async {
        // given
        self.setUpWithErrorCase(NetworkError.unknown)
        
        // when
        let result = await training.getProgramList()
        
        // then
        switch result {
        case .success:
            XCTFail("데이터를 받아오면 안됨")
        case .failure(let error):
            XCTAssertEqual(error, .unknown)
        }
    }
}

extension TrainingUseCaseTests {
    private func setUpWithErrorCase(_ error: NetworkError) {
        self.repository.mockError = error
    }
}
