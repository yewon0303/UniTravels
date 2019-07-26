//
//  FriendTVCell.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 27/7/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import UIKit

protocol FriendTableView {
    func onClickCell(index: Int)
}

class FriendTVCell: UITableViewCell {
    
    //MARK: Properties
    var cellDelegate: FriendTableView?
    var index: IndexPath?
    
    @IBOutlet weak var labelName: UILabel!
    
    
    //MARK: Actions
    
    @IBAction func deleteTapped(_ sender: Any) {
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
