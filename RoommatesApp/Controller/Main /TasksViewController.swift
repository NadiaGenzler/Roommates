//
//  TasksViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 23/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit
import Firebase

class TasksViewController: UIViewController , UIPopoverPresentationControllerDelegate {
    
    var firebase=FirebaseHelper.shared
    var util=Utilities.shared
    var tasksArr:[Task]=[]
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func openMenu(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: NSNotification.Name("openMenu"), object: nil)
    }
    
    
    func taskPopover(_ sender : Any, _ tasksProperties:[String:Any]){
        
        let popoverTaskVC=storyboard?.instantiateViewController(identifier: "taskEditor") as! EditTaskViewController

        if sender is UIBarButtonItem{
            popoverTaskVC.senderIdentifier="addNewTask"
        }else{
            popoverTaskVC.senderIdentifier="endExistingTask"
            popoverTaskVC.tasksProperties=tasksProperties
        }
        present(popoverTaskVC, animated: true)
    }
    
    @IBAction func addList(_ sender: UIBarButtonItem) {
        taskPopover(sender, [:])
    }
    
    //    MARK: Fetch the tasks from firebase
    override func viewDidLoad() {
        super.viewDidLoad()
  
        firebase.fetchAllTasksData(apartmentKey: UserDefaults.standard.string(forKey: "apartmentKey")!) { (tasks) in
            var sortedTasks=tasks.sorted { (t1, t2) -> Bool in
                return t1.taskDescription<t2.taskDescription
            }

            self.tasksArr=sortedTasks
            self.tableView.reloadData()
        }
        
    }
    
   
    @objc func handleSingleTap(_ sender:UITapGestureRecognizer){
        
        let cell=sender.view as! TaskTableViewCell
       
        var tappedTaskProperties=cell.tasksProperties
        
        if (tappedTaskProperties["isTaskDone"] as! Bool==false){
            tappedTaskProperties["isTaskDone"]=true
            cell.chekmark?.image=UIImage(systemName: "checkmark.square")
          //  cell.taskText?.attributedText = cell.taskText.text?.strikeThrough()
            cell.taskText?.textColor=UIColor.gray
            let stringColor=UserDefaults.standard.string(forKey: "userColorString")
            cell.backgroundColor=util.hexStringToUIColor(stringColor ?? "#ffffff")
            tappedTaskProperties["doneByTenant"]=stringColor ?? "#ffffff"
            //save done and color in firebase
            
        }else if (tappedTaskProperties["isTaskDone"] as! Bool==true){
            tappedTaskProperties["isTaskDone"]=false
            cell.chekmark?.image=UIImage(systemName: "square")
            tappedTaskProperties["doneByTenant"]="#ffffff"
            //cell.taskText?.attributedText = cell.taskText?.text?.normal()
            cell.taskText?.textColor=UIColor.black
            cell.backgroundColor=UIColor.white
            
        }
        
        var updatedTask=Task(taskDescription: tappedTaskProperties["taskDescription"] as! String, taskKey: tappedTaskProperties["taskKey"] as! String, done: tappedTaskProperties["isTaskDone"] as? Bool ?? false, tenantColor: tappedTaskProperties["doneByTenant"] as! String)
        firebase.updateTask(apartmentKey: UserDefaults.standard.string(forKey: "apartmentKey")!, taskKey: tappedTaskProperties["taskKey"] as! String, task: &updatedTask)
     
    }
    @objc func handelLongPress(_ sender: UILongPressGestureRecognizer){
        let cell=sender.view as! TaskTableViewCell
        taskPopover(sender,cell.tasksProperties)
//        
//        //            cell.isSelected=true
//        //            cell.delete.isHidden=false
//        //            cell.update.isHidden=false
//        //            let deleteTapGesture=UITapGestureRecognizer(target: self, action: #selector(deleteTap(_:)))
//        //            cell.delete.addGestureRecognizer(deleteTapGesture)
//        //            let editTapGesture=UITapGestureRecognizer(target: self, action: #selector(editTap(_:)))
//        //            cell.update.addGestureRecognizer(editTapGesture)
//        
//        
    }
//    //    @objc func deleteTap(_ sender:UITapGestureRecognizer){
//    //    }
//    //    @objc func editTap(_ sender:UITapGestureRecognizer){
//    //
//    //    }
//    
}

extension TasksViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "taskCell",for: indexPath)
            as! TaskTableViewCell
        let currentTask=tasksArr[indexPath.row]
        cell.tasksProperties=["taskKey":currentTask.taskKey,"taskDescription":currentTask.taskDescription,"isTaskDone":currentTask.done, "doneByTenant":currentTask.tenantColor ?? "#ffffff"]
        
        let taskProperties=cell.tasksProperties
        
        cell.taskText?.text=taskProperties["taskDescription"] as? String ?? ""
        
        if (taskProperties["isTaskDone"] as? Bool==true){
            
            cell.chekmark.image=UIImage(systemName: "checkmark.square")
//            cell.taskText?.attributedText = cell.taskText?.text?.strikeThrough()
            cell.taskText?.textColor=UIColor.gray
            cell.backgroundColor=util.hexStringToUIColor(taskProperties["doneByTenant"] as? String ?? "#ffffff")
            
        }
        else {
            cell.chekmark.image=UIImage(systemName: "square")
//            cell.taskText?.attributedText = cell.taskText?.text?.normal()
            cell.taskText?.textColor=UIColor.black
            cell.backgroundColor=UIColor.white
            
        }
    
        
        let singleTapGestureRecognizer=UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(_:)))
        cell.addGestureRecognizer(singleTapGestureRecognizer)
        
        let longPressGestureRecognizer=UILongPressGestureRecognizer(target: self, action: #selector(handelLongPress(_:)))
        cell.addGestureRecognizer(longPressGestureRecognizer)
        
        return cell
    }
    
    
}


extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0,attributeString.length))
        
        return attributeString
    }
    
    func normal() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
        
        return attributeString
    }
}
