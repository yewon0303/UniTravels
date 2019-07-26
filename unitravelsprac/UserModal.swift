//
//  UserModal.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 23/6/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import Foundation
import UIKit

protocol DocumentUserSerializable {
    init?(dictionary: [String: Any])
}

struct UserModal {
    var email: String
    var uid: String
    var username: String
    var password: String
    var privacy: String
    var friends: Array<String>
    var requests: Array<String>
    
    var dictionary: [String: Any] {
        return [
            "email": email,
            "uid": uid,
            "username": username,
            "password": password,
            "privacy": privacy,
            "friends": friends,
            "requests": requests
        ]
    }
}

extension UserModal: DocumentUserSerializable {
    init?(dictionary: [String : Any]) {
        guard let email = dictionary["email"] as? String,
            let uid = dictionary["uid"] as? String,
            let username = dictionary["username"] as? String,
            let privacy = dictionary["privacy"] as? String,
            let friends = dictionary["friends"] as? Array<String>,
            let requests = dictionary["requests"] as? Array<String>,
            let password = dictionary["password"] as? String else {return nil}
        self.init(email: email, uid: uid, username: username, password: password, privacy: privacy, friends: friends, requests: requests)
    }

}
