//
//  TripModal.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 26/6/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import Foundation
import UIKit

protocol DocumentTripSerializable {
    init?(dictionary: [String: Any])
}

struct TripModal {
    var destination: String
    var uid: String
    var date: String
    var title: String
    var payers: Any
    var payees: Any
    
    var dictionary: [String: Any] {
        return [
            "destination": destination,
            "uid": uid,
            "date": date,
            "title": title,
            "payers": payers,
            "payees": payees,
        ]
    }
}

extension TripModal: DocumentTripSerializable {
    init?(dictionary: [String : Any]) {
        guard let destination = dictionary["destination"] as? String,
            let uid = dictionary["uid"] as? String,
            let date = dictionary["date"] as? String,
            let title = dictionary["title"] as? String,
            let payers = dictionary["payers"] as? [String:Double],
            let payees = dictionary["payees"] as? [String:Double] else {return nil}
        self.init(destination: destination, uid: uid, date: date, title: title, payers: payers, payees: payees)
    }
    
}



