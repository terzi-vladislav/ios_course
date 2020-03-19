//
//  HomeViewController.swift
//  Instaclone
//
//  Created by Terzi Vladislav on 11.03.2020.
//  Copyright © 2020 Terzi Vladislav. All rights reserved.
//

import UIKit
import Firebase
import Alamofire

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 44, width: view.frame.size.width, height: 44))
        self.view.addSubview(navBar)

        let navItem = UINavigationItem.init(title: "Instagram")
        let logOutButton = UIBarButtonItem(title: "Logout", style: .plain, target: nil, action: #selector(HomeViewController.logOutBttn))
        navItem.leftBarButtonItem = logOutButton

        navBar.setItems([navItem], animated: false)
    }
    
    @objc func logOutBttn(_ sender: Any) {
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
    
    func execute() {
        let headers = HTTPHeaders([HTTPHeader.authorization("Token \(Config.API_TOKEN)")])
        let hashTag = "mipt"
        let url = Config.HASHTAG_URL + hashTag

        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers, interceptor: nil).responseJSON
            {
                response in
            print(response)
        }
    }
}
