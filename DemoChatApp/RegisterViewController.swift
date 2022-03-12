//
//  RegisterViewController.swift
//  DemoChatApp
//
//  Created by Ajay Thakur on 05/03/22.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UITextField!
    
    @IBOutlet weak var passwordLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func doUserRegister(_ sender: UIButton) {
        if let email = userNameLabel.text , let password = passwordLabel.text {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if(error == nil){
                UserLogin.storeUserLogin(true)
                self.performSegue(withIdentifier: Constant.RegisterToChat, sender: self)
                print(authResult ?? "")
            }else{
                UserLogin.storeUserLogin(false)
                print(error?.localizedDescription ?? "")
            }
        }
        }
    }
}
