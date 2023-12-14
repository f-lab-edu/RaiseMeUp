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

protocol ExerciseCounterDisplayLogic: class
{
    func displaySomething(viewModel: ExerciseCounter.Something.ViewModel)
}

class ExerciseCounterViewController: UIViewController, ExerciseCounterDisplayLogic
{
    var interactor: ExerciseCounterBusinessLogic?
    var router: (NSObjectProtocol & ExerciseCounterRoutingLogic & ExerciseCounterDataPassing)?
    
    var mainView: ExerciseCounterMainView {
        return self.view as! ExerciseCounterMainView
    }
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = ExerciseCounterInteractor()
        let presenter = ExerciseCounterPresenter()
        let router = ExerciseCounterRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    // MARK: View lifecycle
    
    override func loadView() {
        self.view = ExerciseCounterMainView()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        doSomething()
    }
    
    // MARK: Do something
    
    func doSomething()
    {
        let request = ExerciseCounter.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: ExerciseCounter.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
}
