//
//  ProductDetailsAPI.swift
//  Online Shop App
//
//  Created by Awady on 12/12/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ProductDetailsAPI {
    
    static var instance = ProductDetailsAPI()
    
    var ProductDetailsData = ProductDetailsModel()
    var imageData = [String]()
    var sizeData = [String]()
    
    func fetchDetailsData(productID: Int, completion: @escaping (_ Success: Bool) -> ()) {
        let url = URLs.detailsUrl
        let userToken = Helper.getAuthToken()
        let parameters: [String: Any] = ["product_id": productID]
        let header: HTTPHeaders = ["token": userToken!]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: header)
            .responseJSON { (response) in
            switch response.result {
            case .success(let value):
                print(value)
                let json = JSON(value)
                
                // parse Details data
                self.ProductDetailsData.id = json["product"]["id"].int
                if let imageArray = json["product"]["img"].array {
                    self.imageData = []
                    for image in imageArray {
                        let url = image["img"].stringValue
                        print(url)
                        self.imageData.append(url)
                    }
                }
                self.ProductDetailsData.text = json["product"]["text"].string
                self.ProductDetailsData.price = json["product"]["price"].string
                self.ProductDetailsData.oldPrice = json["product"]["old_price"].string
                self.ProductDetailsData.offer = json["product"]["offer"].string
                if let sizeArray = json["product"]["size"].array {
                    self.sizeData = []
                    for size in sizeArray {
                        let size = size["size"].stringValue
                        print(size)
                        self.sizeData.append(size)
                    }
                }
                self.ProductDetailsData.rate = json["product"]["rate"].string
                self.ProductDetailsData.numRate = json["product"]["num_rate"].int
                
                completion(true)
                
            case .failure(let error):
                debugPrint(error)
                completion(false)
            }
        }
    }
}
