//
//  MainTabVC.swift
//  48_cloneInstaWEbLessonApp
//
//  Created by fedir on 18.05.2020.
//  Copyright © 2020 fedir. All rights reserved.
//

import UIKit

//MARK: -


class MainTabVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = .black
        
        let feed = createNavController(viewcontroller: UIViewController(), title: "Feed", selectedImage: #imageLiteral(resourceName: "home"), unselectedImage: #imageLiteral(resourceName: "home-white-1"))
        let search = createNavController(viewcontroller: UIViewController(), title: "search", selectedImage: #imageLiteral(resourceName: "search"), unselectedImage: #imageLiteral(resourceName: "searsh nil-1"))
        let newPost = createNavController(viewcontroller: UIViewController(), title: "Post", selectedImage: #imageLiteral(resourceName: "speech_buble"), unselectedImage: #imageLiteral(resourceName: "shutdown"))
        let likes = createNavController(viewcontroller: UIViewController(), title: "Likes", selectedImage: #imageLiteral(resourceName: "heart"), unselectedImage: #imageLiteral(resourceName: "hearts_white-1"))
        let profile = createNavController(viewcontroller: UIViewController(), title: "Profile", selectedImage: #imageLiteral(resourceName: "user_male"), unselectedImage: #imageLiteral(resourceName: "white nan-1") )
        viewControllers = [feed,search,newPost,likes,profile]
    }
    
//MARK: - функия создания контроллеров для навбара
    
    fileprivate func createNavController(viewcontroller: UIViewController,title: String,selectedImage: UIImage,unselectedImage: UIImage) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewcontroller)
        navController.tabBarItem.title = title
        navController.navigationItem.title = title
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        
        viewcontroller.view.backgroundColor = .white
        
        return navController
    }
    

}
