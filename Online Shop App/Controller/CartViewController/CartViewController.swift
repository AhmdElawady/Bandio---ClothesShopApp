//
//  CartViewController.swift
//  Online Shop App
//
//  Created by Awady on 12/16/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var totalItemLabel: UILabel!
    
    var cartData = [CartModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartTableView.delegate = self
        cartTableView.dataSource = self
        let cartNib = UINib(nibName: "CartViewCell", bundle: nil)
        self.cartTableView.register(cartNib, forCellReuseIdentifier: "CartViewCell")
        configCartData()
    }
    
    func configCartData() {
        CartAPI.instance.fetchCartData { (Seccess) in
            if Seccess {
                print("You are in Cart page")
                self.cartData = CartAPI.instance.cartData
                self.cartTableView.reloadData()
            } else {
                debugPrint("Error in Cart page")
            }
        }
    }
    
    var orderID = [String: Int]()
    var countOfProduct: String?
    @IBAction func CheckOutPressed(_ sender: Any) {
        
        for (index, idNumber) in self.cartData.enumerated() {
            orderID = ["product_id[\(index)]": Int(idNumber.id!)!]
            orderID["total"] = Int(totalItemLabel.text!)
            orderID["product_count"] = Int(countOfProduct ?? "")
            print(countOfProduct!)
        }
        
        CheckOutAPI.instance.sendOrderData { (Success) in
            if Success {
                print("CheckedOut Successfully")
            } else {
                print("Error in CheckOut")
            }
        }
        
    }
    
    
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartViewCell", for: indexPath) as! CartViewCell
        cell.configCell(cartData: cartData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}
