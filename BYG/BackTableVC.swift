//
//  BackTableVC.swift
//  BYG
//
//  Created by Michael Kim on 12/13/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import Foundation

class BackTableVC : UITableViewController {
    
    var TableArray = [String]()
    
    override func viewDidLoad() {
        TableArray = ["Newsfeed", "Response Card", "Register/Login"]
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
