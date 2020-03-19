//
//  AddPhotoViewController.swift
//  Instaclone
//
//  Created by Terzi Vladislav on 11.03.2020.
//  Copyright © 2020 Terzi Vladislav. All rights reserved.
//

import UIKit
var continueTransfer: Bool = true

class AddPhotoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if continueTransfer {
            performSegue(withIdentifier: "AddPhoto", sender: (Any).self)
        } else {
            let storyBoard = UIStoryboard(name: "TabBarController", bundle: nil)
            let signInVC = storyBoard.instantiateViewController(identifier: "TabBar")
            signInVC.modalPresentationStyle = .fullScreen
            self.present(signInVC, animated: false, completion: nil)
        }
    }
}
