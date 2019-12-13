//
//  SliderCell.swift
//  Online Shop App
//
//  Created by Awady on 11/9/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit
import Kingfisher

class SliderCell: UICollectionViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configCell(sliderData: SliderModel) {
        if let image = sliderData.image {
            imageCell.kf.indicatorType = .activity
            self.imageCell.kf.setImage(with: URL(string: image))
        }
    }

}
