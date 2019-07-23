//
//  PastTripVC.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 23/7/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth


class PastTripTableVC: UITableViewController {
    
    var db: Firestore!
    
    var itemArray = [Item]()
    
    private var document: [DocumentSnapshot] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        //initalize Database
        db = Firestore.firestore()
    }

}
