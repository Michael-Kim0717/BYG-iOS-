//
//  Feedback.swift
//  BYG
//
//  Created by Michael Kim on 12/14/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Feedback : UIViewController {
    
    // Variable declarations.
    var feedbackReference : DatabaseReference!
    
    @IBOutlet weak var feedbackField: UITextView!
    @IBAction func submitFeedbackButton(_ sender: Any) {
        // When the 'Submit' button is clicked, get the 'Feedback' reference.
        feedbackReference = Database.database().reference()
        
        // If the feedback field is not empty, add what is written into the database.
        if feedbackField.text != "" {
            feedbackReference?.child("Feedback").childByAutoId().setValue(feedbackField.text)
            
            feedbackField.text = ""
            
            let successfulAction = UIAlertController(title: "Success!",
            message: "Feedback successfully sent.",
            preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
            successfulAction.addAction(dismiss)
            self.present(successfulAction, animated: true, completion: nil)
        }
        else{
            let emptyFieldError = UIAlertController(title: "Empty Field",
            message: "Please fill out your feedback before pressing the 'Submit' button :)",
            preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
            emptyFieldError.addAction(dismiss)
            self.present(emptyFieldError, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
