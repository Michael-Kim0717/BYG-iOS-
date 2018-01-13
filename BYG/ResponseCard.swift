//
//  ResponseCard.swift
//  BYG
//
//  Created by Michael Kim on 12/13/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import Foundation
import FirebaseDatabase

class ResponseCard : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
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
    
    let grades = ["6B", "6G", "7B", "7G", "8B", "8G", "9B", "9G", "10B", "10G", "11B", "11G", "12B", "12G"]
    
    var gradePicker = UIPickerView()
    
    var prReference: DatabaseReference!
    
    // PickerView Functions.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return grades.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return grades[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gradeField.text = grades[row]
        gradeField.resignFirstResponder()
    }
    
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
    
    /*
     When the Upload button is pressed,
     check if certain fields are empty and if so, provide an error.
     Otherwise, save the prayer request into the database depending on which switches were selected.
     */
    @IBAction func uploadButton(_ sender: Any) {
        var name: String
        var grade: String
        var prayerReq: String
        
        prReference = Database.database().reference()
        
        // If any fields are empty, throw an alert.
        if (!anonSwitchOutlet.isOn && (nameField.text == "" || gradeField.text == "" || prayerReqField.text == "")){
            let emptyFieldError = UIAlertController(title: "Empty Field(s)",
                                                       message: "Please fill in your name, grade, and prayer request or click anonymous to send anonymously.",
                                                       preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
            emptyFieldError.addAction(dismiss)
            self.present(emptyFieldError, animated: true, completion: nil)
        }
        else if (anonSwitchOutlet.isOn && prayerReqField.text == ""){
            let emptyFieldError = UIAlertController(title: "Empty Field",
                                                       message: "Please fill in your prayer request.",
                                                       preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
            emptyFieldError.addAction(dismiss)
            self.present(emptyFieldError, animated: true, completion: nil)
        }
        // Create a new database entry for prayer requests and save their corresponding details.
        // Send an alert once the entry is saved.
        else if (mentorSwitchOutlet.isOn || pastorSwitchOutlet.isOn || staffSwitchOutlet.isOn){
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
            
            nameField.text = ""
            gradeField.text = ""
            prayerReqField.text = ""
            
            let prSent = UIAlertController(title: "Prayer Request Sent!",
                                                       message: "Your Prayer Request was sent successfully.",
                                                       preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
            prSent.addAction(dismiss)
            self.present(prSent, animated: true, completion: nil)
        }
        // If no staff are selected, provide an alert for the user to properly select a staff member.
        else{
            let unknownSender = UIAlertController(title: "Who are you sending this too?",
                                                       message: "Please select who you want to send this prayer request to.",
                                                       preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
            unknownSender.addAction(dismiss)
            self.present(unknownSender, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        gradePicker.delegate = self
        gradePicker.dataSource = self
        
        gradeField.inputView = gradePicker
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
