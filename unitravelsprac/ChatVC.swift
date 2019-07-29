//
//  ChatVC.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 29/7/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    //MARK: ~Properties
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var chattingWith: String = ""

    //MARK: ~Actions
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.topItem?.title = chattingWith
        

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
