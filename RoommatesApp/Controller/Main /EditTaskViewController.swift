//
//  NewTaskViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 18/01/2020.
//  Copyright © 2020 NadiaGenzler. All rights reserved.
//

import UIKit

class EditTaskViewController: UIViewController {
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    var firebase=FirebaseHelper.shared
    @IBOutlet weak var taskText: UITextView!
    
    @IBAction func saveBtn(_ sender: UIButton) {
        var updateTask=Task(body: taskText.text, taskKey: "-Lyt0sTImemC3P5jjghd")
        firebase.updateTask(apartmentKey: "-Lx0lGNvQu6ggnCJDtgX", taskKey: "-Lyt0sTImemC3P5jjghd", task: &updateTask)
        
        
        dismiss(animated: true)
        
    }
    
    @IBAction func removeBtn(_ sender: UIButton) {
        let alert=UIAlertController(title: "Are you sure you want to delete?", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            print("Ok Tapped")//need to delete
        })
        
        alert.addAction(okAction)
        
        alert.addAction(.init(title: "Cancel", style: .destructive, handler: { (action) in
            self.dismiss(animated: true)
            
        }))
        
        present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
}

