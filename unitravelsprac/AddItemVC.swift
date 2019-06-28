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
     var db: Firestore!
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
    
    
    @IBOutlet weak var payer1Name: UILabel!
    @IBOutlet weak var payer2Name: UILabel!
    @IBOutlet weak var payer3Name: UILabel!
    @IBOutlet weak var payer4Name: UILabel!
    
    @IBOutlet weak var tripper1Name: UILabel!
    @IBOutlet weak var tripper2Name: UILabel!
    @IBOutlet weak var tripper3Name: UILabel!
    @IBOutlet weak var tripper4Name: UILabel!
    //MARK: Actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        payer1.setOn(false, animated: true)
        payer2.setOn(false, animated: true)
        payer3.setOn(false, animated: true)
        payer4.setOn(false, animated: true)
        
        db = Firestore.firestore()
        let uid = Auth.auth().currentUser!.uid
        db.collection("trips").whereField("uid", isEqualTo: uid).getDocuments { (snapshot, error) in
            if error != nil {
                print(error!)
            }else{
                for document in (snapshot?.documents)! {
                    if let names = document.data()["names"] as? Array<String> {
                        self.tripper1Name.text!  = names[0]
                        self.payer1Name.text! = names[0]
                        
                        self.tripper2Name.text!  = names[1]
                        self.payer2Name.text! = names[1]
                        
                        self.tripper3Name.text!  = names[2]
                        self.payer3Name.text! = names[2]
                        
                        self.tripper4Name.text!  = names[3]
                        self.payer4Name.text! = names[3]
                        
                    }
                }
            }
        }
        
    }
    
    @IBAction func perPerson(_ sender: Any) {
        //Double totPaid is the total amount of item to be added to Payer database
        let totalprice: Double = Double(price.text!) as! Double
        
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
        let totalprice: Double = Double(price.text!) as! Double
        let costPerPerson: Double = Double(pricePerPerson.text!) as! Double
        var payer:String = ""
        
        if payer1.isOn {
            payer = payer1Name.text!
        }
        else if payer2.isOn {
            payer = payer2Name.text!
        }
        else if payer3.isOn {
            payer = payer3Name.text!
        }
        else if payer4.isOn {
            payer = payer4Name.text!
        }
        
        //querying current payer summary and updating payer details in "trips" collection
        db.collection("trips").whereField("uid", isEqualTo: uid).getDocuments { (snapshot, error) in
            if error != nil {
                print(error!)
            }else{
                for document in (snapshot?.documents)! {
                    if let payers = document.data()["payers"] as? [String:Double] {
                        var currPayerAmt: Double = payers[payer]!
                        currPayerAmt += totalprice
                        
                        //update in firestore
                        let document = snapshot!.documents.first
                        document!.reference.updateData([
                            "payers.\(payer)": currPayerAmt
                            ])
                    }
                }
            }
        }
        
        
        // getting names of payees, storing in array, updating in "trips" collection
        var payeesArr: Array<String> = Array()
        if tripper1Switch.isOn {
            payeesArr.append(tripper1Name.text!)
        }
        if tripper2Switch.isOn {
            payeesArr.append(tripper2Name.text!)
        }
        if tripper3Switch.isOn {
            payeesArr.append(tripper3Name.text!)
        }
        if tripper4Switch.isOn {
            payeesArr.append(tripper4Name.text!)
        }
        
        db.collection("trips").whereField("uid", isEqualTo: uid).getDocuments { (snapshot, error) in
            if error != nil {
                print(error!)
            }else{
                for document in (snapshot?.documents)! {
                    if let payeesMap = document.data()["payees"] as? [String:Double] {
                        
                        //loop through all payees and update in firestore
                        for index in 0...(payeesArr.count-1) {
                            let payee = payeesArr[index]
                            var newDebt: Double = payeesMap[payee]!
                            newDebt -= costPerPerson
                            //update in firestore
                            let document = snapshot!.documents.first
                            document!.reference.updateData([
                                "payees.\(payee)": newDebt
                                ])
                        }
                        
                        
                    }
                }
                
            }
        }
        
        
        
        
        // setting item document
        let items = ItemModal.init(item: itemName.text!, price: totalprice, perperson: costPerPerson, payer: payer, payees: payeesArr, uid: uid)
        
        db.collection("trips").document(uid).collection("items").document().setData(items.dictionary) { err in
            var message: String = ""
            if err != nil {
                print("issue here at new items info")
                message = "There was an error."
            }else{
                print("item document was saved")
                message = "\(self.itemName.text!) successfully added!"
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
