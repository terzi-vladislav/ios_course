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
//        execute()

    }
    @IBAction func logOutBttn(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError {
            print(signOutError)
        }
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let signInVC = storyBoard.instantiateViewController(identifier: "SignInViewController")
        self.present(signInVC, animated: true, completion: nil)
    }
    
    func execute() {
        let headers = HTTPHeaders([HTTPHeader.authorization("Token 650c296a8e578f02db54481f393afdb08cc216c8")])
        let url = "https://cluster.likeup.me/api/get_hashtag_feed/?hashtag=mipt"

        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers, interceptor: nil).responseJSON
            {
                response in
            print(response)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
