//
//  HomeViewController.swift
//  Online Shop App
//
//  Created by Awady on 11/6/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var sideMenuButton: UIButton!
    @IBOutlet weak var imageSliderCollectionView: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let imageArray = [
        UIImage(named: "image1"),
        UIImage(named: "image2"),
        UIImage(named: "image3"),
        UIImage(named: "image4"),
        UIImage(named: "image5"),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        imageSliderCollectionView.delegate = self
        imageSliderCollectionView.dataSource = self
        
        let HomeCellNib = UINib(nibName: "HomeCollectionCell", bundle: nil)
        self.collectionView.register(HomeCellNib, forCellWithReuseIdentifier: "HomeCollectionCell")
        
        let SliderCellNib = UINib(nibName: "SliderCell", bundle: nil)
        self.collectionView.register(SliderCellNib, forCellWithReuseIdentifier: "SliderCell")
        
        self.view.addSubview(collectionView)
        self.view.addSubview(imageSliderCollectionView)
        
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.imageSliderCollectionView) {
            return imageArray.count
        }
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == self.imageSliderCollectionView) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath as IndexPath) as! SliderCell
            cell.image = imageArray[indexPath.item]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath as IndexPath) as! HomeCollectionCell
            return cell
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if (collectionView == self.imageSliderCollectionView) {
            return 1
        }
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == self.imageSliderCollectionView) {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        return CGSize(width: 200, height: 250)
    }
    
}
