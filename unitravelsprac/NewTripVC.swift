//
//  File.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 26/6/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import BEMCheckBox
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
    @IBOutlet weak var tripper5TextField: UITextField!
    @IBOutlet weak var tripper6TextField: UITextField!
    
    @IBOutlet weak var tripper1Switch: BEMCheckBox!
    @IBOutlet weak var tripper2Switch: BEMCheckBox!
    @IBOutlet weak var tripper3Switch: BEMCheckBox!
    @IBOutlet weak var tripper4Switch: BEMCheckBox!
    @IBOutlet weak var tripper5Switch: BEMCheckBox!
    @IBOutlet weak var tripper6Switch: BEMCheckBox!
    
    
    //MARK: ~Actions
    override func viewDidLoad() {
        super.viewDidLoad()
      tripper1Switch.setOn(true, animated: true)
        tripper2Switch.setOn(false, animated: true)
        tripper3Switch.setOn(false, animated: true)
        tripper4Switch.setOn(false, animated: true)
        tripper5Switch.setOn(false, animated: true)
        tripper6Switch.setOn(false, animated: true)
        
    }
    
    var numTrippers:Int = 0
    
    @IBAction func createTapped(_ sender: Any) {
        
        var names: Array<String> = Array()
        if tripper1Switch.on == true {
            numTrippers += 1
            names.append("\(tripper1TextField.text!)")
        }else{
            names.append("tripper1")
        }
        
        if tripper2Switch.on == true {
            numTrippers += 1
            names.append("\(tripper2TextField.text!)")
        }else{
            names.append("tripper2")
        }
        
        if tripper3Switch.on == true {
            numTrippers += 1
            names.append("\(tripper3TextField.text!)")
        }else{
            names.append("tripper3")
        }
        
        if tripper4Switch.on == true {
            numTrippers += 1
            names.append("\(tripper4TextField.text!)")
        }else{
            names.append("tripper4")
        }
        
        if tripper5Switch.on == true {
            numTrippers += 1
            names.append("\(tripper5TextField.text!)")
        }else{
            names.append("tripper5")
        }
        
        if tripper6Switch.on == true {
            numTrippers += 1
            names.append("\(tripper6TextField.text!)")
        }else{
            names.append("tripper6")
        }
        
        
        let trippers = [
            "\(names[0])" : 0.0,
            "\(names[1])" : 0.0,
            "\(names[2])" : 0.0,
            "\(names[3])" : 0.0,
            "\(names[4])" : 0.0,
            "\(names[5])" : 0.0
        ]
        let database = Firestore.firestore()
        let uid = Auth.auth().currentUser!.uid
        
        let trip = TripModal(destination: DestinationTextField.text!,
                             uid: uid,
                             date: startDateTextField.text!,
                             title: titleTextField.text!,
                             names: names,
                             payers: trippers,
                             payees: trippers,
                             total: 0.0,
                             tripper1On: tripper1Switch.on,
                             tripper2On:tripper2Switch.on,
                             tripper3On: tripper3Switch.on,
                             tripper4On: tripper4Switch.on,
                             tripper5On: tripper5Switch.on,
                             tripper6On: tripper6Switch.on)
        
        let tripRef = database.collection("trips")
        
        tripRef.document(uid).setData(trip.dictionary){ err in
            var message: String = ""
            if err != nil {
                print("issue here at new trip info")
                message = "There was an error."
            }else{
                print("trip document was saved")
                message = "\(self.titleTextField.text!) with \(self.numTrippers) Trippers successfully created!"
                
            }
            //alert for creation of new trip
            let alertController = UIAlertController(title: nil, message: message , preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.display(alertController: alertController)
        }
    }
    
    
    func display(alertController: UIAlertController) {
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func returnTapped(_ sender: Any) {
        performSegue(withIdentifier: "goHomeFromNewTrip", sender: self)
    }
    
}
