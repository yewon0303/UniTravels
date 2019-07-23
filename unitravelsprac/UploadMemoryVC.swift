//
//  UploadMemoryVC.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 13/7/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class UploadMemoryVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //MARK: ~Properties
    
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var myImageView: UIImageView!
    
    var db:Firestore!
    
     private var datePicker: UIDatePicker?
    
    //MARK: ~Actions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        db = Firestore.firestore()
        
        //code for date picker to appear
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UploadMemoryVC.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        inputTextField.inputView = datePicker
    }
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
        
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short   // You can also use Long, Medium and No style.
        dateFormatter.timeStyle = DateFormatter.Style.short
        inputTextField.text = dateFormatter.string(from: datePicker.date)
        
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func selectTapped(_ sender: Any) {
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
            myImageView.image = image
        }else{
            //error
            print("error uploading photo")
        }
        //image view controller can now hide after getting image?
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func uploadTapped(_ sender: Any) {
        //info to be stored in firestore with  photo url under memory subcollection under trip collection
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let image = myImageView.image else {return}
        //upload profile pic in storage and get url and add url data into firestore
        self.uploadProfileImage(image, completion: { (url) in
            self.db.collection("trips").document(uid).collection("memories").document().setData(["memoryURL": url as Any, "uid": uid, "timestamp": self.inputTextField.text ]) { err in
                var message: String = ""
                if err != nil {
                    print("issue here at new items info")
                    message = "There was an error."
                }else{
                    print("item document was saved")
                    message = "memory successfully added!"
                }
                //alert for creation of new trip
                let alertController = UIAlertController(title: nil, message: message , preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.display(alertController: alertController)
            }

        })
    }
    
    func display(alertController: UIAlertController) {
        self.present(alertController, animated: true, completion: nil)
    }
    
    func uploadProfileImage(_ image: UIImage, completion: @escaping ((_ url: String?)-> (Void))) {
        guard let uid = Auth.auth().currentUser?.uid else {return }
        
        //use date as path for storage
        guard let inputDate = self.inputTextField.text else {return}
        let storageRef = Storage.storage().reference().child("memories/users/\(uid)\(inputDate)")
        
        //image data and metadata
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        //store image data in storage and download url 
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
    
    
    @IBAction func returnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
