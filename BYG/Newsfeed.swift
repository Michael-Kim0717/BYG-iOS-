//
//  Newsfeed.swift
//  BYG
//
//  Created by Michael Kim on 12/13/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Newsfeed : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Variable declarations.
    @IBOutlet weak var announcementTable: UITableView!
    
    var announcementReference : DatabaseReference!
    var handle: DatabaseHandle!
    
    var announcementList: [String] = []
    
    // Set up table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announcementList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "announcement")
        cell.textLabel?.text = announcementList[indexPath.row]
        return cell;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        // Get the announcement reference and retrieve information.
        announcementReference = Database.database().reference()
        
        handle = announcementReference?.child("Announcements").observe(.childAdded, with: { (snapshot) in
            // If there are items within the Announcements reference, grab it as a string and show it in the tableview.
            if let item = snapshot.value as? [String:AnyObject]{
                self.announcementList.append(item["announcement"] as! String)
                self.announcementTable.reloadData()
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
