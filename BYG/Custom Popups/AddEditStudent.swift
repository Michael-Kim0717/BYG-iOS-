//
//  AddEditStudent.swift
//  BYG
//
//  Created by Michael Kim on 12/21/17.
//  Copyright © 2017 Michael Kim. All rights reserved.
//

import UIKit

class AddEditStudent: UIViewController {

    // Variable Declarations.
    @IBAction func closePopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var popupView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
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
