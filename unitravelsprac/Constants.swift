//
//  Constants.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 29/7/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import Firebase
import FirebaseFirestore

struct Constants
{
    struct refs
    {
        static let db = Firestore.firestore()
        static let databaseChats = db.collection("chats")
    }
}
