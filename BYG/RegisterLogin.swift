//
//  RegisterLogin.swift
//  BYG
//
//  Created by Michael Kim on 12/13/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import Foundation

class RegisterLogin : UIViewController {
    
    override func viewDidLoad() {
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
    }
    
}
