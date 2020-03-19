//
//  TabBarViewController.swift
//  
//
//  Created by Terzi Vladislav on 18.03.2020.
//

import UIKit

class TabBarViewController:  UITabBarController, UITabBarControllerDelegate {
    
    var homeViewController: HomeViewController!
    var searchVeiwController: SearchViewController!
    var addPhotoViewController: AddPhotoViewController!
    var activityViewController: ActivityViewController!
    var profileViewController: ProfileViewController!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.delegate = self
        homeViewController = HomeViewController()
        searchVeiwController = SearchViewController()
        addPhotoViewController = AddPhotoViewController()
        activityViewController = ActivityViewController()
        profileViewController = ProfileViewController()

        homeViewController.tabBarItem.image = UIImage(systemName: "house")
        homeViewController.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        searchVeiwController.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle")
        searchVeiwController.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass.circle.fill")
        addPhotoViewController.tabBarItem.image = UIImage(systemName: "plus.app")
        addPhotoViewController.tabBarItem.selectedImage = UIImage(systemName: "plus.app.fill")
        activityViewController.tabBarItem.image = UIImage(systemName: "heart")
        activityViewController.tabBarItem.selectedImage = UIImage(systemName: "heart.fill")
        profileViewController.tabBarItem.image = UIImage(systemName: "person")
        profileViewController.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        viewControllers = [homeViewController, searchVeiwController, addPhotoViewController, activityViewController, profileViewController]
        for tabBarItem in tabBar.items! {
            tabBarItem.title = ""
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.isKind(of: AddPhotoViewController.self) {
            let vc = AddPhotoViewController()
            vc.modalPresentationStyle = .pageSheet
            self.present(vc, animated: true, completion: nil)
            return false
        }
        return true
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
