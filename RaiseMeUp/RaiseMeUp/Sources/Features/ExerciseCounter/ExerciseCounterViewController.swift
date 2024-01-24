//
//  ExerciseCounterViewController.swift
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

protocol ExerciseCounterDisplayLogic: AnyObject {
    func displayNextExercise(viewModel: ExerciseCounter.CountRep.ViewModel)
    func displayRemainingRestTime(viewModel: ExerciseCounter.Timer.ViewModel)
    func displayEndExercise()
}

class ExerciseCounterViewController: UIViewController, ExerciseCounterDisplayLogic {
    var interactor: (ExerciseCounterBusinessLogic & ExerciseCounterDataStore)?
    var router: (NSObjectProtocol & ExerciseCounterRoutingLogic & ExerciseCounterDataPassing)?
    
    var mainView: ExerciseCounterMainView {
        return self.view as! ExerciseCounterMainView
    }
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = ExerciseCounterInteractor()
        let presenter = ExerciseCounterPresenter()
        
        let timer = RestTimer()

        viewController.interactor = interactor
        interactor.presenter = presenter
        interactor.timer = timer
        presenter.viewController = viewController
        
        timer.output = interactor
    }
    
    // MARK: Routing
    
    // MARK: View lifecycle
    
    override func loadView() {
        self.view = ExerciseCounterMainView()
        self.mainView.lister = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    private func bind() {
        self.mainView.startButton.addAction(UIAction(handler: { [weak self] _ in
            self?.startButtonTapped()
        }), for: .touchUpInside)
        
        self.mainView.endButton.addAction(UIAction(handler: { [weak self] _ in
            self?.endButtonTapped()
        }), for: .touchUpInside)
    }
    
    // MARK: Start Button Tapped
    
    func startButtonTapped() {
        self.mainView.startButton.isHidden = true
        self.mainView.countLabel.isHidden = false
        self.mainView.timerLabel.isHidden = true
        
        interactor?.startButtonTapped()
    }
    
    func endButtonTapped() {
        router?.dismiss()
    }
    
    func displayNextExercise(viewModel: ExerciseCounter.CountRep.ViewModel) {
        self.mainView.countLabel.isHidden = false
        self.mainView.timerLabel.isHidden = true
        
        self.mainView.countLabel.text = "\(viewModel.rep)"
    }
    
    func displayRemainingRestTime(viewModel: ExerciseCounter.Timer.ViewModel) {
        self.mainView.countLabel.isHidden = true
        self.mainView.timerLabel.isHidden = false
        
        self.mainView.timerLabel.text = viewModel.currentTime
    
        UIAccessibility.post(notification: .announcement, argument: "\(viewModel.currentTime.last!)초")
    }
    
    func displayEndExercise() {
        self.mainView.countLabel.isHidden = true
        self.mainView.timerLabel.isHidden = true
        self.mainView.endButton.isHidden = false
        
        
    }
}

extension ExerciseCounterViewController: ExerciseCounterMainViewLister {
    func backgroundViewTapped() {
        interactor?.countOnePullUp()
    }
}
