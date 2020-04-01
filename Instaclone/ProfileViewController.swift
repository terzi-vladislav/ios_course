//
//  ProfileViewController.swift
//  Instaclone
//
//  Created by Terzi Vladislav on 11.03.2020.
//  Copyright © 2020 Terzi Vladislav. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var photos: [UIImage] = []
    var counter: Int = 0

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var userName: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        let uid = (Auth.auth().currentUser?.uid)!
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? NSDictionary {
                self.userName.text = value["username"] as? String
                let url = URL(string: (value["profile_image_url"] as? String)!)
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url!) {
                        DispatchQueue.main.async {
                            let image = UIImage(data: data)
                            self.userPicture.image = image
                        }
                    }
                }
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueTransfer = true
        setUpNavigationBar()
        userPicture.layer.cornerRadius = 0.5 * userPicture.bounds.size.height
        userPicture.contentMode = .scaleAspectFill
        tableView.dataSource = self
        getPhotos()
    }
    
    func getPhotos() {
        let uid = (Auth.auth().currentUser?.uid)!
        let ref = Database.database().reference().child("users")
        ref.child(uid).child("posts").observe(.childAdded) { (snapshot: DataSnapshot) in
            if let dict = snapshot.value as? [String: Any] {
                let photoUrlString = dict["photo"] as! String
                let photoUrl = URL(string: photoUrlString)
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: photoUrl!) {
                        DispatchQueue.main.async {
                            self.photos.append(UIImage(data: data)!)
                            self.counter += 1
                            if self.counter % 3 == 0 {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        lastSelectedSBIndex = 4
    }
    
    func setUpNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(photos.count / 3)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTriplet", for: indexPath) as! PhotoTripletTableViewCell
        if photos.count > indexPath.row * 3 + 2 {
            cell.firstPhoto.image = photos[indexPath.row * 3]
            cell.secondPhoto.image = photos[indexPath.row * 3 + 1]
            cell.thirdPhoto.image = photos[indexPath.row * 3 + 2]
        }
        return cell
    }
    
}
