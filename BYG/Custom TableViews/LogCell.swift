//
//  LogCell.swift
//  BYG
//
//  Created by Michael Kim on 1/13/18.
//  Copyright © 2018 Michael Kim. All rights reserved.
//

import UIKit

// Provide a class for the Log screen's custom table view cells.
class LogCell: UITableViewCell {

    @IBOutlet weak var questionName: UILabel!
    @IBOutlet weak var questionAnswer: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
