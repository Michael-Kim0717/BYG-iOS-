//
//  PrayerRequests.swift
//  BYG
//
//  Created by Michael Kim on 12/14/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import Foundation
import FirebaseDatabase

class PrayerRequests : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Variable Declarations.
    @IBOutlet weak var prTableView: UITableView!
    
    var studentNameList: [String] = []
    var prayerRequestDateList: [String] = []
    var prayerRequestList: [String] = []
    
    // Database Variables.
    var prReference : DatabaseReference!
    var handle : DatabaseHandle!
  
    // TableView Setup Functions.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentNameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Prayer Request", for: indexPath) as! PrayerRequestCell
        
        // Set the labels accordingly to the information gathered from the database.
        cell.studentName?.text = studentNameList[indexPath.row]
        cell.prayerRequestDate?.text = prayerRequestDateList[indexPath.row]
        cell.prayerRequest?.text = prayerRequestList[indexPath.row]
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Make each cell around 85 px each.
        return 85;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        prReference = Database.database().reference()
        
        // Grab each prayer request from the database.
        // If the prayer request satisfies the current user's grade requirements, it will show up within the tableview.
        handle = prReference?.child("Prayer Requests").observe(.childAdded, with: { (snapshot) in
            if let item = snapshot.value as? [String:AnyObject] {
                if ((item["grade"] as! String) == "10B" || (item["grade"] as! String) == "A"){
                    self.studentNameList.append(item["name"] as! String)
                    self.prayerRequestDateList.append(item["date"] as! String)
                    self.prayerRequestList.append(item["prayerRequest"] as! String)
                    self.prTableView.reloadData()
                }
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
