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
    @IBOutlet weak var tripper5Name: UILabel!
    @IBOutlet weak var tripper6Name: UILabel!
    
    @IBOutlet weak var tripper1: UILabel!
    @IBOutlet weak var tripper2: UILabel!
    @IBOutlet weak var tripper3: UILabel!
    @IBOutlet weak var tripper4: UILabel!
    @IBOutlet weak var tripper5: UILabel!
    @IBOutlet weak var tripper6: UILabel!
    @IBOutlet weak var total: UILabel!
    
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var currentTripTitle: UINavigationItem!
    
    
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
                                    if let total = document.data()["total"] as? Double {
                                        self.currentTripTitle.title = title
                                        //update name and balance(paid for - debt)
                                        let name1 = names[0]
                                        if (self.checkExistence(currentName: name1, num: 1)) {
                                            self.tripper1Name.text = name1
                                            self.tripper1.text = "\(payers[name1]! + payees[name1]!)"
                                        } else {
                                            self.tripper1Name.isHidden = true
                                            self.tripper1.isHidden = true
                                        }
                                        
                                        //repeat for rest
                                        let name2 = names[1]
                                        if (self.checkExistence(currentName: name2, num: 2)) {
                                            self.tripper2Name.text = name2
                                            self.tripper2.text = "\(payers[name2]! + payees[name2]!)"
                                        } else {
                                            self.tripper2Name.isHidden = true
                                            self.tripper2.isHidden = true
                                        }
                                        
                                        let name3 = names[2]
                                        if (self.checkExistence(currentName: name3, num: 3)) {
                                            self.tripper3Name.text = name3
                                            self.tripper3.text = "\(payers[name3]! + payees[name3]!)"
                                        } else {
                                            self.tripper3Name.isHidden = true
                                            self.tripper3.isHidden = true
                                        }
                                        
                                        let name4 = names[3]
                                        if (self.checkExistence(currentName: name4, num: 4)) {
                                            self.tripper4Name.text = name4
                                            self.tripper4.text = "\(payers[name4]! + payees[name4]!)"
                                        } else {
                                            self.tripper4Name.isHidden = true
                                            self.tripper4.isHidden = true
                                        }
                                        
                                        
                                        let name5 = names[4]
                                        if (self.checkExistence(currentName: name5, num: 5)) {
                                            self.tripper5Name.text = name5
                                            self.tripper5.text = "\(payers[name5]! + payees[name5]!)"
                                        } else {
                                            self.tripper5Name.isHidden = true
                                            self.tripper5.isHidden = true
                                        }
                                        
                                        
                                        let name6 = names[5]
                                        if (self.checkExistence(currentName: name6, num: 6)) {
                                            self.tripper6Name.text = name6
                                            self.tripper6.text = "\(payers[name6]! + payees[name6]!)"
                                        } else {
                                            self.tripper6Name.isHidden = true
                                            self.tripper6.isHidden = true
                                        }
                                        
                                    self.total.text = "\(total)"
                                        
                                    }
                                    
                                }
                            }
                        }
                    } 
                }
            }
        }
    }
    
    func checkExistence(currentName: String, num: Int) -> Bool {
        if (currentName) != "tripper" + "\(num)" {
            return true
        } else {
            return false
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        NSLog("viewDidAppear is running in current view")
        self.viewDidLoad()
    }
    
    @IBAction func returnButton(_ sender: Any) {
        performSegue(withIdentifier: "returnHomeFromCurrentTrip", sender: self)
    }

}
