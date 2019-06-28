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
    @IBOutlet weak var addItem: UIButton!
    @IBOutlet weak var tripper1: UILabel!
    @IBOutlet weak var tripper2: UILabel!
    @IBOutlet weak var tripper3: UILabel!
    @IBOutlet weak var tripper4: UILabel!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var currentTripTitle: UINavigationItem!
    

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
                    if let title = document.data()["title"] as? String {
                        self.currentTripTitle.title = title
                    } 
                }
            }
        }
    }
    
    //MARK: Actions
    
    @IBAction func returnButton(_ sender: Any) {
        performSegue(withIdentifier: "returnHomeFromCurrentTrip", sender: self)
    }
    
    

}
