//
//  ViewController.swift
//  DemoChatApp
//
//  Created by Ajay Thakur on 05/03/22.
//

import UIKit

class WelcomeController: UIViewController {

    @IBOutlet weak var appNameLabel: UILabel? = nil
    private var timeIndex : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppName()
        print(UserLogin.retriveUserLogin())
    }
    
    //SetAppName:-
    private func setAppName(){
        for name in Constant.appName {
            Timer.scheduledTimer(withTimeInterval: 0.1 * timeIndex , repeats: false) { (timer) in
                self.appNameLabel?.text?.append(name)
            }
            timeIndex += 1
        }
    }
}

