//
//  RequestsVC.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 26/7/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RequestsVC: UIViewController {
    
    //MARK: Properties
    var db: Firestore!
    var requestsArray = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Actions

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        db = Firestore.firestore()
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        requestsArray = [String]()
        
        self.loadData()
        
        
    }
    
    
    func loadData() {
        let uid = Auth.auth().currentUser?.uid
        db.collection("users").whereField("uid", isEqualTo: uid!).getDocuments { (snapshot, error) in
            if error != nil {
                print(error!)
            }else{
                for document in (snapshot?.documents)! {
                    let data = document.data()
                    let requests = data["requests"] as? Array<String> ?? []
                    //get emails of each uid
                    for i in requests.indices {
                        print(i)
                        self.db.collection("users").whereField("uid", isEqualTo: requests[i]).getDocuments { (snapshot, error) in
                            if error != nil {
                                print(error!)
                            }else{
                                for document in (snapshot?.documents)! {
                                    let data = document.data()
                                    let email = data["email"] as? String ?? ""
                                    self.requestsArray.append(email)
                                    print(email)
                                    
                                }
                                self.tableView.reloadData()
    
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
           
        }
    }
    
    func createAlert(title: String, message: String, email: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //create yes button
        alert.addAction(UIAlertAction(title: "YES", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            
            //carry out sending request action
            let uid = Auth.auth().currentUser?.uid
            self.db.collection("users").whereField("email", isEqualTo: email).getDocuments { (snapshot, error) in
                if error != nil {
                    print(error!)
                }else{
                    for document in (snapshot?.documents)! {
                        let data = document.data()
                        let otherId = data["uid"] as? String ?? ""
                        
                        //add button - add your uid to friends of others and remove from requests and vice versa
                        
                        self.db.collection("users").document(otherId).updateData([
                            "friends": FieldValue.arrayUnion(["\(uid!)"]),
                            "requests": FieldValue.arrayRemove(["\(uid!)"])
                            ])
                        
                        self.db.collection("users").document(uid!).updateData([
                            "friends": FieldValue.arrayUnion(["\(otherId)"]),
                            "requests": FieldValue.arrayRemove(["\(otherId)"])
                            ])
                        print("friends with \(otherId)")
                        
                    }
                }
            }
            
            
        }))
        
        //create no button
        alert.addAction(UIAlertAction(title: "NO", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            print("not accepted")
        }))
        self.present(alert, animated: true, completion: nil)
    }

}

extension RequestsVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "requestCell") as? RequestTVCell
            cell?.labelName.text = requestsArray[indexPath.row]
       
        cell?.cellDelegate = self
        cell?.index = indexPath
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

extension RequestsVC: RequestTableView {
    func onClickCell(index: Int) {
        let email = requestsArray[index]
        self.createAlert(title: "CONFIRMATION", message: "Accept request from \(email)?", email: email)
    }
}
