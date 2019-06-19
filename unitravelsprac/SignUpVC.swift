//
//  SignUpVC.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 18/6/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //MARK: ~Properties
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var confirmpwdTextField: UITextField!
    
    //MARK: ~Action
    
    @IBAction func registerTapped(_ sender: Any) {
        let signUpManager = FirebaseAuthManager()
        if let email = emailTextField.text, let password = passwordTextField.text, let confirmpwd = confirmpwdTextField.text {
            signUpManager.createUser(email: email, password: password, confirmpwd: confirmpwd) {[weak self] (success) in
                guard let `self` = self else { return }
                var message: String = ""
                if (success) {
                    message = "User was sucessfully created."
                }else{
                    message = "There was an error."
                }
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

