//
//  SignUpVC.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 18/6/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import TweeTextField
import PasswordTextField
import UIKit
import FirebaseFirestore
import FirebaseAuth
import Firebase

class SignUpVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //MARK: ~Properties
    var db:Firestore!
    var ref: DocumentReference? = nil
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameTextField: TweeAttributedTextField!
    @IBOutlet weak var emailTextField: TweeAttributedTextField!
    @IBOutlet weak var passwordTextField: PasswordTextField!
    @IBOutlet weak var confirmpwdTextField: PasswordTextField!
    
    //MARK: ~Action
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        //to make a circular profile pic view

        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true;
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.black.cgColor
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "adventure")!)
    }
    
    @IBAction func profileChangeTapped(_ sender: Any) {
        //user picks own image
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        image.allowsEditing = true
        
        self.present(image, animated: true)
        {
            //after it is complete
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImageView.image = image
        }else{
            //error
        }
        //image view controller can now hide after getting image?
        self.dismiss(animated: true, completion: nil)
    }
    
    func uploadProfileImage(_ image: UIImage, completion: @escaping ((_ url: String?)-> (Void))) {
        guard let uid = Auth.auth().currentUser?.uid else {return }
        let storageRef = Storage.storage().reference().child("user/\(uid)")
        
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storageRef.putData(imageData, metadata: metaData) { (metaData, error) in
            if error == nil , metaData != nil {
                storageRef.downloadURL{ (URL, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }else{
                        completion("\(URL!)")
                        print("url obtained")
                    }
                }
            }else{
                //failure
                print("failure in storing")
                completion(nil)
            }
        }
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        let signUpManager = FirebaseAuthManager()
        if let email = emailTextField.text, let password = passwordTextField.text, let confirmpwd = confirmpwdTextField.text, let username = usernameTextField.text{
            
            signUpManager.createUser(email: email, password: password, confirmpwd: confirmpwd) {[weak self] (success) in
                guard let `self` = self else { return }
                var message: String = ""
                if (success) {
                    guard let uid = Auth.auth().currentUser?.uid else {return}
                    
                    
                    message = "User was sucessfully created."
                   
                    //info to be stored in firestore with  email, uid, username and password
                    let user = UserModal(email: email, uid: uid ,username: username, password: password)
                    let userRef = self.db.collection("users").document(uid)
                    
                    userRef.setData(user.dictionary){ err in
                        if err != nil {
                            print("issue here")
                        }else{
                            print("Document was saved")
                        }
                    }
                    //upload profile pic in storage and get url
                    self.uploadProfileImage(self.profileImageView.image!, completion: { (url) in
                        //add url data as well
                        userRef.setData(["imageURL": url], merge: true)
                    })
                    
                }else{
                    message = "There was an error."
                }
                
                //alert for registration
                let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.display(alertController: alertController)
                
            }
        }
    }
    
    func display(alertController: UIAlertController) {
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func returnTapped(_ sender: Any) {
        performSegue(withIdentifier: "returnToLogin", sender: self)
    }
}

