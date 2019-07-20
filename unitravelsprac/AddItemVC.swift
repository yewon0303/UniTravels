//
//  AddItemVC.swift
//  unitravelsprac
//
//  Created by Park Ye Won on 27/6/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import BEMCheckBox
import UIKit
import FirebaseFirestore
import FirebaseAuth

class AddItemVC: UIViewController {

    //MARK: Properties
     var db: Firestore!
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var numberOfPeople: UILabel!
    @IBOutlet weak var pricePerPerson: UILabel!
    
    //Payer (select 1)
    
    @IBOutlet weak var payer1Name: UILabel!
    @IBOutlet weak var payer2Name: UILabel!
    @IBOutlet weak var payer3Name: UILabel!
    @IBOutlet weak var payer4Name: UILabel!
    @IBOutlet weak var payer5Name: UILabel!
    @IBOutlet weak var payer6Name: UILabel!
    
    @IBOutlet weak var payer1: BEMCheckBox!
    @IBOutlet weak var payer2: BEMCheckBox!
    @IBOutlet weak var payer3: BEMCheckBox!
    @IBOutlet weak var payer4: BEMCheckBox!
    @IBOutlet weak var payer5: BEMCheckBox!
    @IBOutlet weak var payer6: BEMCheckBox!
    
    //Trippers sharing this item
    @IBOutlet weak var tripper1Name: UILabel!
    @IBOutlet weak var tripper2Name: UILabel!
    @IBOutlet weak var tripper3Name: UILabel!
    @IBOutlet weak var tripper4Name: UILabel!
    @IBOutlet weak var tripper5Name: UILabel!
    @IBOutlet weak var tripper6Name: UILabel!
    
    @IBOutlet weak var tripper1Switch: BEMCheckBox!
    @IBOutlet weak var tripper2Switch: BEMCheckBox!
    @IBOutlet weak var tripper3Switch: BEMCheckBox!
    @IBOutlet weak var tripper4Switch: BEMCheckBox!
    @IBOutlet weak var tripper5Switch: BEMCheckBox!
    @IBOutlet weak var tripper6Switch: BEMCheckBox!
    
    //MARK: Actions
    override func viewDidLoad() {
        super.viewDidLoad()
        payer1.setOn(false, animated: true)
        payer2.setOn(false, animated: true)
        payer3.setOn(false, animated: true)
        payer4.setOn(false, animated: true)
        payer5.setOn(false, animated: true)
        payer6.setOn(false, animated: true)
        
        db = Firestore.firestore()
        let uid = Auth.auth().currentUser!.uid
        db.collection("trips").whereField("uid", isEqualTo: uid).getDocuments {
            (snapshot, error) in
            if error != nil {
                print(error!)
            } else {
                for document in (snapshot?.documents)! {
                    if let names = document.data()["names"] as? Array<String> {
                        if (document.data()["tripper1On"] as! Bool) {
                            self.tripper1Name.text!  = names[0]
                            self.payer1Name.text! = names[0]
                        } else {
                            self.tripper1Name.isHidden = true
                            self.payer1.isHidden = true
                            self.payer1Name.isHidden = true
                            self.tripper1Switch.setOn(false, animated: true)
                            self.tripper1Switch.isHidden = true
                        }
                        
                        if (document.data()["tripper2On"] as! Bool) {
                            self.tripper2Name.text!  = names[1]
                            self.payer2Name.text! = names[1]
                        } else {
                            self.tripper2Name.isHidden = true
                            self.payer2.isHidden = true
                            self.payer2Name.isHidden = true
                            self.tripper2Switch.setOn(false, animated: true)
                            self.tripper2Switch.isHidden = true
                        }
                        
                        if (document.data()["tripper3On"] as! Bool) {
                            self.tripper3Name.text!  = names[2]
                            self.payer3Name.text! = names[2]
                        } else {
                            self.tripper3Name.isHidden = true
                            self.payer3.isHidden = true
                            self.payer3Name.isHidden = true
                            self.tripper3Switch.setOn(false, animated: true)
                            self.tripper3Switch.isHidden = true
                        }
                        
                        if (document.data()["tripper4On"] as! Bool) {
                            self.tripper4Name.text!  = names[3]
                            self.payer4Name.text! = names[3]
                        } else {
                            self.tripper4Name.isHidden = true
                            self.payer4.isHidden = true
                            self.payer4Name.isHidden = true
                            self.tripper4Switch.setOn(false, animated: true)
                            self.tripper4Switch.isHidden = true
                        }
                        
                        if (document.data()["tripper5On"] as! Bool) {
                            self.tripper5Name.text!  = names[4]
                            self.payer5Name.text! = names[4]
                        } else {
                            self.tripper5Name.isHidden = true
                            self.payer5.isHidden = true
                            self.payer5Name.isHidden = true
                            self.tripper5Switch.setOn(false, animated: true)
                            self.tripper5Switch.isHidden = true
                        }
                        
                        if (document.data()["tripper6On"] as! Bool) {
                            self.tripper6Name.text!  = names[5]
                            self.payer6Name.text! = names[5]
                        } else {
                            self.tripper6Name.isHidden = true
                            self.payer6.isHidden = true
                            self.payer6Name.isHidden = true
                            self.tripper6Switch.setOn(false, animated: true)
                            self.tripper6Switch.isHidden = true
                        }
                    }
                }
            }
        }
        
    }
    
