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
    }
    @IBAction func staffButton(_ sender: Any) {
        staffOutlet.backgroundColor = UIColor.white
        staffOutlet.setTitleColor(UIColor.black, for: UIControlState.normal)
    }
    @IBAction func loginButton(_ sender: Any) {
        loginOutlet.backgroundColor = UIColor.black
        loginOutlet.setTitleColor(UIColor.white, for: UIControlState.normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
