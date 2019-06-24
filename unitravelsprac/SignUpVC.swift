//
//  SignUpVC.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 18/6/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class SignUpVC: UIViewController {
    
    //MARK: ~Properties
    var db:Firestore!
    
    var ref: DocumentReference? = nil
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var confirmpwdTextField: UITextField!
    
    //MARK: ~Action
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        db = Firestore.firestore()
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        let signUpManager = FirebaseAuthManager()
        if let email = emailTextField.text, let password = passwordTextField.text, let confirmpwd = confirmpwdTextField.text, let username = usernameTextField.text{
            
            signUpManager.createUser(email: email, password: password, confirmpwd: confirmpwd) {[weak self] (success) in
                guard let `self` = self else { return }
                var message: String = ""
                if (success) {
                    message = "User was sucessfully created."
                    
                    //info to be stored in firestore with  email, uid, username and password
                    let user = UserModal(email: email, uid: (Auth.auth().currentUser!.uid) ,username: username, password: password)
                    let userRef = self.db.collection("users")
                    
                    userRef.document().setData(user.dictionary){ err in
                        if err != nil {
                            print("issue here")
                        }else{
                            print("Document was saved")
                        }
                    }
                }else{
                    message = "There was an error."
                }
                
                //alert for registration
                let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.display(alertController: alertController)
                
            }
        }
    }
    
    func display(alertController: UIAlertController) {
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func returnTapped(_ sender: Any) {
        performSegue(withIdentifier: "returnToLogin", sender: self)
    }
}

