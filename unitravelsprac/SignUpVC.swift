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
    }
    
    @IBAction func returnTapped(_ sender: Any) {
        performSegue(withIdentifier: "returnToLogin", sender: self)
    }
}

