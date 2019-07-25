//
//  HomeVC.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 18/6/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    //MARK: ~Properties
    @IBOutlet weak var newTrip: UIButton!
    @IBOutlet weak var currentTrip: UIButton!
    @IBOutlet weak var pastTrips: UIButton!
    @IBOutlet weak var setting: UIButton!
    
    
    //MARK: ~Actions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newTrip.layer.borderWidth = 1.0
        currentTrip.layer.borderWidth = 1.0
        pastTrips.layer.borderWidth = 1.0
        setting.layer.borderWidth = 1.0
        
        newTrip.layer.borderColor = UIColor.white.cgColor
        currentTrip.layer.borderColor = UIColor.white.cgColor
        pastTrips.layer.borderColor = UIColor.white.cgColor
        setting.layer.borderColor = UIColor.white.cgColor
        
        newTrip.layer.shadowOffset = CGSize(width:50, height: 10)
        currentTrip.layer.shadowOffset = CGSize(width:10, height: 1)
        pastTrips.layer.shadowOffset = CGSize(width:10, height: 1)
        setting.layer.shadowOffset = CGSize(width:10, height: 1)
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "mountainpic")!)
    }
    
    @IBAction func newTripTapped(_ sender: Any) {
       performSegue(withIdentifier: "newTrip", sender: self)
    }
    
    @IBAction func currentTripTapped(_ sender: Any) {
        performSegue(withIdentifier: "currentTrip", sender: self)
    }
    @IBAction func pastTripTapped(_ sender: Any) {
        performSegue(withIdentifier: "pastTrip", sender: self)
    }

    @IBAction func settingTapped(_ sender: Any) {
        performSegue(withIdentifier: "settings", sender: self)
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        let signOutManager = FirebaseAuthManager()
        signOutManager.signOut() {[weak self] (success) in
            guard let `self` = self else { return }
            var message: String = ""
            if (success) {
                self.afterLogOut()
                message = "User was sucessfully logged out."
            }else{
                message = "There was an error."
                //alert for logout
                let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.display(alertController: alertController)
            }
            
        }
    }
    
    func afterLogOut() {
        performSegue(withIdentifier: "signedOut", sender: self)
    }
    
    func display(alertController: UIAlertController) {
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func menuTapped(_ sender: Any) {
        performSegue(withIdentifier: "friends", sender: self)
    }
}
