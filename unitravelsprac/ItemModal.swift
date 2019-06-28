//
//  ItemModal.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 28/6/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import Foundation
import UIKit

protocol DocumentItemSerializable {
    init?(dictionary: [String: Any])
}

struct ItemModal {
    var item: String
    var price: Double
    var perperson: Double
    var payer: String
    var payees: Any
    
    var dictionary: [String: Any] {
        return [
            "item": item,
            "price": price,
            "perperson": perperson,
            "payer": payer,
            "payees": payees
        ]
    }
}

extension ItemModal: DocumentTripSerializable {
    init?(dictionary: [String : Any]) {
        guard let item = dictionary["item"] as? String,
            let price = dictionary["price"] as? Double,
            let perperson = dictionary["perperson"] as? Double,
            let payer = dictionary["payer"] as? String,
            let payees = dictionary["payees"] as? Any else {return nil}
        self.init(item: item, price: price, perperson: perperson, payer: payer, payees: payees)
    }
    
}



