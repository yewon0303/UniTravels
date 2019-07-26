//
//  RequestTVCell.swift
//  unitravelsprac
//
//  Created by Tiyari Harshita on 26/7/19.
//  Copyright © 2019 Tiyari Harshita. All rights reserved.
//

import UIKit

protocol RequestTableView {
    func onClickCell(index: Int)
}

class RequestTVCell: UITableViewCell {
    
    //MARK: Properties
    var cellDelegate: RequestTableView?
    var index: IndexPath?
    
    
    @IBOutlet weak var labelName: UILabel!
    
    //MARK: Actions
    
    @IBAction func addTapped(_ sender: Any) {
        cellDelegate?.onClickCell(index: (index?.row)!)
    }
    
    
    @IBAction func deleteTapped(_ sender: Any) {
        //cellDelegate?.onClickCell(index: (index?.row)!, add: false)
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
