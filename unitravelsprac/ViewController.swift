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
    
    //MARK: ~properties

    @IBOutlet weak var emailTextField: UITextField!


    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: ~actions
    @IBAction func goTapped(_ sender: Any) {
    }
    

    @IBAction func enterAsGuestTapped(_ sender: Any) {
         performSegue(withIdentifier: "goHomeThroughGuest", sender: self)
    }

    @IBAction func signUpTapped(_ sender: Any) {
         performSegue(withIdentifier: "signUp", sender: self)
    }
}

