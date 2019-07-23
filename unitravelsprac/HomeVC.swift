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
    @IBOutlet weak var create_new: UIImageView!
    @IBOutlet weak var gallery: UIImageView!
    @IBOutlet weak var folder: UIImageView!
    @IBOutlet weak var face_ID: UIImageView!
    
    //MARK: ~Actions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "forest")!)
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
}
