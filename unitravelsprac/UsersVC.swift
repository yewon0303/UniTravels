//
//  UsersVC.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 26/7/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class UsersVC: UIViewController {
    
    //MARK: ~Properties
    var db: Firestore!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var emailArray = [String]()

    var searchEmailArray = [String]()
    
    var searching = false
    
    //MARK: ~Actions

    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
            self.loadData()
        
    }
    func loadData() {
        
            db.collection("users").whereField("privacy", isEqualTo: "public").getDocuments { (snapshot, error) in
            if error != nil {
                print(error!)
            }else{
                for document in (snapshot?.documents)! {
                    let data = document.data()
                    let email = data["email"] as? String ?? ""
                    self.emailArray.append(email)
                    
                }
                self.tableView.reloadData()
                    
            }
                    
        }
    }
    
    
    @IBAction func returnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}

extension UsersVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchEmailArray.count
        }else{
            return emailArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell")
        if searching {
            cell?.textLabel?.text = searchEmailArray[indexPath.row]
        }else{
            cell?.textLabel?.text = emailArray[indexPath.row]
        }
        return cell!
    }
}

extension UsersVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //find all elements that start with prefix and store in searchUser array
        searchEmailArray = emailArray.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}


