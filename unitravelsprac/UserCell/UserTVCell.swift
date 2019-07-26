//
//  UserTVCell.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 26/7/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import UIKit

class UserTVCell: UITableViewCell {
    
    //MARK: ~Properties
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var UsernameLabel: UILabel!
    //MARK: ~Actions

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func commonInit(_ imageName: String, title: String, sub: String) {
        profileImage.image = UIImage(named: imageName)
        UsernameLabel.text = title
        destinationLabel.text = sub
        
        
    }
    
}
