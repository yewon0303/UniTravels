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
    
    var tripsArray = [PastTripModal]()
    
    private var document: [DocumentSnapshot] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(PastTripCell.self, forCellReuseIdentifier: "tripID")
        
        //initalize Database
        db = Firestore.firestore()
    }
    
    func loadData() {
        let uid = (Auth.auth().currentUser?.uid)!
        db.collection("users").document(uid).collection("past trips").whereField("uid", isEqualTo:uid).getDocuments() { (snapshot, error) in
            
            if let error = error {
                
                print(error.localizedDescription)
                
            } else {
                
                if let snapshot = snapshot {
                    
                    for document in snapshot.documents {
                        
                        let data = document.data()
                        let date = data["date"] as? String ?? ""
                        let total = data["total"] as? Double ?? 0.0
                        let destination = data["destination"] as? String ?? ""
                        let title = data["title"] as? String ?? ""
                        let names = data["names"] as Any
                        let newTrip = PastTripModal(destination: destination, uid: uid, date: date, title: title, names: names, total: total,startingTimestamp: 0.0, endingTimestamp: 0.0)
                        self.tripsArray.append(newTrip)
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NSLog("viewDidAppear is running in current view")
        tripsArray = [PastTripModal]()
        loadData()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tripsArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripID", for: indexPath)
        
        let trip = tripsArray[indexPath.row]
        
        cell.textLabel?.text = "\(trip.title) at \(trip.destination)"
        cell.detailTextLabel?.text = "Total expense: \(trip.total)"
        //cell.detailTextLabel?.text = "Date: \(trip.date)"
        
        return cell
    }
    
    
    @IBAction func returnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}


class PastTripCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
