//
//  CurrentTripVC.swift
//  unitravelsprac
//
//  Created by Park Ye Won on 28/6/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class CurrentTripVC: UIViewController {

    //MARK: Properties
    
    @IBOutlet weak var tripper1Name: UILabel!
    @IBOutlet weak var tripper2Name: UILabel!
    @IBOutlet weak var tripper3Name: UILabel!
    @IBOutlet weak var tripper4Name: UILabel!
    
    @IBOutlet weak var tripper1: UILabel!
    @IBOutlet weak var tripper2: UILabel!
    @IBOutlet weak var tripper3: UILabel!
    @IBOutlet weak var tripper4: UILabel!
    @IBOutlet weak var total: UILabel!
    
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var currentTripTitle: UINavigationItem!
    @IBOutlet weak var refresh: UIButton!
    
    
    
    //MARK: Actions
    override func viewDidLoad() {
        super.viewDidLoad()
        //load the budget from database and display
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        
        db.collection("trips").whereField("uid", isEqualTo: uid!).getDocuments { (snapshot, error) in
            if error != nil {
                print(error!)
            }else{
                for document in (snapshot?.documents)! {
                    //update details acc to firestore
                    if let title = document.data()["title"] as? String {
                        if let names = document.data()["names"] as? Array<String> {
                            if let payers = document.data()["payers"] as? [String:Double] {
                                if let payees = document.data()["payees"] as? [String:Double] {
                                    self.currentTripTitle.title = title
                                    //update name and balance(paid for - debt)
                                    let name1 = names[0]
                                    self.tripper1Name.text = name1
                                    self.tripper1.text = "\(payers[name1]! + payees[name1]!)"
                                    
                                    //repeat for rest
                                    let name2 = names[1]
                                    self.tripper2Name.text = name2
                                    self.tripper2.text = "\(payers[name2]! + payees[name2]!)"
                                    
                                    let name3 = names[2]
                                    self.tripper3Name.text = name3
                                    self.tripper3.text = "\(payers[name3]! + payees[name3]!)"
                                    
                                    let name4 = names[3]
                                    self.tripper4Name.text = name4
                                    self.tripper4.text = "\(payers[name4]! + payees[name4]!)"
                                    
                                    //total needs to be updated
                                    self.total.text = "\(payers[name1]! + payers[name2]! + payers[name3]! + payers[name4]!)"
                                }
                            }
                        }
                    } 
                }
            }
        }
    }
    
    
    @IBAction func refresh(_ sender: Any) {
        self.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NSLog("viewDidAppear is running in current view")
        self.viewDidLoad()
    }
    
    @IBAction func returnButton(_ sender: Any) {
        performSegue(withIdentifier: "returnHomeFromCurrentTrip", sender: self)
    }

}
