//
//  SignupViewController.swift
//  Online Shop App
//
//  Created by Awady on 11/5/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var birthdateTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confPasswordTextField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signupPressed(_ sender: Any) {
        
        guard let username = usernameTextField.text, !username.isEmpty else {
            Alert.showBasic(title: "Incomplete Form", message: "Please fill out all fields", vc: self)
            return
        }
        guard let email = emailTextField.text, !email.isEmpty else {
            Alert.showBasic(title: "Incomplete Form", message: "Please fill out all fields", vc: self)
            return
        }
        if email.isValideEmail == false {
            Alert.showBasic(title: "Invalide Email Formate", message: "Please make sure you formate your mail correctly", vc: self)
        }
        guard let password = passwordTextField.text, !password.isEmpty, password.count >= 6 else {
            Alert.showBasic(title: "Password Too Short", message: "Password should be at least 8 characters", vc: self)
            return
        }
        guard let repassword = confPasswordTextField.text else {return}
        
        if password != repassword {
            Alert.showBasic(title: "Wrong Password Confirmation", message: "Password Confirmation must be equal password", vc: self)
            return
        }
        
        guard let birthdate = birthdateTextField.text, !birthdate.isEmpty else {
            Alert.showBasic(title: "Incomplete Form", message: "Please fill out all fields", vc: self)
            return
        }
//        if birthdate.isValideDate == false {
//            Alert.showBasic(title: "Invalide Date Formate", message: "Please make sure your date formated correctly", vc: self)
//        }
        
        AuthAPI.instance.register(userName: username, email: email, birthdate: birthdate, password: password, confPassword: repassword) { (Success) in
            if Success {
                print("REGISTERED SUCCESSFULLY")
//                let view = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
//                self.present(view, animated: true, completion: nil)
            } else {
                print("Error in regsiter")
            }
        }

        
    }
    
    

}
