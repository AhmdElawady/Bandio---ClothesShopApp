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
    
    var ProductDetailsData = [ProductDetailsModel]()
    var imageData = [imagesModel]()
    
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
                guard let detailsArray = json["product"].array else {
                    completion(false)
                    return
                }
                self.ProductDetailsData = []
                for item in detailsArray {
                    guard let item = item.dictionary else {
                        completion(false)
                        return
                    }
                    var model = ProductDetailsModel()

                    model.id = item["id"]?.int
                    model.images = item["img"]?.arrayObject as? [imagesModel]
                    model.text = item["text"]?.string
                    model.price = item["price"]?.string
                    model.oldPrice = item["old_price"]?.string
                    model.offer = item["offer"]?.string
                    model.sizes = item["size"]?.arrayObject as? [String]
                    model.rate = item["rate"]?.string
                    model.numRate = item["num_rate"]?.int

                    self.ProductDetailsData.append(model)

                    print(self.ProductDetailsData)
                    print(self.imageData)
                }
                guard let images = json["product"]["img"].array else {
                    completion(false)
                    return
                }
                for img in images {
                    var data = imagesModel()
                    data.image = img["img"].string
                    self.imageData.append(data)
                }

                completion(true)
                
            case .failure(let error):
                debugPrint(error)
                completion(false)
            }
        }
    }
}
