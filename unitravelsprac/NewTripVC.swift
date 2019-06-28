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
        
        var names: Array<String> = Array()
        if tripper1TextField.text! != "tripper1" {
            names.append("\(tripper1TextField.text!)")
        }else{
            names.append("tripper1")
        }
        if tripper2TextField.text! != "tripper1" {
            names.append("\(tripper2TextField.text!)")
        }else{
            names.append("tripper2")
        }
        if tripper3TextField.text! != "tripper3" {
            names.append("\(tripper3TextField.text!)")
        }else{
            names.append("tripper3")
        }
        if tripper4TextField.text! != "tripper4" {
            names.append("\(tripper4TextField.text!)")
        }else{
            names.append("tripper4")
        }
        
        
        let trippers = [
            "\(names[0])" : 0.0,
            "\(names[1])" : 0.0,
            "\(names[2])" : 0.0,
            "\(names[3])" : 0.0
        ]
        let database = Firestore.firestore()
        let uid = Auth.auth().currentUser!.uid
        let trip = TripModal(destination: DestinationTextField.text!, uid: uid, date: startDateTextField.text!, title: titleTextField.text!, names: names, payers: trippers, payees: trippers)
        
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
