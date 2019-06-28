//
//  AddItemVC.swift
//  unitravelsprac
//
//  Created by Park Ye Won on 27/6/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class AddItemVC: UIViewController {

    //MARK: Properties
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var numberOfPeople: UITextField!
    @IBOutlet weak var pricePerPerson: UILabel!
    
    @IBOutlet weak var tripper1Switch: UISwitch!
    @IBOutlet weak var tripper2Switch: UISwitch!
    @IBOutlet weak var tripper3Switch: UISwitch!
    @IBOutlet weak var tripper4Switch: UISwitch!
    
    @IBOutlet weak var payer1: UISwitch!
    @IBOutlet weak var payer2: UISwitch!
    @IBOutlet weak var payer3: UISwitch!
    @IBOutlet weak var payer4: UISwitch!
    
    //MARK: Actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        payer1.setOn(false, animated: true)
        payer2.setOn(false, animated: true)
        payer3.setOn(false, animated: true)
        payer4.setOn(false, animated: true)
        
    }
    
    @IBAction func perPerson(_ sender: Any) {
        //Double totPaid is the total amount of item to be added to Payer database
        var totalprice: Double = Double(price.text!) as! Double
        
        var num: Int = 0
        
        if tripper1Switch.isOn {
            num += 1
        }
        if tripper2Switch.isOn {
            num += 1
        }
        if tripper3Switch.isOn {
            num += 1
        }
        if tripper4Switch.isOn {
            num += 1
        }
        
        numberOfPeople.text = "\(num)"
        
        if let itemPrice =  Double(price.text!) {
            //Double perPax is the amount of money to be paid by each person sharing
            let perPax:Double = itemPrice / Double (num)
            pricePerPerson.text = "\(perPax)"
        } else {
            print("Please enter all details.")
        }
    }
   
    @IBAction func addTapped(_ sender: Any) {
        self.perPerson((Any).self)
        
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser!.uid
        
        let payees = ["a", "b"]
        
        let items = ItemModal.init(item: itemName.text!, price: Double(price.text!) as! Double, perperson: Double(pricePerPerson.text!) as! Double, payer: "tripper1", payees: payees)
        
        db.collection("trips").document(uid).collection("items").document().setData(items.dictionary) { err in
            var message: String = ""
            if err != nil {
                print("issue here at new trip info")
                message = "There was an error."
            }else{
                print("trip document was saved")
                message = "item successfully added!"
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
}
