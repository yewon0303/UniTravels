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
    var names: Any
    var payers: [String:Double]
    var payees: [String:Double]
    var total: Double
    var tripper1On: Bool
    var tripper2On: Bool
    var tripper3On: Bool
    var tripper4On: Bool
    var tripper5On: Bool
    var tripper6On: Bool
    var startingTimestamp: Double
    
    
    var dictionary: [String: Any] {
        return [
            "destination": destination,
            "uid": uid,
            "date": date,
            "title": title,
            "names": names,
            "payers": payers,
            "payees": payees,
            "total": total,
            "tripper1On": tripper1On,
            "tripper2On": tripper2On,
            "tripper3On": tripper3On,
            "tripper4On": tripper4On,
            "tripper5On": tripper5On,
            "tripper6On": tripper6On,
            "startingTimestamp": startingTimestamp
        ]
    }
}

extension TripModal: DocumentTripSerializable {
    init?(dictionary: [String : Any]) {
        guard let destination = dictionary["destination"] as? String,
            let uid = dictionary["uid"] as? String,
            let date = dictionary["date"] as? String,
            let title = dictionary["title"] as? String,
            let names = dictionary["names"] as? Any,
            let payers = dictionary["payers"] as? [String:Double],
            let payees = dictionary["payees"] as? [String:Double],
            let tripper1On = dictionary["tripper1On"] as? Bool,
            let tripper2On = dictionary["tripper2On"] as? Bool,
            let tripper3On = dictionary["tripper3On"] as? Bool,
            let tripper4On = dictionary["tripper4On"] as? Bool,
            let tripper5On = dictionary["tripper5On"] as? Bool,
            let tripper6On = dictionary["tripper6On"] as? Bool,
            let startingTimestamp = dictionary["startingTimestamp"] as? Double,
        let total = dictionary["total"] as? Double else {return nil}
        self.init(destination: destination, uid: uid, date: date, title: title, names: names, payers: payers, payees: payees, total: total, tripper1On: tripper1On, tripper2On: tripper2On, tripper3On: tripper3On, tripper4On: tripper4On, tripper5On: tripper5On, tripper6On: tripper6On, startingTimestamp: startingTimestamp)
    }
    
}



