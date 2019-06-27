//
//  AddItemVC.swift
//  unitravelsprac
//
//  Created by Park Ye Won on 27/6/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import UIKit

class AddItemVC: UIViewController {

    //MARK: Properties
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var numberOfPeople: UITextField!
    @IBOutlet weak var pricePerPerson: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: Actions

    @IBAction func perPerson(_ sender: Any) {
        if let itemPrice =  Double(price.text!),
        let n = Double(numberOfPeople.text!) {
            let perPax:Double = itemPrice / n
            pricePerPerson.text = "\(perPax)"
        } else {
            print("Please enter all details.")
        }
        
        
    }
    

}
