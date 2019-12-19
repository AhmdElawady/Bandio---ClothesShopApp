//
//  CartViewCell.swift
//  Online Shop App
//
//  Created by Awady on 12/16/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit

class CartViewCell: UITableViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var textOfImageLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var checkMarkOutlet: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func configCell(cartData: CartModel) {
        priceLabel.text = "US$\(cartData.price!)"
//        counterLabel.text = cartData.maxCount
        textOfImageLabel.text = cartData.text
        sizeLabel.text = cartData.size
        if let image = cartData.image {
            imageCell.kf.indicatorType = .activity
            self.imageCell.kf.setImage(with: URL(string: image))
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setPlus() {
    var count = 0
    count += 1
        
    }
    
    
    
    
    
    
    
    
    
    @IBAction func plusPressed(_ sender: Any) {
        var counter = self.counterLabel.text
        counter! += String(1)
    }
    
    @IBAction func clearCounterPressed(_ sender: Any) {
        
    }
    
    @IBAction func checkMarkPressed(_ sender: Any) {
        self.checkMarkOutlet.setImage(UIImage(named: "checkmark.circle.fill.png"), for: UIControl.State.selected)
        
    }
    
    
    
}
