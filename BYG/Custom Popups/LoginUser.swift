//
//  LoginUser.swift
//  BYG
//
//  Created by Michael Kim on 12/24/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginUser: UIViewController {

    // Variable Declarations.
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginView: UIView!
    
    /*
     When the login button is clicked,
     if the password is incorrect send an error.
     Otherwise send the user into the StaffVC view controller.
     */
    @IBAction func login(_ sender: Any) {
        Auth.auth().signIn(withEmail: usernameField.text!, password: passwordField.text!, completion: {
            (user, error) in
            // If there is no error in logging in.
            if (user != nil) {
                self.performSegue(withIdentifier: "toStaff", sender: self)
            }
            // Throw an alert when there is an error.
            else{
                let creationError = UIAlertController(title: "Error During Signup",
                                                      message: error?.localizedDescription,
                                                      preferredStyle: .alert)
                let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
                creationError.addAction(dismiss)
                self.present(creationError, animated: true, completion: nil)
            }
        })
    }
    
    // Close the Login popup.
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Provide rounded corners to the popup.
        loginView.layer.cornerRadius = 10
        loginView.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
