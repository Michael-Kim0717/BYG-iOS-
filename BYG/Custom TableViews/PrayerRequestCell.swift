//
//  PrayerRequestCell.swift
//  BYG
//
//  Created by Michael Kim on 12/19/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import UIKit

// Provide a class for the Prayer Request screen's custom table view cells.
class PrayerRequestCell: UITableViewCell {
    
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var prayerRequestDate: UILabel!
    @IBOutlet weak var prayerRequest: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
