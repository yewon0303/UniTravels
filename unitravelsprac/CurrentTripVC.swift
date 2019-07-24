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
    var db:Firestore!
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
    
    //global variables
    var tripTitle: String = ""
    var date: String = ""
    var destination: String = ""
    var allNames = [String]()
    var totalcost: Double = 0.0
    var startingTimestamp: Double = 0.0
    
    var Timestamp: String {
        return "\(NSDate().timeIntervalSince1970 * 1000)"
    }
    
    
    //MARK: Actions
    override func viewDidLoad() {
        super.viewDidLoad()
        //load the budget from database and display
        db = Firestore.firestore()
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
                                        if let date = document.data()["date"] as? String {
                                            if let destination = document.data()["destination"] as? String {
                                                if let startingTimestamp = document.data()["startingTimestamp"] as? Double {
                                                    self.currentTripTitle.title = title
                                                    
                                                    //update name and balance(paid for - debt)
                                                    let name1 = names[0]
                                                    if ((document.data()["tripper1On"]) as! Bool) {
                                                        self.tripper1Name.text = name1
                                                        self.tripper1.text = "$\(payers[name1]! + payees[name1]!)"
                                                        
                                                    } else {
                                                        self.tripper1Name.isHidden = true
                                                        self.tripper1.isHidden = true
                                                    }
                                                    
                                                    //repeat for rest
                                                    let name2 = names[1]
                                                    if ((document.data()["tripper2On"]) as! Bool) {
                                                        self.tripper2Name.text = name2
                                                        self.tripper2.text = "$\(payers[name2]! + payees[name2]!)"
                                                        
                                                    } else {
                                                        self.tripper2Name.isHidden = true
                                                        self.tripper2.isHidden = true
                                                    }
                                                    
                                                    let name3 = names[2]
                                                    if ((document.data()["tripper3On"]) as! Bool) {
                                                        self.tripper3Name.text = name3
                                                        self.tripper3.text = "$\(payers[name3]! + payees[name3]!)"
                                                        
                                                    } else {
                                                        self.tripper3Name.isHidden = true
                                                        self.tripper3.isHidden = true
                                                    }
                                                    
                                                    let name4 = names[3]
                                                    if ((document.data()["tripper4On"]) as! Bool) {
                                                        self.tripper4Name.text = name4
                                                        self.tripper4.text = "$\(payers[name4]! + payees[name4]!)"
                                                        
                                                    } else {
                                                        self.tripper4Name.isHidden = true
                                                        self.tripper4.isHidden = true
                                                    }
                                                    
                                                    
                                                    let name5 = names[4]
                                                    if ((document.data()["tripper5On"]) as! Bool) {
                                                        self.tripper5Name.text = name5
                                                        self.tripper5.text = "$\(payers[name5]! + payees[name5]!)"
                                                        
                                                    } else {
                                                        self.tripper5Name.isHidden = true
                                                        self.tripper5.isHidden = true
                                                    }
                                                    
                                                    
                                                    let name6 = names[5]
                                                    if ((document.data()["tripper6On"]) as! Bool) {
                                                        self.tripper6Name.text = name6
                                                        self.tripper6.text = "$\(payers[name6]! + payees[name6]!)"
                                                        
                                                    } else {
                                                        self.tripper6Name.isHidden = true
                                                        self.tripper6.isHidden = true
                                                    }
                                                    
                                                    self.total.text = "$\(total)"
                                                    
                                                    //assign to global variables
                                                    self.tripTitle = title
                                                    self.date = date
                                                    self.destination = destination
                                                    self.totalcost = total
                                                    self.allNames = names
                                                    self.startingTimestamp = startingTimestamp
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } 
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NSLog("viewDidAppear is running in current view")
        self.viewDidLoad()
    }
    
    @IBAction func returnButton(_ sender: Any) {
        performSegue(withIdentifier: "returnHomeFromCurrentTrip", sender: self)
    }
    
    
    @IBAction func archiveTapped(_ sender: Any) {
        let uid = Auth.auth().currentUser?.uid
        //set new field "archived" in current trip
        db.collection("trips").document(uid!).setData([ "archived": true ], merge: true)
        // create new document under past trips under users - copy details
        let trip = PastTripModal(destination: destination, uid: uid!, date: date, title: tripTitle, names: allNames, total: totalcost, startingTimestamp: startingTimestamp, endingTimestamp: Double(Timestamp)!)
        
        let tripRef = db.collection("users").document(uid!).collection("past trips")
        
        tripRef.document().setData(trip.dictionary){ err in
            var message: String = ""
            if err != nil {
                print("issue here at archiving trip")
                message = "There was an error."
            }else{
                print("trip document was saved")
                message = "\(self.tripTitle) successfully archived!"
            }
            //alert for creation of new trip
            let alertController = UIAlertController(title: nil, message: message , preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.display(alertController: alertController)
        }
        //delete current trip data
        db.collection("trips").document(uid!).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        //delete its subcollections items and memories
        db.collection("trips").document(uid!).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func display(alertController: UIAlertController) {
        self.present(alertController, animated: true, completion: nil)
    }
    
}
