//
//  HomeCollectionCellCollectionViewCell.swift
//  Online Shop App
//
//  Created by Awady on 11/6/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit

class HomeCollectionCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitleButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func productTitlePressed(_ sender: Any) {
        
    }
    
}
