//
//  AuthAPI.swift
//  Online Shop App
//
//  Created by Awady on 12/10/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthAPI {
    
    static let instance = AuthAPI()
    
    func signin (userName: String, password: String, completion: @escaping (_ Success: Bool) -> ()) {
        let parameters = [
            "username": userName,
            "password": password
        ]
        let url = URLs.loginUrl
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .responseJSON { (response) in
            switch response.result {
            case .success(let value):
                print(value)
                let json = JSON(value)
                if let token = json["user"]["token"].string {
                Helper.saveUserToken(UserToken: token)
                    print("token: \(token)")
                }
                completion(true)
                print(value)
                
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    func register (userName: String, email: String, birthdate: String, password: String, confPassword: String, completion: @escaping (_ Success: Bool) -> ()) {
        
        let parameters = [
            "username": userName,
            "email": email,
            "birthdate": birthdate,
            "password": password,
            "password_confirmation": password
        ]
        let url = URLs.registerUrl
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .responseJSON { (response) in
            switch response.result {
            case .success(let value):
                print(value)
                let json = JSON(value)
                if let token = json["user"]["token"].string {
                    print(token)
                    Helper.saveUserToken(UserToken: token)
                    print("token saved")
                    completion(true)
                }
                
                
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
}
