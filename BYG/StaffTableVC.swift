//
//  StaffTableVC.swift
//  BYG
//
//  Created by Michael Kim on 12/14/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import Foundation

/*
 This class is used primarily when a user is logged in.
 The navigation menu on the left side of the screen will provide 6 options: Newsfeed, Mentor's Notes, Logs, Directory, Prayer Requests, Feedback.
 */
class StaffTableVC: UITableViewController {
    
    var TableArray = [String]()
    
    override func viewDidLoad() {
        TableArray = ["Newsfeed", "Mentor's Notes", "Logs", "Directory", "Prayer Requests", "Feedback"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: TableArray[indexPath.row], for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = TableArray[indexPath.row]
        
        return cell
    }
    
}
