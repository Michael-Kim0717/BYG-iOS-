//
//  EnterPIN.swift
//  BYG
//
//  Created by Michael Kim on 12/26/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import UIKit

class EnterPIN: UIViewController {
    
    // Variable Declarations.
    
    var person: String?
    var pin: String?
    @IBOutlet weak var PINView: UIView!
    @IBOutlet weak var pinText: UITextField!
    
    /*
     When the user is ready to enter the correct pin number,
     if the pin number entered is the same as the corresponding pin number, move the user into the registration screen.
     Otherwise, provide an alert that the pin is incorrect.
     */
    @IBAction func enterPIN(_ sender: Any) {
        var pinString: String
        pinString = pinText.text!
        
        if pinString == pin {
            performSegue(withIdentifier: "moveToRegistration", sender: self)
        }
        else {
            let wrongPIN = UIAlertController(title: "Wrong PIN",
                                                  message: "Invalid PIN Number",
                                                  preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
            wrongPIN.addAction(dismiss)
            self.present(wrongPIN, animated: true, completion: nil)
        }
    }
    
    // Close the EnterPIN popup.
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Send the corresponding staff tag into the RegisterStaff screen.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! RegisterStaff
        
        destVC.person = person
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Provide rounded corners to the EnterPIN layout.
        PINView.layer.cornerRadius = 10
        PINView.layer.masksToBounds = true
        
        // Provide the corresponding PIN numbers.
        if person == "Mentor" {
            pin = "12345678"
        }
        else {
            pin = "87654321"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
