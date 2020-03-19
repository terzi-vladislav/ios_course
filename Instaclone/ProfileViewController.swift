//
//  ProfileViewController.swift
//  Instaclone
//
//  Created by Terzi Vladislav on 11.03.2020.
//  Copyright © 2020 Terzi Vladislav. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        continueTransfer = true
        setUpNavigationBar()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        lastSelectedSBIndex = 4
    }
    
    func setUpNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}
