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
    var trippers: Any
    
    var dictionary: [String: Any] {
        return [
            "destination": destination,
            "uid": uid,
            "date": date,
            "trippers": trippers
        ]
    }
}

extension TripModal: DocumentTripSerializable {
    init?(dictionary: [String : Any]) {
        guard let destination = dictionary["destination"] as? String,
            let uid = dictionary["uid"] as? String,
            let date = dictionary["date"] as? String,
            let trippers = dictionary["trippers"] as? [String:Double] else {return nil}
        self.init(destination: destination, uid: uid, date: date, trippers: trippers)
    }
    
}

