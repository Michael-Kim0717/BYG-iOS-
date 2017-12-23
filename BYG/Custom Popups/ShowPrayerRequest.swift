//
//  ShowPrayerRequest.swift
//  BYG
//
//  Created by Michael Kim on 12/22/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import UIKit

class ShowPrayerRequest: UIViewController {

    // Variable Declarations.
    var name: String?
    var date: String?
    var grade: String?
    var pr: String?
    
    @IBOutlet weak var prView: UIView!
    @IBAction func dismissPopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var studentLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var prLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prView.layer.cornerRadius = 10
        prView.layer.masksToBounds = true
        // Do any additional setup after loading the view.
        
        studentLabel.text = name
        gradeLabel.text = grade
        dateLabel.text = date
        prLabel.text = pr
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
