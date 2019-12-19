//
//  SizesCollectionViewCell.swift
//  Online Shop App
//
//  Created by Awady on 12/17/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit

class SizesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sizeCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(sizeData: String){
        sizeCell.text = sizeData
    }

}
