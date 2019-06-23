//
//  SettingsVC.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 23/6/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import Foundation
import UIKit

class SettingsVC: UIViewController {
    
    //MARK: ~ properties
    
    @IBOutlet weak var profileTextView: UITextView!
    
    //MARK: ~Actions
    
    @IBAction func returnTapped(_ sender: Any) {
         performSegue(withIdentifier: "goHomeFromSettings", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
