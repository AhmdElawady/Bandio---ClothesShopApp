//
//  ProductAPI.swift
//  Online Shop App
//
//  Created by Awady on 12/12/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ProductAPI {
    
    static var instance = ProductAPI()
    
    var productData = [ProductModel]()
    
    func fetchProductData(CategoryID: String, completion: @escaping (_ Success: Bool) -> ()) {
        let userToken = Helper.getAuthToken()
        let url = URLs.productUrl
        let parameters: [String: Any] = ["category_id": CategoryID]
        let headers: HTTPHeaders = ["token": userToken!]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .responseJSON { (response) in
            switch response.result {
            case .success(let value):
                print(value)
                let json = JSON(value)
                
                // parse product data
                guard let productArray = json["product"].array else {
                    completion(false)
                    return
                }
                self.productData = []
                for item in productArray {
                    guard let item = item.dictionary else {
                        completion(false)
                        return
                    }
                    var model = ProductModel()
                    model.id = item["id"]?.int
                    model.categryId = item["category_id"]?.string
                    model.image = item["img"]?.string
                    model.offer = item["offer"]?.string
                    model.price = item["price"]?.string
                    model.oldPrice = item["old_price"]?.string
                    model.favorite = item["Favorite"]?.string
                    model.numFavorit = item["num_favourit"]?.string
                    self.productData.append(model)
                }
                completion(true)
                
            case .failure(let error):
                debugPrint(error)
                completion(false)
            }
        }
    }
}
