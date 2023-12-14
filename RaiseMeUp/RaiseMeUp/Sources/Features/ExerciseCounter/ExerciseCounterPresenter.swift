//
//  ExerciseCounterPresenter.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 12/14/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ExerciseCounterPresentationLogic {
    func presentCurrentRep(response: ExerciseCounter.CountRep.Response)
}

class ExerciseCounterPresenter: ExerciseCounterPresentationLogic {
    weak var viewController: ExerciseCounterDisplayLogic?
    
    // MARK: Do something
    
    func presentCurrentRep(response: ExerciseCounter.CountRep.Response) {
        let viewModel = ExerciseCounter.CountRep.ViewModel(rep: response.currentRep)
        viewController?.displayNextExercise(viewModel: viewModel)
    }
}
