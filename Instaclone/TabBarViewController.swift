//
//  TabBarViewController.swift
//  
//
//  Created by Terzi Vladislav on 18.03.2020.
//

import UIKit

var lastSelectedSBIndex: Int = 0

class TabBarViewController:  UITabBarController {
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            self.selectedIndex = lastSelectedSBIndex
    }
}
