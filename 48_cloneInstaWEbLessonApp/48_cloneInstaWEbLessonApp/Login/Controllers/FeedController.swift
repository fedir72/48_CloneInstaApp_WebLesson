//
//  FeedController.swift
//  48_cloneInstaWEbLessonApp
//
//  Created by fedir on 20.05.2020.
//  Copyright © 2020 fedir. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class FeedController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         configureLoginButton()
         collectionView.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        // Register cell classes
         self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    
    }

 

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }
    
    //MARK: -
    fileprivate func configureLoginButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log out" , style: .plain, target: self, action: #selector(handleLogOut))
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
    }
    
    //MARK: - функция конфигурации действия лефтбарбаттонайтем
    @objc fileprivate func handleLogOut() {
        print("log out")
        //setup action
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert )
        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            do {
                try Auth.auth().signOut()
                let navcontr = UINavigationController(rootViewController: LoginViewController())
                navcontr.modalPresentationStyle = .fullScreen
                self.present(navcontr,animated: true,completion: nil)
            }catch{
                print("failet to sign out")
            }
            
        }
         
        ))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
       present(alert,animated: true,completion: nil)
    }
}
