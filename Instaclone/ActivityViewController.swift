//
//  ActivityViewController.swift
//  Instaclone
//
//  Created by Terzi Vladislav on 11.03.2020.
//  Copyright © 2020 Terzi Vladislav. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        continueTransfer = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        lastSelectedSBIndex = 3
    }
    
    func setUpNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}
