//
//  ItemListVC.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 28/6/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseAuth

class ItemListVC: UIViewController {

    //MARK: Properties
    var db: Firestore!
    @IBOutlet weak var displayItem: UILabel!
    @IBOutlet weak var displayPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        let uid = Auth.auth().currentUser!.uid
        db.collection("trips").document(uid).collection("items").getDocuments { (snapshot, error) in
            if error != nil {
                print(error!)
            } else {
                for document in (snapshot?.documents)! {
                    if let itemNames = document.data()["item"]  {
                        print(itemNames)
                        self.displayItem.text = itemNames as! String
                    }
                    if let itemPrice = document.data()["price"] {
                        print(itemPrice)
                        self.displayPrice.text = "$ \(itemPrice as? [String:Double])"
                    }
                }
            }
        }
        
        
     
    }

}
