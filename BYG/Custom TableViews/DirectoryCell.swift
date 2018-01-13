//
//  DirectoryCell.swift
//  BYG
//
//  Created by Michael Kim on 12/19/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import UIKit

// Provide a class for the Directory screen's custom table view cells.
class DirectoryCell: UITableViewCell {

    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var studentGrade: UILabel!
    @IBOutlet weak var studentAddress: UILabel!
    @IBOutlet weak var studentPhoneNumber: UILabel!
    @IBOutlet weak var studentBirthday: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
