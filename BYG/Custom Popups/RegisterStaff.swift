//
//  RegisterStaff.swift
//  
//
//  Created by Michael Kim on 12/23/17.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterStaff: UIViewController {

    // Variable Declarations.
    var person: String?
    
    @IBOutlet weak var registrationView: UIView!
    
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var registrationLabel: UILabel!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var gradeField: UITextField!
    
    var registrationReference: DatabaseReference!
    
    @IBAction func registerPerson(_ sender: Any) {
        if (nameField.text != "" || emailField.text != "" || passwordField.text != "" || phoneField.text != "" || gradeField.text != ""){
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!, completion: {
                (user, error) in
                if (user != nil){
                    let userCreated = UIAlertController(title: "User Successfully Created!",
                                                   message: "You are now set to log in.",
                                                   preferredStyle: .alert)
                    let dismissAlert = UIAlertAction(title: "OK", style: .default, handler: nil)
                    userCreated.addAction(dismissAlert)
                    self.present(userCreated, animated: true, completion: nil)
                    
                    self.registrationReference = Database.database().reference()
                    
                    if (self.person == "Mentor"){
                        let autoId = self.registrationReference.child("Mentor").childByAutoId()
                        
                        autoId.child("name").setValue(self.nameField.text!)
                        autoId.child("grade").setValue(self.gradeField.text!)
                        autoId.child("phone").setValue(self.phoneField.text!)
                        autoId.child("email").setValue(self.emailField.text!)
                    }
                    else if (self.person == "Pastor"){
                        let autoId = self.registrationReference.child("Staff").childByAutoId()
                        
                        autoId.child("name").setValue(self.nameField.text!)
                        autoId.child("email").setValue(self.emailField.text!)
                        autoId.child("phone").setValue(self.phoneField.text!)
                    }
                    
                    let user = Auth.auth().currentUser
                    let changeRequest = user?.createProfileChangeRequest()
                    
                    changeRequest?.displayName = self.nameField.text!
                    changeRequest?.commitChanges(completion: {
                        error in
                        if let error = error {
                            print (error)
                        }
                        else{
                            print ("profile created.")
                        }
                    })
                        
                    self.nameField.text = ""
                    self.emailField.text = ""
                    self.passwordField.text = ""
                    self.phoneField.text = ""
                    self.gradeField.text = ""
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
        else {
            let emptyField = UIAlertController(title: "Empty Fields",
                                                  message: "Please fill in all the fields.",
                                                  preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
            emptyField.addAction(dismiss)
            self.present(emptyField, animated: true, completion: nil)
        }
    }
    
    @IBAction func dismissPopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registrationView.layer.cornerRadius = 10
        registrationView.layer.masksToBounds = true
        
        registrationLabel.text = person! + " Registration"
        
        if (person == "Pastor"){
            gradeLabel.alpha = 0
            
            gradeField.alpha = 0
        }
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
