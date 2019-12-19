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
    @IBOutlet weak var pageControl: UIPageControl!
    
    var curruntIndex = 0
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configData(imageData: String) {
        if let image = URL(string: imageData) {
            imageCell.kf.indicatorType = .activity
            self.imageCell.kf.setImage(with: image)
        }
    }
}
