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
    
    @IBAction func login(_ sender: Any) {
        Auth.auth().signIn(withEmail: usernameField.text!, password: passwordField.text!, completion: {
            (user, error) in
            if (user != nil) {
                self.performSegue(withIdentifier: "toStaff", sender: self)
            }
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
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginView.layer.cornerRadius = 10
        loginView.layer.masksToBounds = true
        // Do any additional setup after loading the view.
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
