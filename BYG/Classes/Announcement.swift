//
//  Announcement.swift
//  BYG
//
//  Created by Michael Kim on 12/18/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import Foundation

class Announcement {
    
    var announcement = ""
    var person = ""
    
    func initWithDict (dictionary: [String:AnyObject]) {
        self.announcement = dictionary["announcement"] as! String
        self.person = dictionary["person"] as! String
    }
    
}
