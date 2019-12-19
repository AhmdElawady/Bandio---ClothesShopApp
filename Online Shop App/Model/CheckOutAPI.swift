//
//  CheckOutAPI.swift
//  Online Shop App
//
//  Created by Awady on 12/18/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CheckOutAPI {
    
    static var instance = CheckOutAPI()
    
    func sendOrderData(completion: @escaping (_ Success: Bool)-> ()) {
        
        let userToken = Helper.getAuthToken()
        let url = URLs.cartURL
        let headers: HTTPHeaders = ["token": userToken!]
        
        Alamofire.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
                case .success(let value):
                print(value)
                
                case .failure(let error):
                    completion(false)
                    debugPrint(error)
            }
        }
    }
}
