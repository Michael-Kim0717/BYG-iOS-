//
//  Logs.swift
//  BYG
//
//  Created by Michael Kim on 12/14/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import Foundation
import MessageUI

class Logs : UIViewController, MFMailComposeViewControllerDelegate {
    
    // Variable Declarations.
    @IBAction func sendEmail(_ sender: Any) {
        let mailComposeViewController = configureMailController()
        if (missingStudents.text == "" || highlights.text == "" || goalOfTheDay.text == "" || improveTime.text == "" || meeting.text == "" || prayerReq.text == ""){
            let emptyFieldError = UIAlertController(title: "Empty Fields.",
                                                       message: "Please fill in all fields.",
                                                       preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
            emptyFieldError.addAction(dismiss)
            self.present(emptyFieldError, animated: true, completion: nil)
        }
        else {
            if (MFMailComposeViewController.canSendMail()) {
                self.present(mailComposeViewController, animated: true, completion: nil)
            }
            else{
                showMailError()
            }
        }
    }
    
    @IBOutlet weak var missingStudents: UITextView!
    @IBOutlet weak var highlights: UITextView!
    @IBOutlet weak var goalOfTheDay: UITextView!
    @IBOutlet weak var improveTime: UITextView!
    @IBOutlet weak var meeting: UITextView!
    @IBOutlet weak var prayerReq: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
    // Set up Mail View Controller.
    func configureMailController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["michaelkim6@yahoo.com"])
        mailComposerVC.setSubject("Log for *GRADE*")
        mailComposerVC.setMessageBody(
            "Missing Students : \n" +
            missingStudents.text! + "\n" +
            "Highlights : \n" +
            highlights.text! + "\n" +
            "Did you meet the small group goal of the day? Why or why not? : \n " +
            goalOfTheDay.text! + "\n" +
            "Solutions on how to improve small group time : \n" +
            improveTime.text! + "\n" +
            "Who did you meet uip with this week? : \n " +
            meeting.text! + "\n" +
            "Prayer Requests : \n" +
            prayerReq.text!
            , isHTML: false)
        
        return mailComposerVC
    }
    
    func showMailError() {
        let sendMailErrorAlert = UIAlertController(title: "Could not send email.",
                                                   message: "Your device could not send email",
                                                   preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
