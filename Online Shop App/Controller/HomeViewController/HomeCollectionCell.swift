//
//  HomeCollectionCellCollectionViewCell.swift
//  Online Shop App
//
//  Created by Awady on 11/6/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit
import Kingfisher

class HomeCollectionCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configCell(homeData: HomeModel) {
        titleLabel.text = homeData.text
        if let image = homeData.image {
            productImage.kf.indicatorType = .activity
            self.productImage.kf.setImage(with: URL(string: image))
        }
    }
    
    
}
