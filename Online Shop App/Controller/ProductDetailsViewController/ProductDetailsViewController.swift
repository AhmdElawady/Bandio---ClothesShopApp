//
//  ProductDetailsViewController.swift
//  Online Shop App
//
//  Created by Awady on 11/15/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var imageSliderCollectionView: UICollectionView!
    @IBOutlet weak var productPageControl: UIPageControl!
    
    var productID = 0
    var detailsData = [ProductDetailsModel]()
    var imageData = [imagesModel]()
    
    var curruntIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(imageData.count)
        configData()
        print(productID)
        imageSliderCollectionView.delegate = self
        imageSliderCollectionView.dataSource = self
        
        let imageSliderNib = UINib(nibName: "SliderImageCollectionCell", bundle: nil)
        self.imageSliderCollectionView.register(imageSliderNib, forCellWithReuseIdentifier: "SliderImageCollectionCell")
        
        productPageControl.numberOfPages = imageData.count
    }
    
    func configData() {
        ProductDetailsAPI.instance.fetchDetailsData(productID: productID) { (Success) in
            if Success {
                print("you are in details page")
                self.detailsData = ProductDetailsAPI.instance.ProductDetailsData
                self.imageData = ProductDetailsAPI.instance.imageData
                self.imageSliderCollectionView.reloadData()
            } else {
                debugPrint(Error.self)
            }
        }
    }
}
    
extension ProductDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderImageCollectionCell", for: indexPath) as! SliderImageCollectionCell
        cell.configData(imageData: imageData[indexPath.item])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 500)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        curruntIndex = Int(scrollView.contentOffset.x / imageSliderCollectionView.frame.size.width)
        productPageControl.currentPage = curruntIndex
    }
    
}
