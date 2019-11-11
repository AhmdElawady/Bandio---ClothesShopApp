//
//  logInViewController.swift
//  Online Shop App
//
//  Created by Awady on 11/4/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit

class logInViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func logInPressed(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let HomeViewController = mainStoryboard.instantiateViewController(identifier: "RevealViewController") as? SWRevealViewController
            else {
                return
        }
        
        present(HomeViewController, animated: true, completion: nil)
    }
    


}
