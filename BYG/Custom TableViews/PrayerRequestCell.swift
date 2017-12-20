//
//  PrayerRequestCell.swift
//  BYG
//
//  Created by Michael Kim on 12/19/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import UIKit

class PrayerRequestCell: UITableViewCell {
    
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var prayerRequestDate: UILabel!
    @IBOutlet weak var prayerRequest: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
