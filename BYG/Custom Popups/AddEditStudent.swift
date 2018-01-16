//
//  AddEditStudent.swift
//  BYG
//
//  Created by Michael Kim on 12/21/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class AddEditStudent: UIViewController {

    // Variable Declarations.
    var name : String?
    var birthday : String?
    var phoneNum : String?
    var address : String?
    var city : String?
    var state : String?
    
    var grade: String?
    
    @IBOutlet weak var studentName: UITextField!
    @IBOutlet weak var studentBirthday: UITextField!
    @IBOutlet weak var studentPhoneNumber: UITextField!
    @IBOutlet weak var studentAddress: UITextField!
    @IBOutlet weak var studentCity: UITextField!
    @IBOutlet weak var studentState: UITextField!
    
    @IBOutlet weak var addEditButton: UIButton!
    @IBOutlet weak var popupView: UIView!
    
    // Database Declarations.
    var studentReference: DatabaseReference!
    var directoryReference : DatabaseReference!
    var handle : DatabaseHandle!
    
    /*
     If the Add/Edit Student button is pressed,
     check if AT LEAST the name is filled in
     and provide an error if it is.
     Otherwise, add all details and the student into the database.
     */
    @IBAction func addEditStudent(_ sender: UIButton) {
        // Check if at least the name is filled in and provide an error if not.
        if (studentName.text == ""){
            let emptyFieldError = UIAlertController(title: "Empty Fields",
                                                       message: "Please fill out your student's information.",
                                                       preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
            emptyFieldError.addAction(dismiss)
            self.present(emptyFieldError, animated: true, completion: nil)
        }
        // Put all the details into the students directory and provide an alert when properly saved.
        else{
            studentReference = Database.database().reference()
            
            studentReference.child("Students/" + studentName.text! + grade! + "/name").setValue(studentName.text!)
            studentReference.child("Students/" + studentName.text! + grade! + "/grade").setValue(self.grade)
            studentReference.child("Students/" + studentName.text! + grade! + "/birthday").setValue(studentBirthday.text!)
            studentReference.child("Students/" + studentName.text! + grade! + "/phone").setValue(studentPhoneNumber.text!)
            studentReference.child("Students/" + studentName.text! + grade! + "/address").setValue(studentAddress.text!)
            studentReference.child("Students/" + studentName.text! + grade! + "/city").setValue(studentCity.text!)
            studentReference.child("Students/" + studentName.text! + grade! + "/state").setValue(studentState.text!)
            
            studentName.text = ""
            studentBirthday.text = ""
            studentPhoneNumber.text = ""
            studentAddress.text = ""
            studentCity.text = ""
            studentState.text = ""
            
            let successfulChange = UIAlertController(title: "Success!",
                                                    message: "Your change was successful.",
                                                    preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
            successfulChange.addAction(dismiss)
            self.present(successfulChange, animated: true, completion: nil)
        }
    }
    
    // Close the Add/Edit Student popup.
    @IBAction func closePopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Provide rounded corners to the popup.
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        
        // Get corresponding information if the Edit student button was previously clicked.
        studentName.text = name
        studentBirthday.text = birthday
        studentPhoneNumber.text = phoneNum
        studentAddress.text = address
        studentCity.text = city
        studentState.text = state
        
        directoryReference = Database.database().reference()
        
        handle = directoryReference?.child("Mentor").observe(.childAdded, with: { (snapshot) in
            // If there are items within the Announcements reference, grab it as a string and show it in the tableview.
            if let item = snapshot.value as? [String:AnyObject]{
                if (item["name"] as? String == Auth.auth().currentUser?.displayName){
                    self.grade = item["grade"] as? String
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
