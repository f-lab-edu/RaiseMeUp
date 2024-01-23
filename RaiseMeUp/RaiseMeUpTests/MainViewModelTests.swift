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
    
    var result: Result<PullUpProgram, TrainingError>
    
    init(result: Result<PullUpProgram, TrainingError>) {
        self.result = result
    }
    
    func getProgramList() async -> Result<PullUpProgram, TrainingError> {
        return result
    }
}

class MockViewModelTests: XCTestCase {
    var viewModel: MainViewModel!
    var useCase: MockTrainingUseCase!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        useCase = nil
        viewModel = nil
        
        super.tearDown()
    }
    
    func test_빈데이터가들어갔을경우에_showEmptyView에true이벤트를보낸다() async {
        // given
        let mockUseCase = MockTrainingUseCase(result: .success(PullUpProgram(program: [])))
        let viewModel = MainViewModel(useCase: mockUseCase)
        var didShowEmptyView = false
        let showEmptyViewSubscriber = viewModel.showEmptyViewSubject
            .sink (receiveValue: { value in
                didShowEmptyView = value
            })

        // when
        _ = await viewModel.loadData()
        
        // then
        XCTAssertTrue(didShowEmptyView, "데이터가 비었을 경우 showEmptyView가 호출되지 않음")
        
        showEmptyViewSubscriber.cancel()
    }
    
}
