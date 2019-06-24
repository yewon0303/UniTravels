//
//  ViewController.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 18/6/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: ~properties

    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: ~actions
    @IBAction func goTapped(_ sender: Any) {
        let loginManager = FirebaseAuthManager()
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        loginManager.signIn(email: email, pass: password) {[weak self] (success) in
            guard let `self` = self else { return }
            var message: String = ""
            if (success) {
                self.afterSuccessfulLogin()
                message = "User was sucessfully logged in."
            } else {
                message = "There was an error."
                let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.display(alertController: alertController)
            }
            
            
        }
    }
    func afterSuccessfulLogin() {
        performSegue(withIdentifier: "goHome", sender: self)
        guard  let email = emailTextField.text else {return}
        print("\(email) has logged in!")
    }
    
    func display(alertController: UIAlertController) {
        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func enterAsGuestTapped(_ sender: Any) {
         performSegue(withIdentifier: "goHome", sender: self)
    }

    @IBAction func signUpTapped(_ sender: Any) {
         performSegue(withIdentifier: "signUp", sender: self)
    }
}