    @IBAction func perPerson(_ sender: Any) {
        //Double totPaid is the total amount of item to be added to Payer database
        let totalprice: Double = Double(price.text!) as? Double ?? 0.0
        
        var num: Int = 0
        
        if tripper1Switch.on == true {
            num += 1
        }
        if tripper2Switch.on == true {
            num += 1
        }
        if tripper3Switch.on == true {
            num += 1
        }
        if tripper4Switch.on == true {
            num += 1
        }
        if tripper5Switch.on == true {
            num += 1
        }
        if tripper6Switch.on == true {
            num += 1
        }
        
        numberOfPeople.text = "\(num) Trippers"
        
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
        let totalprice: Double = Double(price.text!) as? Double ?? 0.0
        let costPerPerson: Double = Double(pricePerPerson.text!) as? Double ?? 0.0
        var payer:String = ""
        
        if payer1.on == true {
            payer = payer1Name.text!
        } else if payer2.on == true {
            payer = payer2Name.text!
        } else if payer3.on == true {
            payer = payer3Name.text!
        } else if payer4.on == true {
            payer = payer4Name.text!
        } else if payer5.on == true {
            payer = payer5Name.text!
        } else if payer6.on == true {
            payer = payer6Name.text!
        }
        
        //querying current payer summary and updating payer details in "trips" collection
        db.collection("trips").whereField("uid", isEqualTo: uid).getDocuments { (snapshot, error) in
            if error != nil {
                print(error!)
            }else{
                for document in (snapshot?.documents)! {
                    if let payers = document.data()["payers"] as? [String:Double] {
                        if let total = document.data()["total"] as? Double {
                            var currPayerAmt: Double = payers[payer] ?? 0.0
                        currPayerAmt += totalprice
                        var newtotal = total + totalprice
                        
                            //update in firestore
                        let document = snapshot!.documents.first
                        document!.reference.updateData([
                            "payers.\(payer)": currPayerAmt,
                            "total": newtotal
                            ])
                        }
                    }
                }
            }
        }
        
        
        // getting names of payees, storing in array, updating in "trips" collection
        var payeesArr: Array<String> = Array()
        if tripper1Switch.on == true {
            payeesArr.append(tripper1Name.text!)
        }
        if tripper2Switch.on == true {
            payeesArr.append(tripper2Name.text!)
        }
        if tripper3Switch.on == true {
            payeesArr.append(tripper3Name.text!)
        }
        if tripper4Switch.on == true {
            payeesArr.append(tripper4Name.text!)
        }
        if tripper5Switch.on == true {
            payeesArr.append(tripper5Name.text!)
        }
        if tripper6Switch.on == true {
            payeesArr.append(tripper6Name.text!)
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
        //adding new item under items subcollection under trips collection
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
