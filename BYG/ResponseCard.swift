//
//  ResponseCard.swift
//  BYG
//
//  Created by Michael Kim on 12/13/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import Foundation

class ResponseCard : UIViewController {
    
    override func viewDidLoad() {
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
}
