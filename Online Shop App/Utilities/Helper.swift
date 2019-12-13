//
//  Helper.swift
//  Online Shop App
//
//  Created by Awady on 12/10/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import Foundation

class Helper {
    
    class func restartApp() {
        guard let window = UIApplication.shared.keyWindow else {return}
        let SBoard = UIStoryboard(name: "Main", bundle: nil)
        var ViewController: UIViewController
        if getAuthToken() == nil {
            ViewController = SBoard.instantiateInitialViewController()!
        } else {
            ViewController = SBoard.instantiateViewController(identifier: "SWRevealViewController") as! SWRevealViewController
        }
        
        window.rootViewController = ViewController
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
    }
    
    class func saveUserToken(UserToken: String) {
        
        let defoult = UserDefaults.standard
        //save UserToken to UserDefoult
        defoult.setValue(UserToken, forKey: "token")
        defoult.synchronize()
        
        restartApp()
    }
    
    class func getAuthToken() -> String? {
        
        let defoult = UserDefaults.standard
        return defoult.object(forKey: "token") as? String
    }
}
