//
//  User.swift
//  48_cloneInstaWEbLessonApp
// 
//  Created by fedir on 20.05.2020.
//  Copyright © 2020 fedir. All rights reserved.
//

import Foundation

class User {
    
    var name: String
    var username: String
    var profileImage: String
    var uid: String
    
    init(dictionary: [String: Any]) {
        
        self.name = dictionary["name"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImage = dictionary["profileImageUrl"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }

}
