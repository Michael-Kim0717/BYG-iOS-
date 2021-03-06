//
//  Newsfeed.swift
//  BYG
//
//  Created by Michael Kim on 12/13/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class Newsfeed : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Variable Declarations.
    @IBOutlet weak var announcementTable: UITableView!
    @IBOutlet weak var welcomeText: UILabel!
    
    var announcementList: [String] = []
    var announcementDetailsList: [String] = []
    var isLoggedIn: String = "Student"
    
    // Database Declarations.
    var announcementReference : DatabaseReference!
    var handle: DatabaseHandle!
    
    // Logout the user when pressed.
    @IBAction func logoutUser(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            try! Auth.auth().signOut()
        }
    }
    
    // TableView Functions.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announcementList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "announcement")
        cell.textLabel?.text = announcementList[indexPath.row]
        return cell;
    }
    
    // Pass data to the 'Show Announcement' VC
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showAnnouncement", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ShowPrayerRequest {
            destination.name = announcementList[(announcementTable.indexPathForSelectedRow?.row)!]
            destination.pr = announcementDetailsList[(announcementTable.indexPathForSelectedRow?.row)!]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        // Change the values corresponding to if a user is logged in or not.
        if Auth.auth().currentUser != nil {
            self.isLoggedIn = "Staff"
        }
        
        if self.isLoggedIn == "Staff" {
            welcomeText.text = "Welcome " + (Auth.auth().currentUser?.displayName)!
        }
        else{
            welcomeText.text = "Welcome!"
        }
        
        // Get the announcement reference and retrieve information.
        announcementReference = Database.database().reference()
        
        handle = announcementReference?.child("Announcements").observe(.childAdded, with: { (snapshot) in
            // If there are items within the Announcements reference, grab it as a string and show it in the tableview.
            if let item = snapshot.value as? [String:AnyObject]{
                if (self.isLoggedIn == "Staff"){
                    self.announcementList.append(item["announcement"] as! String)
                    self.announcementDetailsList.append(item["details"] as! String)
                }
                else{
                    if (item["person"] as! String == "Student"){
                        self.announcementList.append(item["announcement"] as! String)
                        self.announcementDetailsList.append(item["details"] as! String)
                    }
                }
                self.announcementTable.reloadData()
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
