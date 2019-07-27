//
//  ViewController.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 18/6/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import TweeTextField
import PasswordTextField
import UIKit
import Splitflap

class ViewController: UIViewController, SplitflapDataSource, SplitflapDelegate {
    
    //MARK: ~properties
    
    @IBOutlet weak var emailTextField: TweeAttributedTextField!
    @IBOutlet weak var passwordTextField: PasswordTextField!

    let splitflapView = Splitflap(frame: CGRect(x: 35, y: 120, width: 350, height: 50))
    
    func textFieldShouldReturn(textField: TweeAttributedTextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitflapView.datasource = self
        splitflapView.delegate = self
        
        view.addSubview(splitflapView)
        splitflapView.reload()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "adventure")!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Set the text to display by animating the flaps
        splitflapView.setText("UniTravels", animated: true)
    }
    
    // Defines the number of flaps that will be used to display the text
    func numberOfFlapsInSplitflap(_ splitflap: Splitflap) -> Int {
        return 10
    }
    
    //MARK: ~actions
    func splitflap(_ splitflap: Splitflap, rotationDurationForFlapAtIndex index: Int) -> Double {
        return 0.1
    }
    
    @IBAction func goTapped(_ sender: Any) {
        let loginManager = FirebaseAuthManager()
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        loginManager.signIn(email: email, pass: password) {[weak self] (success) in
            guard let `self` = self else { return }
            if (success) {
                self.afterSuccessfulLogin()
            } else {
                let alertController = UIAlertController(title: nil, message: "There was an error.", preferredStyle: .alert)
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

