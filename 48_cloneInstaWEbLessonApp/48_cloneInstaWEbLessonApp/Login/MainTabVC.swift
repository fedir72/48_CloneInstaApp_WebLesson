//
//  MainTabVC.swift
//  48_cloneInstaWEbLessonApp
//
//  Created by fedir on 18.05.2020.
//  Copyright © 2020 fedir. All rights reserved.
//

import UIKit
import Firebase

//MARK: -


class MainTabVC: UITabBarController ,UITabBarControllerDelegate{
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        //MARK: - delegate for tabbar
         self.delegate = self
        
       createTabBar()
      //MARK: - вызов проверки пользователя на логин
      ifUserLogedIn()
        
    }
    
    //MARK: - settings for tabbar
    
    fileprivate func createTabBar() {
        tabBar.tintColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
              
              let feed = createNavController(viewcontroller: FeedController(collectionViewLayout: UICollectionViewLayout()), title: "Feed", selectedImage: #imageLiteral(resourceName: "home"), unselectedImage: #imageLiteral(resourceName: "home"))
              let search = createNavController(viewcontroller: UIViewController(), title: "search", selectedImage: #imageLiteral(resourceName: "search"), unselectedImage: #imageLiteral(resourceName: "search"))
              let newPost = createNavController(viewcontroller: UIViewController(), title: "Post", selectedImage: #imageLiteral(resourceName: "sms"), unselectedImage: #imageLiteral(resourceName: "sms"))
              let likes = createNavController(viewcontroller : UIViewController(), title: "Likes", selectedImage: #imageLiteral(resourceName: "heart"), unselectedImage: #imageLiteral(resourceName: "heart"))
              let profile = createNavController(viewcontroller: UIViewController(), title: "Profile", selectedImage: #imageLiteral(resourceName: "user_male"), unselectedImage: #imageLiteral(resourceName: "user_male") )
              
              //MARK: - controllers for tabbar
              viewControllers = [feed,search,newPost,likes,profile]
        
        
    }
    
    //MARK: - функция проверки пользователя (залогинен ли пользователь)
    
    fileprivate func ifUserLogedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginVC = LoginViewController()
                let navContr = UINavigationController(rootViewController: loginVC)
                navContr.modalPresentationStyle = .fullScreen
                self.present(navContr,animated: true,completion: nil)
            
            }
             return
        }
    }
    
    
//MARK: - функия создания контроллеров для навбара
    
    fileprivate func createNavController(viewcontroller: UIViewController,title: String,selectedImage: UIImage,unselectedImage: UIImage) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewcontroller)
        navController.tabBarItem.title = title
        navController.navigationItem.title  = title
        navController.tabBarItem.image = unselectedImage
        //navController.tabBarItem.selectedImage = selectedImage
        viewcontroller.view.backgroundColor = #colorLiteral(red: 0.8290650352, green: 1, blue: 0.7140389264, alpha: 1)
        
        return navController
    }
    

}
