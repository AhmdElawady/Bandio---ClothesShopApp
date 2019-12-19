//
//  AddToCartAPI.swift
//  Online Shop App
//
//  Created by Awady on 12/16/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AddToCartAPI {
    
    static var instance = AddToCartAPI()
    
    
    func addDataToCart(productID: Int, productCount: Int, productSize: String, completion: @escaping (_ Success: Bool) -> ()) {
        let url = URLs.addCartUrl
        let parameters: [String: Any] = [
        "product_id": productID,
        "product_count": productCount,
        "size": productSize
        ]
        let userToken = Helper.getAuthToken()
        let header: HTTPHeaders = ["token": userToken!]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: header)
            .responseJSON { (response) in
            switch response.result {
            case .success(let value):
                print(value)
                let json = JSON(value)
                let stat = json["stat"].intValue
                print(stat)
                if stat != 200 {
                    completion(false)
                    return
                }else {
                   completion(true)
                }
        
            case .failure(let error):
                debugPrint(error)
                completion(false)
            }
        }
    }
}
