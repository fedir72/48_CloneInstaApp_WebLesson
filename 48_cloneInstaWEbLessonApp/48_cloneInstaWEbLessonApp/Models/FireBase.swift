//
//  FireBase.swift
//  48_cloneInstaWEbLessonApp
//
//  Created by fedir on 23.05.2020.
//  Copyright © 2020 fedir. All rights reserved.
//

import UIKit
import Firebase

//MARK: - функция извлечения юзера

extension Firestore {
    func fetchCurrentUSER(completion: @escaping (User?,Error?) -> ())  {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, err) in
            if let err = err {
                completion(nil,err)
                return
            }
            
            guard let dictionary = snapshot?.data() else {return}
            let user = User(dictionary: dictionary)
            completion(user,nil)
            
        }
    }
}
