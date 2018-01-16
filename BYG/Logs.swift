//
//  Logs.swift
//  BYG
//
//  Created by Michael Kim on 12/14/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import Foundation
import MessageUI
import FirebaseAuth
import FirebaseDatabase

class Logs : UIViewController, MFMailComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    // Variable Declarations.
    let logQuestions = ["Missing Students : ", "Highlights : ", "Did you meet the small group goal of the day? Why or why not? : ", "Solutions on how to improve small group time : ", "Who did you meet up with this week? : ", "Prayer Requests : "]

    @IBOutlet weak var submitOutlet: UIButton!
    @IBOutlet weak var logTableView: UITableView!
    var missingStudents: UITextView!
    var highlights: UITextView!
    var smallGroupGoal: UITextView!
    var solutions: UITextView!
    var meetup: UITextView!
    var pr: UITextView!
    
    @IBOutlet weak var pastoralStaffLabel: UILabel!
    @IBOutlet weak var construction: UIImageView!
    
    var grade: String?
    
    /*
     Upon Send Email button pressed,
     if any text fields are empty,
     provide an error alert.
     Otherwise, go to the send mail method.
     */
    @IBAction func sendEmail(_ sender: Any) {
        let mailComposeViewController = configureMailController()
        if (missingStudents.text == "" || highlights.text == "" || smallGroupGoal.text == "" || solutions.text == "" || meetup.text == "" || pr.text == ""){
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
    
    // TableView Functions.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Log Question", for: indexPath) as! LogCell
        
        cell.questionName.text = logQuestions[indexPath.row]
        
        // Save text fields to variables.
        if (indexPath.row == 0){
            missingStudents = cell.questionAnswer
        }
        else if (indexPath.row == 1){
            highlights = cell.questionAnswer
        }
        else if (indexPath.row == 2){
            smallGroupGoal = cell.questionAnswer
        }
        else if (indexPath.row == 3){
            solutions = cell.questionAnswer
        }
        else if (indexPath.row == 4){
            meetup = cell.questionAnswer
        }
        else if (indexPath.row == 5){
            pr = cell.questionAnswer
        }
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Make each cell around 125 px each.
        return 125;
    }
    
    // Database Declarations.
    var mentorReference: DatabaseReference!
    var databaseHandle: DatabaseHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        mentorReference = Database.database().reference()
        
        databaseHandle = mentorReference?.child("Mentor").observe(.childAdded, with: { (snapshot) in
            // If there are items within the Announcements reference, grab it as a string and show it in the tableview.
            if let item = snapshot.value as? [String:AnyObject]{
                if (item["name"] as? String == Auth.auth().currentUser?.displayName){
                    self.grade = item["grade"] as? String
                }
            }
        })
        
        if (self.grade == nil) {
            self.construction.alpha = 1
            self.pastoralStaffLabel.alpha = 1
            self.logTableView.alpha = 0
            self.submitOutlet.alpha = 0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
    // Set up Mail View Controller.
    func configureMailController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["michaelkim6@yahoo.com"])
        mailComposerVC.setSubject("Log for " + self.grade!)
        mailComposerVC.setMessageBody(
            "Missing Students : \n" +
            missingStudents.text! + "\n" +
            "Highlights : \n" +
            highlights.text! + "\n" +
            "Did you meet the small group goal of the day? Why or why not? : \n " +
            smallGroupGoal.text! + "\n" +
            "Solutions on how to improve small group time : \n" +
            solutions.text! + "\n" +
            "Who did you meet uip with this week? : \n " +
            meetup.text! + "\n" +
            "Prayer Requests : \n" +
            pr.text!
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
