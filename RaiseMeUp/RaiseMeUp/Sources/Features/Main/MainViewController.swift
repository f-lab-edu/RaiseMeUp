//
//  MainViewController.swift
//  RaiseMeUp
//
//  Created by Sh Hong on 2023/11/21.
//

import UIKit

final class MainViewController: UIViewController {
    
    private var mainView: MainView = {
        return self.view as! MainView
    }
    
    override func loadView() {
        self.view = MainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
