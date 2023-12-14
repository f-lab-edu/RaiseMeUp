//
//  ExerciseCounterRouter.swift
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

@objc protocol ExerciseCounterRoutingLogic
{
    
}

protocol ExerciseCounterDataPassing
{
  var dataStore: ExerciseCounterDataStore? { get }
}

class ExerciseCounterRouter: NSObject, ExerciseCounterRoutingLogic, ExerciseCounterDataPassing
{
  weak var viewController: ExerciseCounterViewController?
  var dataStore: ExerciseCounterDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: ExerciseCounterViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: ExerciseCounterDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
