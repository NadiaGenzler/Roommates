//
//  NewTaskViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 18/01/2020.
//  Copyright © 2020 NadiaGenzler. All rights reserved.
//

import UIKit

class EditTaskViewController: UIViewController {
    
    
    var firebase=FirebaseHelper.shared
    var utility=Utilities.shared
    var senderIdentifier:String=""
    
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var taskText: UITextView!
    
    @IBOutlet weak var deleteBtn: RoundView!
    
    var tasksProperties:[String:Any]=[:]
    
    @IBAction func saveBtn(_ sender: UIButton) {
//      if the task is new->addTask to firebase
        if senderIdentifier=="addNewTask"{
            var newTask=Task(taskDescription: taskText.text)
            firebase.addTask(apartmentKey: UserDefaults.standard.string(forKey: "apartmentKey")!, task: &newTask)
        }
//      if the task exists->updateTask to firebase
        else{
            var updateTask=Task(taskDescription: tasksProperties["taskDescription"] as? String ?? "", taskKey: tasksProperties["taskKey"] as? String ?? "", done: tasksProperties["done"] as? Bool ?? false, tenantColor: tasksProperties["tenantColor"] as? String ?? "#ffffff")

            firebase.updateTask(apartmentKey: UserDefaults.standard.string(forKey: "apartmentKey")!, taskKey: tasksProperties["taskKey"] as? String ?? "", task: &updateTask)
        }
        
        dismiss(animated: true)
        
    }
    
    
    @IBAction func removeBtn(_ sender: UIButton) {
        let alert=UIAlertController(title: "Are you sure you want to delete?", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            self.firebase.removeTask(apartmentKey: UserDefaults.standard.string(forKey: "apartmentKey")!, taskKey: self.tasksProperties["taskKey"] as! String)
            self.dismiss(animated: true)
        })
        
        alert.addAction(okAction)
        alert.addAction(.init(title: "Cancel", style: .cancel, handler: { (action) in
            self.dismiss(animated: true)
        }))
        
        present(alert, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.view.backgroundColor=utility.hexStringToUIColor(UserDefaults.standard.string(forKey: "userColorString") ?? "#ffffff")
        if senderIdentifier=="addNewTask"{
            header.text="Write new task"
            deleteBtn.isHidden=true
        }else{
            header.text="Edit task"
            taskText.text=tasksProperties["taskDescription"] as? String ?? ""
        }
        
    }
    
    
    
    
}

