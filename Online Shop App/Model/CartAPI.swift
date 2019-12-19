//
//  CartAPI.swift
//  Online Shop App
//
//  Created by Awady on 12/18/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CartAPI {
    
    static var instance = CartAPI()
    
    var cartData = [CartModel]()
    
    func fetchCartData(completion: @escaping (_ Success: Bool) -> ()) {
        let userToken = Helper.getAuthToken()
        let url = URLs.cartURL
        let headers: HTTPHeaders = ["token": userToken!]
        
        Alamofire.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .responseJSON { (response) in
            switch response.result {
            case .success(let value):
                print(value)
                let json = JSON(value)
                
                // parsing cart data
                guard let cartArray = json["basket"].array else {
                    completion(false)
                    return
                }
                self.cartData = []
                for item in cartArray {
                    guard let item = item.dictionary else {
                        completion(false)
                        return
                    }
                    var model = CartModel()
                    model.id = item["id"]?.string
                    model.image = item["img"]?.string
                    model.maxCount = item["max_count"]?.string
                    model.price = item["price"]?.string
                    model.size = item["size"]?.string
                    model.text = item["text"]?.string
                    self.cartData.append(model)
                }
                completion(true)
                
            case .failure(let error):
                debugPrint(error)
                completion(false)
            }
        }
    }
}
