//
//  MentorsNote.swift
//  BYG
//
//  Created by Michael Kim on 12/14/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import Foundation
import FirebaseDatabase

class MentorsNote : UIViewController {
    
    // Variable declarations.
    @IBOutlet weak var mentorsNote: UILabel!
    
    var mentorsNoteReference : DatabaseReference!
    var handle : DatabaseHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        // Get the mentor's note reference and retrieve information.
        mentorsNoteReference = Database.database().reference()
        
        handle = mentorsNoteReference?.child("Mentors Notes").observe(.childAdded, with: { (snapshot) in
            // Change the Label to the corresponding mentor's note.
            if let item = snapshot.value as? String {
                if (snapshot.key == "10B"){
                    self.mentorsNote.text = item
                }
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
