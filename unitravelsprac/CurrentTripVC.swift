//
//  CurrentTripVC.swift
//  unitravelsprac
//
//  Created by Park Ye Won on 28/6/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import UIKit

class CurrentTripVC: UIViewController {

    //MARK: Properties
    @IBOutlet weak var addItem: UIButton!
    @IBOutlet weak var tripper1: UILabel!
    @IBOutlet weak var tripper2: UILabel!
    @IBOutlet weak var tripper3: UILabel!
    @IBOutlet weak var tripper4: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //load the budget from database and display
    }
    
    //MARK: Actions
    @IBAction func addItemView(_ sender: Any) {
        performSegue(withIdentifier: "addItemView", sender: self)
    }
    
    

}
