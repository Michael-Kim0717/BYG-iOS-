//
//  MentorsNote.swift
//  BYG
//
//  Created by Michael Kim on 12/14/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class MentorsNote : UIViewController {
    
    // Variable declarations.
    @IBOutlet weak var mentorsNote: UILabel!
    @IBOutlet weak var construction: UIImageView!
    
    var mentorsNoteReference : DatabaseReference!
    var handle : DatabaseHandle!
    
    var grade : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        // Get the mentor's note reference and retrieve information.
        mentorsNoteReference = Database.database().reference()
        
        mentorsNote.sizeToFit()
        
        handle = mentorsNoteReference?.child("Mentor").observe(.childAdded, with: { (snapshot) in
            // If there are items within the Announcements reference, grab it as a string and show it in the tableview.
            if let item = snapshot.value as? [String:AnyObject]{
                if (item["name"] as? String == Auth.auth().currentUser?.displayName){
                    self.grade = item["grade"] as? String
                }
                if (self.grade == nil){
                    self.construction.alpha = 1
                    self.mentorsNote.text = "Currently not applicable to Pastoral Staff. May change in the future."
                }
            }
        })
        
        handle = mentorsNoteReference?.child("Mentors Notes").observe(.childAdded, with: { (snapshot) in
            // Change the Label to the corresponding mentor's note.
            if let item = snapshot.value as? String {
                if (snapshot.key == self.grade){
                    self.mentorsNote.text = item
                }
            }
        })
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
