//
//  ProductDetailsViewController.swift
//  Online Shop App
//
//  Created by Awady on 11/15/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var sizesCollectionView: UICollectionView!
    @IBOutlet weak var imageSliderCollectionView: UICollectionView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var offerLabel: UILabel!
    @IBOutlet weak var stepperCounter: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    var selectedCell = [IndexPath]()
    var productID = 0
    var detailsData = ProductDetailsModel()
    var imageData = [String]()
    var sizeData = [String]()
    var pageControl: UIPageControl?
    var curruntIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        pageControl?.numberOfPages = imageData.count
        imageSliderCollectionView.delegate = self
        imageSliderCollectionView.dataSource = self
        let imageSliderNib = UINib(nibName: "SliderImageCollectionCell", bundle: nil)
        self.imageSliderCollectionView.register(imageSliderNib, forCellWithReuseIdentifier: "SliderImageCollectionCell")
        sizesCollectionView.delegate = self
        sizesCollectionView.dataSource = self
        let sizesNib = UINib(nibName: "SizesCollectionViewCell", bundle: nil)
        self.sizesCollectionView.register(sizesNib, forCellWithReuseIdentifier: "SizesCollectionViewCell")
        configData()
        setHashLabel()
    }
    
    @IBAction func stepperAction(_ sender: Any) {
        stepperCounter.text = String(Int(stepper.value))
        stepperCounter.reloadInputViews()
    }
    
    
    func configData() {
        ProductDetailsAPI.instance.fetchDetailsData(productID: productID) { (Success) in
            if Success {
                print("you are in details page")
                self.detailsData = ProductDetailsAPI.instance.ProductDetailsData
                self.imageData = ProductDetailsAPI.instance.imageData
                self.sizeData = ProductDetailsAPI.instance.sizeData
                self.imageSliderCollectionView.reloadData()
                self.sizesCollectionView.reloadData()
                self.textLabel.text = self.detailsData.text
                self.priceLabel.text = ("US$\(self.detailsData.price!)")
                self.oldPriceLabel.text = ("US$\(self.detailsData.oldPrice!)")
                self.offerLabel.text = self.detailsData.offer! + " % OFF"

            } else {
                debugPrint("Error in details page")
            }
        }
    }
    
    func setHashLabel() {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "ss")

            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        oldPriceLabel.attributedText = attributeString
    }
    
    var productSize = ""
    @IBAction func addToCartPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Add To Cart?", message: "Do you want to add this item to your cart?", preferredStyle: .alert)
                let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in
                    print(self.productSize)
                    print(self.stepperCounter.text!)
                    print(self.productID)
                    AddToCartAPI.instance.addDataToCart(productID: self.productID, productCount: Int(self.stepperCounter.text!)!, productSize: self.productSize) { (Success) in
                        if Success {
        //                    self.productTableView.reloadData()
                            print("Added to Cart successfully")
                        }
                    }
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(yesAction)
                alertController.addAction(cancelAction)
                present(alertController, animated: true, completion: nil)
//                self.productId = productData[indexPath.row].id ?? ""
    }
}
    
extension ProductDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imageSliderCollectionView {
            return imageData.count
        } else {
            return sizeData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imageSliderCollectionView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderImageCollectionCell", for: indexPath) as! SliderImageCollectionCell
        cell.configData(imageData: imageData[indexPath.item])
        cell.pageControl = self.pageControl
        pageControl?.numberOfPages = imageData.count
        return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SizesCollectionViewCell", for: indexPath) as! SizesCollectionViewCell
        cell.configCell(sizeData: sizeData[indexPath.item])
        if selectedCell.contains(indexPath) {
            cell.contentView.backgroundColor = .red
        }
        else {
            cell.contentView.backgroundColor = .white
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == imageSliderCollectionView {
        return CGSize(width: collectionView.frame.width, height: 500)
        }
        return CGSize(width: collectionView.frame.width.significandWidth.bitWidth, height: 40)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == sizesCollectionView {
            
            self.productSize = sizeData[indexPath.item]
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.layer.borderWidth = 2.0
            selectedCell.append(indexPath)
            cell?.layer.borderColor = UIColor.blue.cgColor
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)!
        if selectedCell.contains(indexPath) {
            selectedCell.remove(at: selectedCell.firstIndex(of: indexPath)!)
            cell.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        curruntIndex = Int(scrollView.contentOffset.x / imageSliderCollectionView.frame.size.width)
        self.pageControl?.currentPage = curruntIndex
    }
    
}
