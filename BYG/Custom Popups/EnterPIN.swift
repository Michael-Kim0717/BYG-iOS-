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
    
    @IBOutlet weak var pin1: UITextField!
    @IBOutlet weak var pin2: UITextField!
    @IBOutlet weak var pin3: UITextField!
    @IBOutlet weak var pin4: UITextField!
    @IBOutlet weak var pin5: UITextField!
    @IBOutlet weak var pin6: UITextField!
    @IBOutlet weak var pin7: UITextField!
    @IBOutlet weak var pin8: UITextField!
    @IBAction func enterPIN(_ sender: Any) {
        var pinString: String
        pinString = "\(pin1.text!)\(pin2.text!)\(pin3.text!)\(pin4.text!)\(pin5.text!)\(pin6.text!)\(pin7.text!)\(pin8.text!)"
        
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
        
        pin1.becomeFirstResponder()
        pin1.addTarget(self, action: #selector(pin1Changed(_:)), for: .editingChanged)
        pin2.addTarget(self, action: #selector(pin2Changed(_:)), for: .editingChanged)
        pin3.addTarget(self, action: #selector(pin3Changed(_:)), for: .editingChanged)
        pin4.addTarget(self, action: #selector(pin4Changed(_:)), for: .editingChanged)
        pin5.addTarget(self, action: #selector(pin5Changed(_:)), for: .editingChanged)
        pin6.addTarget(self, action: #selector(pin6Changed(_:)), for: .editingChanged)
        pin7.addTarget(self, action: #selector(pin7Changed(_:)), for: .editingChanged)
        pin8.addTarget(self, action: #selector(pin8Changed(_:)), for: .editingChanged)
        // Do any additional setup after loading the view.
    }
    
    @objc func pin1Changed(_ textField: UITextField){
        if pin1.text?.count == 1 {
            pin2.becomeFirstResponder()
        }
    }
    
    @objc func pin2Changed(_ textField: UITextField){
        if pin2.text?.count == 1 {
            pin3.becomeFirstResponder()
        }
        else if pin2.text?.count == 0 {
            pin1.becomeFirstResponder()
        }
    }
    
    @objc func pin3Changed(_ textField: UITextField){
        if pin3.text?.count == 1 {
            pin4.becomeFirstResponder()
        }
        else if pin3.text?.count == 0 {
            pin2.becomeFirstResponder()
        }
    }
    
    @objc func pin4Changed(_ textField: UITextField){
        if pin4.text?.count == 1 {
            pin5.becomeFirstResponder()
        }
        else if pin4.text?.count == 0 {
            pin3.becomeFirstResponder()
        }
    }
    
    @objc func pin5Changed(_ textField: UITextField){
        if pin5.text?.count == 1 {
            pin6.becomeFirstResponder()
        }
        else if pin5.text?.count == 0 {
            pin4.becomeFirstResponder()
        }
    }
    
    @objc func pin6Changed(_ textField: UITextField){
        if pin6.text?.count == 1 {
            pin7.becomeFirstResponder()
        }
        else if pin6.text?.count == 0 {
            pin5.becomeFirstResponder()
        }
    }
    
    @objc func pin7Changed(_ textField: UITextField){
        if pin7.text?.count == 1 {
            pin8.becomeFirstResponder()
        }
        else if pin7.text?.count == 0 {
            pin6.becomeFirstResponder()
        }
    }
    
    @objc func pin8Changed(_ textField: UITextField){
        if pin8.text?.count == 0 {
            pin7.becomeFirstResponder()
        }
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
