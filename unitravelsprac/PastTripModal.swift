//
//  PastTripModal.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 23/7/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import Foundation
import UIKit

protocol DocumentPastTripSerializable {
    init?(dictionary: [String: Any])
}

struct PastTripModal {
    var destination: String
    var uid: String
    var date: String
    var title: String
    var names: Any
    var total: Double
    var startingTimestamp: String
    var endingTimestamp: String

    
    
    var dictionary: [String: Any] {
        return [
            "destination": destination,
            "uid": uid,
            "date": date,
            "title": title,
            "names": names,
            "total": total,
            "startingTimestamp": startingTimestamp,
            "endingTimestamp": endingTimestamp
        ]
    }
}

extension PastTripModal: DocumentPastTripSerializable {
    init?(dictionary: [String : Any]) {
        guard let destination = dictionary["destination"] as? String,
            let uid = dictionary["uid"] as? String,
            let date = dictionary["date"] as? String,
            let title = dictionary["title"] as? String,
            let names = dictionary["names"] as? Any,
            let startingTimestamp = dictionary["startingTimestamp"] as? String,
            let endingTimestamp = dictionary["endingTimestamp"] as? String,
            let total = dictionary["total"] as? Double else {return nil}
            self.init(destination: destination, uid: uid, date: date, title: title, names: names, total: total, startingTimestamp: startingTimestamp, endingTimestamp: endingTimestamp)
    }
    
}




