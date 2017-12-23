//
//  Directory.swift
//  BYG
//
//  Created by Michael Kim on 12/14/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Directory : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Variable Declarations.
    @IBOutlet weak var studentTableView: UITableView!
    
    var studentNameList: [String] = []
    var studentAddressList: [String] = []
    var studentPhoneList: [String] = []
    var studentBirthdayList: [String] = []
    
    var index: Int?
    
    // Database Variables.
    var directoryReference : DatabaseReference!
    var handle : DatabaseHandle!
    
    // TableView Setup Functions.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentNameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Student", for: indexPath) as! DirectoryCell
        
        // Set the labels accordingly to the information gathered from the database.
        cell.studentName?.text = studentNameList[indexPath.row]
        cell.studentGrade?.text = "10B"
        cell.studentAddress?.text = studentAddressList[indexPath.row]
        cell.studentPhoneNumber?.text = studentPhoneList[indexPath.row]
        cell.studentBirthday?.text = studentBirthdayList[indexPath.row]
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Make each cell around 100 px each.
        return 100;
    }
    
    @IBAction func editButton(_ sender: UIButton) {
        if let cell = sender.superview?.superview as? DirectoryCell {
            let indexPath = studentTableView.indexPath(for: cell)
            
            index = indexPath?.row
            
            performSegue(withIdentifier: "editStudent", sender: self)
        }
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        if let cell = sender.superview?.superview as? DirectoryCell {
            let indexPath = studentTableView.indexPath(for: cell)
            
            index = indexPath?.row
            
            directoryReference.child("Students").child(studentNameList[index!]).removeValue {
                error, _ in print(error)
            }
            
            studentNameList.remove(at: index!)
            studentBirthdayList.remove(at: index!)
            studentAddressList.remove(at: index!)
            studentPhoneList.remove(at: index!)
            
            studentTableView.deleteRows(at: [indexPath!], with: UITableViewRowAnimation.automatic)
            
            let successfulChange = UIAlertController(title: "Delete successful!",
                                                     message: "Your change was successful.",
                                                     preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
            successfulChange.addAction(dismiss)
            self.present(successfulChange, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editStudent"){
            let destVC = segue.destination as! AddEditStudent
            
            destVC.name = studentNameList[index!]
            destVC.phoneNum = studentPhoneList[index!]
            destVC.birthday = studentBirthdayList[index!]
            destVC.address = studentAddressList[index!]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        directoryReference = Database.database().reference()
        
        // Grabs each student from the directory reference.
        // If the grade is currently "10B", it will populate the corresponding arrays.
        handle = directoryReference?.child("Students").observe(.childAdded, with: { (snapshot) in
            if let item = snapshot.value as? [String:AnyObject]{
                if ((item["grade"] as? String) == "10B"){
                    self.studentNameList.append(snapshot.key)
                    self.studentAddressList.append((item["address"] as! String) + ", " + (item["city"] as! String) + ", " + (item["state"] as! String))
                    self.studentPhoneList.append(item["phone"] as! String)
                    self.studentBirthdayList.append(item["birthday"] as! String)
                    self.studentTableView.reloadData()
                }
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
