//
//  AddPhotoExtraPage.swift
//  Instaclone
//
//  Created by Terzi Vladislav on 19.03.2020.
//  Copyright © 2020 Terzi Vladislav. All rights reserved.
//

import UIKit

class AddPhotoExtraPage: UIViewController {
    
    @IBOutlet weak var shareButton: UIButton!
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        shareButton.layer.cornerRadius = 0.5 * shareButton.bounds.size.height
    }
    
    func setUpNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
