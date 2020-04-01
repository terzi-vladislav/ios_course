//
//  ActivityViewController.swift
//  Instaclone
//
//  Created by Terzi Vladislav on 11.03.2020.
//  Copyright © 2020 Terzi Vladislav. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var images: [UIImage] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        continueTransfer = true
        tableView.dataSource = self
        for _ in 0..<30 {
            let url = URL(string: Config.RANDOM_USER_PICS)
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url!) {
                    DispatchQueue.main.async {
                        self.images.append(UIImage(data: data)!)
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        lastSelectedSBIndex = 3
    }
    
    func setUpNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityTableViewCell
        if images.count > indexPath.row {
            cell.updateStyle(userPic: images[indexPath.row])
        } else {
            cell.setStyle(styleCode: Int.random(in: 1..<4), userPic: UIImage(systemName: "person.crop.circle")!, userId: indexPath.row)
        }
        return cell
    }
    
}
