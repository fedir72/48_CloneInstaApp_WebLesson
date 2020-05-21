//
//  UserprofileController.swift
//  48_cloneInstaWEbLessonApp
//
//  Created by fedir on 20.05.2020.
//  Copyright © 2020 fedir. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"
private let userReuseIdentifier = "UserProfileCell"

class UserprofileController: UICollectionViewController , UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.backgroundColor = .white
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.register(Userprofileheader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: userReuseIdentifier)
        fetchCurrentUser() //извлечение данных юзера
    }
    
    //MARK: - api Firebase (извлечение юзера)
    
    func fetchCurrentUser() {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(currentUid).getDocument { (snapshot, err) in
            if let error = err {
                print("failed to catch user",error.localizedDescription)
                return
            }
            guard let dicTionAry = snapshot?.data() else {return}
            print(snapshot?.data() ?? "")
        }
        
        
    }
    
    
    

  //MARK: - UICOllectionViewDatasource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }
    
    //MARK: -  размер хедера
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width  , height: 200)
    } 
    
    //MARK: -  ячейка для хедера
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: userReuseIdentifier, for: indexPath) as! Userprofileheader
        //header.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return header
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }
 
}
