//
//  ProductCollectionCell.swift
//  Online Shop App
//
//  Created by Awady on 11/11/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit
import Kingfisher

class ProductCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    
    @IBOutlet weak var likeCounterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setHashLabel()
    }
    
    func configCell(productData: ProductModel) {
        priceLabel.text = "US$\(productData.price!)"
        oldPriceLabel.text = "US$\(productData.oldPrice!)"
        if let image = productData.image {
            imageCell.kf.indicatorType = .activity
            self.imageCell.kf.setImage(with: URL(string: image))
        }
    }
    
    func setHashLabel() {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "ss")

            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        oldPriceLabel.attributedText = attributeString
    }
}
