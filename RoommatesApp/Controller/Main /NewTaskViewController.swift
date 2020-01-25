//
//  EditTaskViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 18/01/2020.
//  Copyright © 2020 NadiaGenzler. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController {
    
    var firebase=FirebaseHelper.shared

    @IBOutlet weak var taskText: UITextView!
    
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    @IBAction func saveBtn(_ sender: UIButton) {
        var newTask=Task(body: taskText.text)
        firebase.addTask(apartmentKey: "-Lx0lGNvQu6ggnCJDtgX", task: &newTask)
        
        dismiss(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }

}


