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
        performSegue(withIdentifier: "registerMentor", sender: self)
    }
    @IBAction func staffButton(_ sender: Any) {
        performSegue(withIdentifier: "registerStaff", sender: self)
    }
    @IBAction func loginButton(_ sender: Any) {
        performSegue(withIdentifier: "loginUser", sender: self)
    }
    
    /*
     Depending on which registration was clicked,
     send the proper details over upon segue.
     */
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
    
    // Functions to change the button's color and text upon press/release.
    @objc func WhiteToBlack (_ button: UIButton) {
        button.backgroundColor = UIColor.black
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
    }
    
    @objc func BlackToWhite (_ button: UIButton) {
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        
        // When the selected button is pressed, change the colors of the background and text.
        // When the selected button is released, change the colors back.
        mentorOutlet.addTarget(self, action: #selector(WhiteToBlack(_:)), for: .touchDown)
        mentorOutlet.addTarget(self, action: #selector(BlackToWhite(_:)), for: .touchUpInside)
        
        staffOutlet.addTarget(self, action: #selector(BlackToWhite(_:)), for: .touchDown)
        staffOutlet.addTarget(self, action: #selector(WhiteToBlack(_:)), for: .touchUpInside)
        
        loginOutlet.addTarget(self, action: #selector(WhiteToBlack(_:)), for: .touchDown)
        loginOutlet.addTarget(self, action: #selector(BlackToWhite(_:)), for: .touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
