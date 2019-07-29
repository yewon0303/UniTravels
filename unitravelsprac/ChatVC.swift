//
//  ChatVC.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 29/7/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import FirebaseAuth

class ChatVC: JSQMessagesViewController {
    
    //MARK: ~Properties
    

    
    var chattingWith: String = ""

    //MARK: ~Actions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        senderId = Auth.auth().currentUser?.uid
        senderDisplayName = "user"
        

        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func returnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    

}
