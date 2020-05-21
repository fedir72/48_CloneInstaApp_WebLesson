//
//  ModelUser.swift
//  48_cloneInstaWEbLessonApp
//
//  Created by fedir on 20.05.2020.
//  Copyright © 2020 fedir. All rights reserved.
//

import Foundation

struct User {
    
    let fullName: String
    let userName: String
    let profileImage: String
    
    init(dictionary: [String: Any]) {
        self.fullName = dictionary["name"] as? String ?? ""
        self.userName = dictionary["username"] as? String ?? ""
        self.profileImage = dictionary["profileImageUrl"] as? String ?? ""
    }

}
