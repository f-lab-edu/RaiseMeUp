//
//  ViewController.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 2023/10/31.
//

import UIKit
import FirebaseCrashlytics
import FirebaseAnalytics

enum SomeError: Error {
    case someThing
}
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Analytics.logEvent("여기가 첫 로그", parameters: nil)
        
        fatalError("여기서 크래시가 납니다 ")
    }
}
