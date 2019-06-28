//
//  File.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 26/6/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class NewTripVC: UIViewController {
    
    //MARK: ~Properties
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var DestinationTextField: UITextField!
    
    @IBOutlet weak var startDateTextField: UITextField!
    
    @IBOutlet weak var TrippersLabel: UILabel!
    
    @IBOutlet weak var tripper1TextField: UITextField!
    
    @IBOutlet weak var tripper2TextField: UITextField!
    
    @IBOutlet weak var tripper3TextField: UITextField!
    
    @IBOutlet weak var tripper4TextField: UITextField!
    
    //MARK: ~Actions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func createTapped(_ sender: Any) {
        
        let trippers = [
            "\(tripper1TextField.text!)" : 0.0,
             "\(tripper2TextField.text!)" : 0.0,
              "\(tripper3TextField.text!)" : 0.0,
               "\(tripper4TextField.text!)" : 0.0
        ]
        let database = Firestore.firestore()
        let uid = Auth.auth().currentUser!.uid
        let trip = TripModal(destination: DestinationTextField.text!, uid: uid, date: startDateTextField.text!, title: titleTextField.text!, payers: trippers, payees: trippers)
        
        let tripRef = database.collection("trips")
        
        tripRef.document(uid).setData(trip.dictionary){ err in
            var message: String = ""
            if err != nil {
                print("issue here at new trip info")
                message = "There was an error."
            }else{
                print("trip document was saved")
                message = "\(self.titleTextField.text!) successfully created!"
            }
            //alert for creation of new trip
            let alertController = UIAlertController(title: nil, message: message , preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.display(alertController: alertController)
        }
        
        //perform segue to go back to HomeVC
        //dismiss(animated: true, completion: nil)
    }
    
    func display(alertController: UIAlertController) {
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func returnTapped(_ sender: Any) {
        performSegue(withIdentifier: "goHomeFromNewTrip", sender: self)
    }
    
}
