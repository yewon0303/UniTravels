//
//  UserTVCell.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 26/7/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import UIKit

protocol UserTableView {
    func onClickCell(index: Int)
}

class UserTVCell: UITableViewCell {
    
    //MARK: Properties
    var cellDelegate: UserTableView?
    var index: IndexPath?
   
    @IBOutlet weak var labelName: UILabel!
    
    //MARK: Actions
    
    @IBAction func addTapped(_ sender: Any) {
        cellDelegate?.onClickCell(index: (index?.row)!)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
