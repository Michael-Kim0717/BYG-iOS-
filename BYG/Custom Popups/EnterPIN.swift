//
//  EnterPIN.swift
//  BYG
//
//  Created by Michael Kim on 12/26/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import UIKit

class EnterPIN: UIViewController {
    
    @IBOutlet weak var PINView: UIView!
 
    @IBOutlet weak var pinText: UITextField!
    
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
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var person: String?
    var pin: String?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! RegisterStaff
        
        destVC.person = person
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        PINView.layer.cornerRadius = 10
        PINView.layer.masksToBounds = true
        
        if person == "Mentor" {
            pin = "12345678"
        }
        else {
            pin = "87654321"
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
