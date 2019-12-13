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
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var sliderData = [SliderModel]()
    var homeData = [HomeModel]()
    
    var timer: Timer?
    var curruntIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configeData()
        
        sideMenuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        imageSliderCollectionView.delegate = self
        imageSliderCollectionView.dataSource = self
        
        let HomeCellNib = UINib(nibName: "HomeCollectionCell", bundle: nil)
        self.homeCollectionView.register(HomeCellNib, forCellWithReuseIdentifier: "HomeCollectionCell")
        
        let SliderCellNib = UINib(nibName: "SliderCell", bundle: nil)
        self.imageSliderCollectionView.register(SliderCellNib, forCellWithReuseIdentifier: "SliderCell")
        
        pageControl?.numberOfPages = sliderData.count

        startTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction() {
        let scrolPosition = (curruntIndex < sliderData.count - 1) ? curruntIndex + 1 : 0
        imageSliderCollectionView.scrollToItem(at: IndexPath(item: scrolPosition, section: 0), at: .centeredHorizontally, animated: true)
    }
    func configeData() {
        HomeAPI.instance.fetchHomeData { (Success) in
            if Success {
                print("You are in home page")
                self.sliderData = HomeAPI.instance.sliderData
                self.homeData = HomeAPI.instance.homeData
                
                self.imageSliderCollectionView.reloadData()
                self.homeCollectionView.reloadData()
            } else {
                print("Error in home page")
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == imageSliderCollectionView) {
            return sliderData.count
        }
        return homeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == imageSliderCollectionView) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as! SliderCell
            cell.configCell(sliderData: sliderData[indexPath.item])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath) as! HomeCollectionCell
            cell.configCell(homeData: homeData[indexPath.item])
            return cell
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == self.imageSliderCollectionView) {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        return CGSize(width: CGFloat(collectionView.frame.size.width / 2) - 1, height: 300)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (scrollView == imageSliderCollectionView) {
            curruntIndex = Int(scrollView.contentOffset.x / homeCollectionView.frame.size.width)
            pageControl?.currentPage = curruntIndex
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == homeCollectionView{
            let view = self.storyboard?.instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController
            view.categoryID = homeData[indexPath.row].id ?? ""
            self.navigationController?.pushViewController(view, animated: true)
        }

    }
    
}
