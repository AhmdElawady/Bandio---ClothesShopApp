//
//  Alert.swift
//  Online Shop App
//
//  Created by Awady on 12/10/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    class func showBasic(title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
