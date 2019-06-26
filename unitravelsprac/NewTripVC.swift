//
//  NewTripVC.swift
//  
//
//  Created by Tiyari Harshita on 26/6/19.
//

import UIKit

class NewTripVC: UIViewController {

    @IBOutlet weak var `return`: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //MARK: Actions
    
    @IBAction func `return`(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
