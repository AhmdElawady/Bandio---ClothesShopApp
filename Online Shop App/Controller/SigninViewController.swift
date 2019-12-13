//
//  logInViewController.swift
//  Online Shop App
//
//  Created by Awady on 11/4/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit

class signinViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func signinPressed(_ sender: Any) {
        
        guard let username = usernameTextField.text, !username.isEmpty else {
            Alert.showBasic(title: "Incomplete Form", message: "Please fill out all fields", vc: self)
            return
        }

        guard let password = passwordTextField.text, !password.isEmpty, password.count >= 6 else {
            Alert.showBasic(title: "Password Too Short", message: "Password should be at least 6 characters", vc: self)
            return
        }
        
        AuthAPI.instance.signin(userName: username, password: password) { (Success) in
            if Success {
                print("Logged in Successfully")
//                let view = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
//                self.present(view, animated: true, completion: nil)
            } else {
                print("Error in login")
                Alert.showBasic(title: "Wrong inputs", message: "username or password is wrong", vc: self)
            }
        }
        
                
    }
    


}
