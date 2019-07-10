//
//  SettingsVC.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 23/6/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseAuth

class SettingsVC: UIViewController {
    
    //MARK: ~ properties
    var db: Firestore!
    @IBOutlet weak var uid: UILabel!
    @IBOutlet weak var emailadd: UILabel!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var destinations: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    //MARK: ~Actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        db = Firestore.firestore()
        //make profile view circular
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.black.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            //let email:String = user.email!
            db.collection("users").whereField("uid", isEqualTo: uid).getDocuments { (snapshot, error) in
                if error != nil {
                    print(error!)
                }else{
                    for document in (snapshot?.documents)! {
                        if let username = document.data()["username"] as? String {
                            if let email = document.data()["email"] as? String {
                                if let imageURL = document.data()["imageURL"] as? String {
                                    self.uid.text  = "Username: " + username
                                    self.emailadd.text = "Email address: " + email
                                    //get url from firestore and assign to profile pic
                                    let url = URL(string: imageURL)
                                    let data = try? Data(contentsOf: url!)
                                    
                                    if let imageData = data {
                                        let image = UIImage(data: imageData)
                                        self.profileImageView.image = image
                                    }
                                    
                                }
                            }
                        }
                    }
                }
            }
            db.collection("trips").whereField("uid", isEqualTo: uid).getDocuments { (snapshot, error) in
                if error != nil {
                    print(error?.localizedDescription as Any)
                }else{
                    for document in (snapshot?.documents)! {
                        if let destination = document.data()["destination"] as? String {
                            self.destinations.text = "Destination(s): " + destination
                        }
                    }
                }
            }
        }
    }
    
    
    

    @IBAction func returnButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
