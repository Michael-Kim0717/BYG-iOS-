//
//  ShowPrayerRequest.swift
//  BYG
//
//  Created by Michael Kim on 12/22/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import UIKit

class ShowPrayerRequest: UIViewController {

    // Variable Declarations.
    var name: String?
    var date: String?
    var grade: String?
    var pr: String?
    
    @IBOutlet weak var prView: UIView!
    @IBOutlet weak var studentLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var prLabel: UILabel!
    
    // Dismiss the Prayer Request popup.
    @IBAction func dismissPopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Provide rounded corners to the popup.
        prView.layer.cornerRadius = 10
        prView.layer.masksToBounds = true
        
        prLabel.sizeToFit()
        
        // Populate variables with the selected prayer request's details.
        studentLabel.text = name
        if (grade == nil){
            gradeLabel.alpha = 0
        }
        else{
            gradeLabel.text = grade
        }
        if (date == nil){
            dateLabel.alpha = 0
        }
        else {
            dateLabel.text = date
        }
        prLabel.text = pr
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
