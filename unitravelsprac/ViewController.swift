//
//  ViewController.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 18/6/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var emailTextField: UITextField!


    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func goTapped(_ sender: Any) {
    }
    

    @IBAction func enterAsGuestTapped(_ sender: Any) {
    }

    @IBAction func signUpTapped(_ sender: Any) {
         performSegue(withIdentifier: "signUp", sender: self)
    }
}

