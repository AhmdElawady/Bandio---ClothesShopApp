//
//  ProductViewController.swift
//  Online Shop App
//
//  Created by Awady on 11/11/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var productCollectionView: UICollectionView!
    
    var categoryID = ""
    var productData = [ProductModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configData()
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        
        let productCellNib = UINib(nibName: "ProductCollectionCell", bundle: nil)
        self.productCollectionView.register(productCellNib, forCellWithReuseIdentifier: "ProductCollectionCell")
        
    }
    
    func configData() {
        ProductAPI.instance.fetchProductData(CategoryID: categoryID) { (Success) in
            if Success {
                print("You are in product page")
                self.productData = ProductAPI.instance.productData
                self.productCollectionView.reloadData()
            }
        }
    }

}

extension ProductViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionCell", for: indexPath) as! ProductCollectionCell
        cell.configCell(productData: productData[indexPath.row])
        return cell
    }
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat((collectionView.frame.size.width / 2) - 2), height: CGFloat(350))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        view.productID = productData[indexPath.item].id!
        self.navigationController?.pushViewController(view, animated: true)
    }
}
