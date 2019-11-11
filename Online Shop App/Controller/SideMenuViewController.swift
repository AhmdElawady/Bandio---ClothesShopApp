//
//  SideMenuViewController.swift
//  Online Shop App
//
//  Created by Awady on 11/6/19.
//  Copyright © 2019 Awady. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 90
    }

}
