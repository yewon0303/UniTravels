//
//  UsersVC.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 26/7/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import UIKit

class UsersVC: UIViewController {
    
    //MARK: ~Properties
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var userArray = ["apple", "orange", "zebra", "zoo", "add", "opera"]
    
    var searchUser = [String]()
    
    var searching = false
    
    //MARK: ~Actions

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func returnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}

extension UsersVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchUser.count
        }else{
            return userArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell")
        if searching {
            cell?.textLabel?.text = searchUser[indexPath.row]
        }else{
           cell?.textLabel?.text = userArray[indexPath.row]
        }
        return cell!
    }
}

extension UsersVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //find all elements that start with prefix and store in searchUser array
        searchUser = userArray.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
