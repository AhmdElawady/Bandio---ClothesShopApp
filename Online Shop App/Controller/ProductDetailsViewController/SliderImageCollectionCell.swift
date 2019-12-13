//
//  SliderImageCollectionCell.swift
//  Online Shop App
//
//  Created by Awady on 11/16/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit
import Kingfisher

class SliderImageCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configData(imageData: imagesModel) {
        print(imageData.image)
        if let image = imageData.image {
            imageCell.kf.indicatorType = .activity
            self.imageCell.kf.setImage(with: URL(string: image))
        }
    }

}
