//
//  ItemListTableVC.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 30/6/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth


class ItemListTableVC: UITableViewController {
    
    var db: Firestore!
    
    var itemArray = [Item]()
    
    private var document: [DocumentSnapshot] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(ItemCell.self, forCellReuseIdentifier: "ItemTableViewCell")
        
        //initalize Database
        db = Firestore.firestore()
    }
   
    func loadData() {
        let uid = (Auth.auth().currentUser?.uid)!
        
        db.collection("trips").whereField("uid", isEqualTo: uid).getDocuments { (snapshot, error) in
            if error != nil {
                print(error!)
            }else{
                for document in (snapshot?.documents)! {
                    //get starting timestamp
                    if let startingTimestamp = document.data()["startingTimestamp"] as? Double {
                        
                        //get items and add to array
                        self.db.collection("trips").document(uid).collection("items")
                            .order(by: "timestamp", descending: true)
                            .whereField("timestamp", isGreaterThan: startingTimestamp)
                            .getDocuments() { (snapshot, error) in
                                
                                if let error = error {
                                    
                                    print(error.localizedDescription)
                                    
                                } else {
                                    
                                    if let snapshot = snapshot {
                                        
                                        for document in snapshot.documents {
                                            
                                            let data = document.data()
                                            let name = data["item"] as? String ?? ""
                                            let price = data["price"] as? Double ?? 0.0
                                            let payer = data["payer"] as? String ?? ""
                                            let newItem = Item(name: name, price: price, payer: payer)
                                            self.itemArray.append(newItem)
                                           
                                        }
                                        self.tableView.reloadData()
                                    }
                                }
                        }
                        
                    }
                }
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        itemArray = [Item]()
        DispatchQueue.main.async {
            self.loadData()
        }
        
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = "\(item.name): \(item.price)"
        cell.detailTextLabel?.text = "Paid by \(item.payer)"

        return cell
    }
    

}

class ItemCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
