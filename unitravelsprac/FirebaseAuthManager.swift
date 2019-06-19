//
//  FirebaseAuthManager.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 18/6/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//


import UIKit
import FirebaseAuth

class FirebaseAuthManager {
    
    func login(credential: AuthCredential, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(with: credential, completion: { (firebaseUser, error) in
            print(firebaseUser as Any)
            completionBlock(error == nil)
        })
    }
    
    func createUser(email: String, password: String, confirmpwd: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                print(user)
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
    
    func signIn(email: String, pass: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
    }
    
}
