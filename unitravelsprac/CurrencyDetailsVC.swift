//
//  CurrencyDetailsVC.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 24/7/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import UIKit

class CurrencyDetailsVC: UIViewController {
    
    //MARK: ~Properties
    @IBOutlet weak var currencyTextView: UITextView!
    
    //MARK: ~Actions

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func returnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
