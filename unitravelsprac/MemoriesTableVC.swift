//
//  MemoriesTableVC.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 1/7/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class MemoriesTableVC: UITableViewController {
    
    //MARK: ~ Properties
    var db:Firestore!
    var imagesArray = [UIImage?]()
    
    //MARK: ~Actions
    
    @IBAction func uploadTapped(_ sender: Any) {
        performSegue(withIdentifier: "uploadPhoto", sender: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NSLog("viewDidAppear is running in current view")
        //TO clear array
        imagesArray = [UIImage?]()
        loadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        self.tableView.register(ImageTVCell.self, forCellReuseIdentifier: "ImageViewCell")
        //init database
        db = Firestore.firestore()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //dispose of any resources that can be recreated
    }
    
    func loadData() {
        let uid = (Auth.auth().currentUser?.uid)!
        db.collection("trips").document(uid).collection("memories").whereField("uid", isEqualTo:uid).getDocuments() { (snapshot, error) in
            
            if let error = error {
                
                print(error.localizedDescription)
                
            } else {
                
                if let snapshot = snapshot {
                    
                    for document in snapshot.documents {
                        let docData = document.data()
                        let memoryURL = docData["memoryURL"] as? String ?? ""
                        
                        //add to image array after getting url from firestore
                        let url = URL(string: memoryURL)
                        let data = try? Data(contentsOf: url!)
                        
                        
                        if let imageData = data {
                            let newMemory = UIImage(data: imageData)
                            self.imagesArray.append(newMemory)
                        }
                        
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageViewCell") as! ImageTVCell
        
        cell.mainImageView.image = imagesArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentImage = imagesArray[indexPath.row]
        let imageCrop = currentImage!.getCropRatio()
        return tableView.frame.width / imageCrop
    }
    
}

extension UIImage {
    func getCropRatio() -> CGFloat {
        let widthRatio = self.size.width / self.size.height
        return widthRatio
    }
}
