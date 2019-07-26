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
        tableView.tableFooterView = UIView()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        emailArray = [String]()
        searchEmailArray = [String]()
        
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
    
    func createAlert(title: String, message: String, email: String) {
        let alert = UIAlertController(title: "CONFIRMATION", message: "send request to \(email)?", preferredStyle: .alert)
        //create yes button
        alert.addAction(UIAlertAction(title: "YES", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            //carry out sending request action
            self.db.collection("users").whereField("email", isEqualTo: email).getDocuments { (snapshot, error) in
                if error != nil {
                    print(error!)
                }else{
                    for document in (snapshot?.documents)! {
                        let data = document.data()
                        let userId = data["uid"] as? String ?? ""
                        
                        //add button - send request
                        
                        self.db.collection("users").document(userId).updateData([
                            "requests": FieldValue.arrayUnion(["\(userId)"])
                            ])
                        print("request sent to \(userId)")
                        
                    }
                }
            }
            
            
        }))
        //create no button
        alert.addAction(UIAlertAction(title: "NO", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            print("no request sent")
        }))
        self.present(alert, animated: true, completion: nil)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserTVCell
        if searching {
            cell?.labelName.text = searchEmailArray[indexPath.row]
        }else{
            cell?.labelName.text = emailArray[indexPath.row]
        }
        cell?.cellDelegate = self
        cell?.index = indexPath
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

extension UsersVC: UserTableView {
    func onClickCell(index: Int) {
        var email = ""
        if searching {
            email = searchEmailArray[index]
        }else{
            email = emailArray[index]
        }
        self.createAlert(title: "CONFIRMATION", message: "Send request to \(email)?", email: email)
        
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




