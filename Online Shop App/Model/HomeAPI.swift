//
//  SliderAPI.swift
//  Online Shop App
//
//  Created by Awady on 12/11/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HomeAPI {
    
    static var instance = HomeAPI()
    
    var sliderData = [SliderModel]()
    var homeData = [HomeModel]()
    
    func fetchHomeData(completion: @escaping (_ Success: Bool) -> ()) {
        
        let url = URLs.homeUrl
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseJSON { (response) in
            switch response.result {
            case .success(let value):
                print(value)
                let json = JSON(value)
                
                // parse slider data
                guard let sliderArray = json["slider"].array else {
                    completion(false)
                    return
                }
                for item in sliderArray {
                    guard let item = item.dictionary else {
                        completion(false)
                        return
                    }
                    
                    var model = SliderModel()
                    model.id = item["id"]?.stringValue
                    model.image = item["img"]?.stringValue
                    model.text = item["text"]?.stringValue
                    model.type = item["type"]?.stringValue
                    self.sliderData.append(model)
                }
                
                // parse home data
                guard let homeArray = json["home"].array else {
                    completion(false)
                    return
                }
                for item in homeArray {
                    guard let item = item.dictionary else {
                        completion(false)
                        return
                    }
                    var model = HomeModel()
                    model.id = item["id"]?.stringValue
                    model.image = item["img"]?.stringValue
                    model.text = item["text"]?.stringValue
                    model.type = item["type"]?.stringValue
                    self.homeData.append(model)
                }
                completion(true)
                
            case .failure(let error):
                debugPrint(error)
                completion(false)
            }
        }
    }
}
