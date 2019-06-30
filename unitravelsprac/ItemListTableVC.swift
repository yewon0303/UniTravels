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
        
        //initalize Database
        db = Firestore.firestore()
    }
   
    func loadData() {
        let uid = (Auth.auth().currentUser?.uid)!
        db.collection("trips").document(uid).collection("items").whereField("uid", isEqualTo:uid).getDocuments() { (snapshot, error) in
            
            if let error = error {
                
                print(error.localizedDescription)
                
            } else {
                
                if let snapshot = snapshot {
                    
                    for document in snapshot.documents {
                        
                        let data = document.data()
                        let name = data["item"] as? String ?? ""
                        let price = data["price"] as? Double ?? 0.0
                        let newItem = Item(name: name, price: price)
                        self.itemArray.append(newItem)
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NSLog("viewDidAppear is running in current view")
        itemArray = [Item]()
        loadData()
        
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

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
