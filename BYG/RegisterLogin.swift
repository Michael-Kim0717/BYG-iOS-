//
//  RegisterLogin.swift
//  BYG
//
//  Created by Michael Kim on 12/13/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import Foundation

class RegisterLogin : UIViewController {
    
    // Variable Declarations.
    
    @IBOutlet weak var mentorOutlet: UIButton!
    @IBOutlet weak var staffOutlet: UIButton!
    @IBOutlet weak var loginOutlet: UIButton!
    
    @IBAction func mentorButton(_ sender: Any) {
        mentorOutlet.backgroundColor = UIColor.black
        mentorOutlet.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        performSegue(withIdentifier: "registerMentor", sender: self)
    }
    @IBAction func staffButton(_ sender: Any) {
        staffOutlet.backgroundColor = UIColor.white
        staffOutlet.setTitleColor(UIColor.black, for: UIControlState.normal)
        
        performSegue(withIdentifier: "registerStaff", sender: self)
    }
    @IBAction func loginButton(_ sender: Any) {
        loginOutlet.backgroundColor = UIColor.black
        loginOutlet.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        performSegue(withIdentifier: "loginUser", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "registerMentor") {
            let destVC = segue.destination as! EnterPIN
            
            destVC.person = "Mentor"
        }
        else if (segue.identifier == "registerStaff"){
            let destVC = segue.destination as! EnterPIN
            
            destVC.person = "Pastor"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
