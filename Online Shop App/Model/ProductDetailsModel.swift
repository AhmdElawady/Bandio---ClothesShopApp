//
//  ProductDetailsModel.swift
//  Online Shop App
//
//  Created by Awady on 12/12/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import Foundation

struct ProductDetailsModel {
    var id: Int?
    var images: [imagesModel]?
    var text: String?
    var price: String?
    var oldPrice: String?
    var offer: String?
    var sizes: [String]?
    var rate: String?
    var numRate: Int?
}

struct imagesModel {
    var image: String?
}
