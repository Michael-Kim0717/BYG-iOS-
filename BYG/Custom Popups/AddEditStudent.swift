//
//  AddEditStudent.swift
//  BYG
//
//  Created by Michael Kim on 12/21/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddEditStudent: UIViewController {

    // Variable Declarations.
    var name : String?
    var birthday : String?
    var phoneNum : String?
    var address : String?
    var city : String?
    var state : String?
    
    @IBOutlet weak var studentName: UITextField!
    @IBOutlet weak var studentBirthday: UITextField!
    @IBOutlet weak var studentPhoneNumber: UITextField!
    @IBOutlet weak var studentAddress: UITextField!
    @IBOutlet weak var studentCity: UITextField!
    @IBOutlet weak var studentState: UITextField!
    
    @IBOutlet weak var addEditButton: UIButton!
    
    var studentReference: DatabaseReference!
    
    @IBAction func addEditStudent(_ sender: UIButton) {
        if (studentName.text == ""){
            let emptyFieldError = UIAlertController(title: "Empty Fields",
                                                       message: "Please fill out your student's information.",
                                                       preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
            emptyFieldError.addAction(dismiss)
            self.present(emptyFieldError, animated: true, completion: nil)
        }
        else{
            studentReference = Database.database().reference()
            
            studentReference.child("Students/" + studentName.text! + " 10B/name").setValue(studentName.text!)
            studentReference.child("Students/" + studentName.text! + " 10B/grade").setValue("10B")
            studentReference.child("Students/" + studentName.text! + " 10B/birthday").setValue(studentBirthday.text!)
            studentReference.child("Students/" + studentName.text! + " 10B/phone").setValue(studentPhoneNumber.text!)
            studentReference.child("Students/" + studentName.text! + " 10B/address").setValue(studentAddress.text!)
            studentReference.child("Students/" + studentName.text! + " 10B/city").setValue(studentCity.text!)
            studentReference.child("Students/" + studentName.text! + " 10B/state").setValue(studentState.text!)
            
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
    @IBAction func closePopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var popupView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        
        studentName.text = name
        studentBirthday.text = birthday
        studentPhoneNumber.text = phoneNum
        studentAddress.text = address
        studentCity.text = city
        studentState.text = state
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
