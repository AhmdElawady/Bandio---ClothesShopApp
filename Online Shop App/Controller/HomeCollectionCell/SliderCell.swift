//
//  SliderCell.swift
//  Online Shop App
//
//  Created by Awady on 11/9/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit

class SliderCell: UICollectionViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    
    var image: UIImage! {
        didSet {
            imageCell.image = image
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
