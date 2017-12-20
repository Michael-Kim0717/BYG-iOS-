//
//  ResponseCard.swift
//  BYG
//
//  Created by Michael Kim on 12/13/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import Foundation
import FirebaseDatabase

class ResponseCard : UIViewController {
    
    // Variable Declarations.
    @IBOutlet weak var mentorSwitchOutlet: UISwitch!
    @IBOutlet weak var staffSwitchOutlet: UISwitch!
    @IBOutlet weak var pastorSwitchOutlet: UISwitch!
    @IBOutlet weak var anonSwitchOutlet: UISwitch!
    
    @IBOutlet weak var mentorLabel: UILabel!
    @IBOutlet weak var staffLabel: UILabel!
    @IBOutlet weak var pastorsLabel: UILabel!
    @IBOutlet weak var anonLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var gradeField: UITextField!
    @IBOutlet weak var prayerReqField: UITextView!
    
    var prReference: DatabaseReference!
    
    // When certain switches are toggled on, hide any unnecessary switches and labels.
    @IBAction func allStaffSwitch(_ sender: UISwitch) {
        if (sender.isOn){
            self.mentorLabel.alpha = 0
            self.mentorSwitchOutlet.alpha = 0
            self.mentorSwitchOutlet.setOn(false, animated: false)
            
            self.pastorsLabel.alpha = 0
            self.pastorSwitchOutlet.alpha = 0
            self.pastorSwitchOutlet.setOn(false, animated: false)
        }
        else{
            if (!anonSwitchOutlet.isOn){
                self.mentorSwitchOutlet.alpha = 1
                self.mentorLabel.alpha = 1
            }
            
            self.pastorsLabel.alpha = 1
            self.pastorSwitchOutlet.alpha = 1
        }
    }
    @IBAction func anonSwitch(_ sender: UISwitch) {
        if (sender.isOn){
            self.mentorLabel.alpha = 0
            self.mentorSwitchOutlet.alpha = 0
            self.mentorSwitchOutlet.setOn(false, animated: false)
            
            self.nameLabel.alpha = 0
            self.nameField.alpha = 0
            
            self.gradeLabel.alpha = 0
            self.gradeField.alpha = 0
        }
        else{
            if (!staffSwitchOutlet.isOn){
                self.mentorSwitchOutlet.alpha = 1
                self.mentorLabel.alpha = 1
            }
            
            self.nameLabel.alpha = 1
            self.nameField.alpha = 1
            
            self.gradeLabel.alpha = 1
            self.gradeField.alpha = 1
        }
    }
    
    @IBAction func uploadButton(_ sender: Any) {
        var name: String
        var grade: String
        var prayerReq: String
        
        prReference = Database.database().reference()
        
        if (mentorSwitchOutlet.isOn || pastorSwitchOutlet.isOn || staffSwitchOutlet.isOn){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy h:mm:ss a"
            let currDate = dateFormatter.string(from: NSDate() as Date)
            
            let dateEnd = currDate.index(currDate.startIndex, offsetBy: 10)
            let timeStart = currDate.index(currDate.startIndex, offsetBy: 11)
            
            let date = currDate[..<dateEnd]
            let time = currDate[timeStart...]
            prReference.child("Prayer Requests/" + currDate + "/date").setValue(date)
            prReference.child("Prayer Requests/" + currDate + "/time").setValue(time)
            
            if (anonSwitchOutlet.isOn){
                name = "Anonymous"
                prReference.child("Prayer Requests/" + currDate + "/name").setValue(name);
                
                if (staffSwitchOutlet.isOn){
                    grade = "A"
                    prReference.child("Prayer Requests/" + currDate + "/grade").setValue(grade);
                }
                
                if (pastorSwitchOutlet.isOn){
                    grade = "P"
                    prReference.child("Prayer Requests/" + currDate + "/grade").setValue(grade);
                }
                
                prayerReq = prayerReqField.text!
                prReference.child("Prayer Requests/" + currDate + "/prayerRequest").setValue(prayerReq);
            }
            else{
                name = nameField.text!
                prReference.child("Prayer Requests/" + currDate + "/name").setValue(name);
                
                if (staffSwitchOutlet.isOn){
                    grade = gradeField.text! + "A"
                }
                
                if (mentorSwitchOutlet.isOn && pastorSwitchOutlet.isOn){
                    grade = gradeField.text! + "P"
                    prReference.child("Prayer Requests/" + currDate + "/grade").setValue(grade);
                }
                else if (mentorSwitchOutlet.isOn){
                    grade = gradeField.text!
                    prReference.child("Prayer Requests/" + currDate + "/grade").setValue(grade);
                }
                else if (pastorSwitchOutlet.isOn){
                    grade = "P" + gradeField.text!
                    prReference.child("Prayer Requests/" + currDate + "/grade").setValue(grade);
                }
                
                prayerReq = prayerReqField.text!
                prReference.child("Prayer Requests/" + currDate + "/prayerRequest").setValue(prayerReq);
            }
        }
        else{
            print("please click a value")
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
