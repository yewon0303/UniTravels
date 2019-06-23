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
    var id: String
    var username: String
    var password: String
    
    var dictionary: [String: Any] {
        return [
            "id": id,
            "username": username,
            "password": password
        ]
    }
}

extension UserModal: DocumentUserSerializable {
    init?(dictionary: [String : Any]) {
        guard let id = dictionary["id"] as? String,
            let username = dictionary["username"] as? String,
            let password = dictionary["password"] as? String else {return nil}
        self.init(id: id, username: username, password: password)
    }

}
