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
    
    
    //MARK: ~Actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func returnTapped(_ sender: Any) {
        performSegue(withIdentifier: "goHomeFromNewTrip", sender: self)
    }
}
