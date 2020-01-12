//
//  TasksViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 23/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {

    @IBAction func addList(_ sender: UIBarButtonItem) {
        let alert=UIAlertController(title: "Add Task", message: "", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder="Write your task here"
            
        }
        
//        alert.addAction(.init(title: "Add", style: .default, handler: { (action) in
//            <#code#>
//        }))
        
        present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
extension TasksViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "taskCell") as! TaskTableViewCell
        
        cell.taskText.text="dddd"
        return cell
    }
    
    
}
