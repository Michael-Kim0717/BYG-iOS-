//
//  ResponseCard.swift
//  BYG
//
//  Created by Michael Kim on 12/13/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import Foundation

class ResponseCard : UIViewController {
    
    // Variable Declarations.
    @IBOutlet weak var mentorSwitchOutlet: UISwitch!
    @IBOutlet weak var staffSwitchOutlet: UISwitch!
    @IBOutlet weak var pastorSwitchOutlet: UISwitch!
    @IBOutlet weak var anonSwitchOutlet: UISwitch!
    
    @IBOutlet weak var mentorLabel: UILabel!
    @IBOutlet weak var staffLabel: UILabel!
    @IBOutlet weak var pastorsLabel: UILabel!
    @IBOutlet weak var anonLabel: UILabel!
    
    // When certain switches are toggled on, hide any unnecessary switches and labels.
    @IBAction func myMentorSwitch(_ sender: UISwitch) {
    }
    @IBAction func allStaffSwitch(_ sender: UISwitch) {
        if (sender.isOn){
            self.mentorLabel.alpha = 0
            self.mentorSwitchOutlet.alpha = 0
            self.mentorSwitchOutlet.setOn(false, animated: false)
            
            self.pastorsLabel.alpha = 0
            self.pastorSwitchOutlet.alpha = 0
            self.pastorSwitchOutlet.setOn(false, animated: false)
        }
        else{
            self.mentorSwitchOutlet.alpha = 1
            self.mentorLabel.alpha = 1
            
            self.pastorsLabel.alpha = 1
            self.pastorSwitchOutlet.alpha = 1
        }
    }
    @IBAction func pastorsSwitch(_ sender: UISwitch) {
        
    }
    @IBAction func anonSwitch(_ sender: UISwitch) {
        if (sender.isOn){
            self.mentorLabel.alpha = 0
            self.mentorSwitchOutlet.alpha = 0
            self.mentorSwitchOutlet.setOn(false, animated: false)
        }
        else{
            if (!staffSwitchOutlet.isOn){
                self.mentorSwitchOutlet.alpha = 1
                self.mentorLabel.alpha = 1
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
