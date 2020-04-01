//
//  SearchViewController.swift
//  Instaclone
//
//  Created by Terzi Vladislav on 11.03.2020.
//  Copyright © 2020 Terzi Vladislav. All rights reserved.
//

import UIKit
import Alamofire
import ProgressHUD

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    var photos: [Photo] = []
    var pictureUrls: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        tabBarItem.title = ""
        continueTransfer = true
        tableView.dataSource = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            ProgressHUD.show("Searching", interaction: false)
            pictureUrls = []
            execute(hashTag: searchText.lowercased())
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        lastSelectedSBIndex = 1
    }
    
    func setUpNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.placeholder = "Search for any IG Hashtag"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pictureUrls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell") as! PhotoTableViewCell
        cell.updateAppearanceFor(pictureUrls[indexPath.row])
        return cell
    }
    
    func execute(hashTag: String) {
        let headers = HTTPHeaders([HTTPHeader.authorization("Token \(Config.API_TOKEN)")])
        let url = Config.HASHTAG_URL + hashTag
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers, interceptor: nil).responseJSON
            {
                response in
                if let apiResponse = response.value as? [[String : Any]] {
                    for dict in apiResponse {
                        if let pictureCandidates = dict["image_versions2"] as? NSDictionary {
                            if let candidates = pictureCandidates["candidates"] as? NSArray {
                                if let photoOptions = candidates[0] as? NSDictionary {
                                    if let photoUrl = photoOptions["url"] as? String {
                                        self.pictureUrls.append(photoUrl)
                                    }
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                    ProgressHUD.dismiss()
                }
        }
    }
}
