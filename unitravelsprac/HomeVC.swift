//
//  HomeVC.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 18/6/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import UIKit
import AZExpandableIconListView

class HomeVC: UIViewController {
    //MARK: ~Properties
    
    @IBOutlet weak var newTrip: UIButton!
    @IBOutlet weak var currentTrip: UIButton!
    @IBOutlet weak var pastTrips: UIButton!
    @IBOutlet weak var settings: UIButton!
    
    @IBOutlet weak var create_new: UIImageView!
    @IBOutlet weak var gallery: UIImageView!
    @IBOutlet weak var folder: UIImageView!
    @IBOutlet weak var face_ID: UIImageView!

    
    //MARK: ~Actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        create_new.isHidden = true
        gallery.isHidden = true
        folder.isHidden = true
        face_ID.isHidden = true
        
        newTrip.isHidden = true
        currentTrip.isHidden = true
        pastTrips.isHidden = true
        settings.isHidden = true
        
        let create_new_img: UIImage = self.create_new.image!
        let gallery_img: UIImage = self.gallery.image!
        let folder_img: UIImage = self.folder.image!
        let face_ID_img: UIImage = self.face_ID.image!
        
        let expandableFirstRow = AZExpandableIconListView(frame: CGRect(x: 60, y: 420, width: UIScreen.main.bounds.size.width - 20, height: 130), images: [create_new_img, gallery_img])
        view.addSubview(expandableFirstRow)
        
        let expandable = AZExpandableIconListView(frame: CGRect(x: 60, y: 630, width: UIScreen.main.bounds.size.width - 20, height: 130), images: [folder_img, face_ID_img])
        view.addSubview(expandable)
        
        expandableFirstRow.imageSpacing = 100
        expandable.imageSpacing = 100
        
        expandableFirstRow.onExpanded = {
            self.newTrip.isHidden = false
            self.currentTrip.isHidden = false
        }
        
        expandable.onExpanded = {
            self.pastTrips.isHidden = false
            self.settings.isHidden = false
        }
        
        expandableFirstRow.onCollapsed = {
            self.newTrip.isHidden = true
            self.currentTrip.isHidden = true
        }
        
        expandable.onCollapsed = {
            self.pastTrips.isHidden = true
            self.settings.isHidden = true
        }
    }
    
    @IBAction func newTripTapped(_ sender: Any) {
       performSegue(withIdentifier: "newTrip", sender: self)
    }
    
    @IBAction func currentTripTapped(_ sender: Any) {
        performSegue(withIdentifier: "currentTrip", sender: self)
    }
    @IBAction func pastTripTapped(_ sender: Any) {
    }

    @IBAction func settingTapped(_ sender: Any) {
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
