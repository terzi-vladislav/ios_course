//
//  HomeViewController.swift
//  Instaclone
//
//  Created by Terzi Vladislav on 11.03.2020.
//  Copyright © 2020 Terzi Vladislav. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController {
    
    var posts = [Post]()
    var userName = "bog_ios_razrabotki"
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        continueTransfer = true
        tableView.dataSource = self
        loadPosts()
    }
    
    func loadPosts() {
        let uid = (Auth.auth().currentUser?.uid)!
        let ref = Database.database().reference().child("users")
        ref.child(uid).child("posts").observe(.childAdded) { (snapshot: DataSnapshot) in
            if let dict = snapshot.value as? [String: Any] {
                let captionText = dict["caption"] as! String
                let photoUrlString = dict["photo"] as! String
                let date = dict["date"] as! String
                let post = Post(userName: self.userName, captionText:captionText, photoUrlString: photoUrlString, date: date)
                self.posts.append(post)
                self.tableView.reloadData()
            }
        }
    }
    
    func setUpNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        lastSelectedSBIndex = 0
    }
    
    @IBAction func logOutBttn(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError {
            print(signOutError)
        }

        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let signInVC = storyBoard.instantiateViewController(identifier: "SignInViewController")
        signInVC.modalPresentationStyle = .fullScreen
        self.present(signInVC, animated: true, completion: nil)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        cell.userName.text = posts[indexPath.row].user
        cell.captionText.text = posts[indexPath.row].caption
        cell.dateText.text = posts[indexPath.row].dateOfPost
        cell.updateAppearanceFor(posts[indexPath.row].photoUrl)
        return cell
    }
}
