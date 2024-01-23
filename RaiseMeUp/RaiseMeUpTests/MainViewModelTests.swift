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
    
    func test_emptyData에러가일경우_showEmptyView에true이벤트를보낸다() async {
        // given
        let mockUseCase = MockTrainingUseCase(result: .failure(.emptyData))
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
    
    func test_notConnected에러일경우_showErrorAlertSubject에이벤트가방출된다() async {
        // given
        let mockUseCase = MockTrainingUseCase(result: .failure(.notConnected))
        let viewModel = MainViewModel(useCase: mockUseCase)
        var didShowErrorAlert = false
        let showErrorAlertSubscriber = viewModel.showErrorAlertSubject
            .sink { _ in
                didShowErrorAlert = true
            }
        
        // when
        _ = await viewModel.loadData()
        
        // then
        XCTAssertTrue(didShowErrorAlert, "에러 알럿이 방출되지 않음")
        
        showErrorAlertSubscriber.cancel()
    }
    
    func test_unknown에러일경우_showErrorAlertSubject에이벤트가방출된다() async {
        // given
        let mockUseCase = MockTrainingUseCase(result: .failure(.unknown))
        let viewModel = MainViewModel(useCase: mockUseCase)
        var didShowErrorAlert = false
        let showErrorAlertSubscriber = viewModel.showErrorAlertSubject
            .sink { _ in
                didShowErrorAlert = true
            }
        
        // when
        _ = await viewModel.loadData()
        
        // then
        XCTAssertTrue(didShowErrorAlert, "에러 알럿이 방출되지 않음")
        
        showErrorAlertSubscriber.cancel()
    }
    
    func test_데이터가들어갔을경우에_sectionStore의데이터가empty가아니다() async {
        // given
        let mockUseCase = MockTrainingUseCase(result: .success(PullUpProgram(program: [
            TrainingLevel(
                id: "321532",
                name: "11",
                description: "dkjlf",
                routine: [
                    DailyRoutine(day: "1", routine: [1,2,3]),
                    DailyRoutine(day: "1", routine: [1,2,3]),
                    DailyRoutine(day: "1", routine: [1,2,3])
                ]
            ),
            TrainingLevel(
                id: "6546547",
                name: "11",
                description: "dkjlf",
                routine: [
                    DailyRoutine(day: "1", routine: [1,2,3]),
                    DailyRoutine(day: "1", routine: [1,2,3]),
                    DailyRoutine(day: "1", routine: [1,2,3])
                ]
            ),
            TrainingLevel(
                id: "234535",
                name: "11",
                description: "dkjlf",
                routine: [
                    DailyRoutine(day: "1", routine: [1,2,3]),
                    DailyRoutine(day: "1", routine: [1,2,3]),
                    DailyRoutine(day: "1", routine: [1,2,3])
                ]
            )
        ])))
        let viewModel = MainViewModel(useCase: mockUseCase)
        let expectation = XCTestExpectation(description: "loadPrograms 완료")

        // when
        viewModel.loadPrograms()
        
        
        
        // then
        XCTAssertFalse(viewModel.sectionStore.isEmpty, "section의 모델이 제대로 들어가지 않았다.")
    }
    
    func test_데이터가들어갔을경우에_routineStore의데이터가empty가아니다() async {
        
    }
}
