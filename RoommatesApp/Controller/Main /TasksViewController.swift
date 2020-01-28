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
    var tasksArr:[Task]?
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func openMenu(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: NSNotification.Name("openMenu"), object: nil)
        //make the parent view and the tableview darker
      //  self.view.backgroundColor=UIColor.lightGray
    }
    
    @IBAction func addList(_ sender: UIBarButtonItem) {
        taskPopover(sender, [:])
       // tableView.insertRows(at: [indexPath], with: .automatic)
        
    }
    
    func taskPopover(_ sender : Any, _ tasksProperties:[String:Any]){
        
        let popoverTaskVC=storyboard?.instantiateViewController(identifier: "taskEditor") as! EditTaskViewController
        popoverTaskVC.modalPresentationStyle = .overCurrentContext
        if sender is UIBarButtonItem{
            popoverTaskVC.senderIdentifier="addNewTask"
        }else{
            popoverTaskVC.senderIdentifier="endExistingTask"
            popoverTaskVC.tasksProperties=tasksProperties
        }
        present(popoverTaskVC, animated: true)
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firebase.fetchTaskData(apartmentKey: UserDefaults.standard.string(forKey: "apartmentKey")!) { (tasks) in
            self.tasksArr=tasks
            self.tableView.reloadData()
        }
        
    }
    
    
    

@objc func handleSingleTap(_ sender:UITapGestureRecognizer){
    
    let cell=sender.view as! TaskTableViewCell
    
    let checkMark=cell.chekmark
    let textL=cell.taskText
    
    if (checkMark?.image==UIImage(systemName: "square")){
        
        checkMark?.image=UIImage(systemName: "checkmark.square")
        cell.tasksProperties["done"]=true
        textL?.attributedText = textL?.text?.strikeThrough()
        textL?.textColor=UIColor.gray
        let stringColor=UserDefaults.standard.string(forKey: "userColorString")
        cell.backgroundColor=util.hexStringToUIColor(stringColor ?? "#ffffff")
        //save done and color in firebase
        
    }else{
        checkMark?.image=UIImage(systemName: "square")
        cell.tasksProperties["done"]=false
        textL?.attributedText = textL?.text?.normal()
        textL?.textColor=UIColor.black
        cell.backgroundColor=UIColor.white
        
    }
    
}
@objc func handelLongPress(_ sender: UILongPressGestureRecognizer){
    var cell=sender.view as! TaskTableViewCell
    taskPopover(sender,cell.tasksProperties)
    
//            cell.isSelected=true
//            cell.delete.isHidden=false
//            cell.update.isHidden=false
//            let deleteTapGesture=UITapGestureRecognizer(target: self, action: #selector(deleteTap(_:)))
//            cell.delete.addGestureRecognizer(deleteTapGesture)
//            let editTapGesture=UITapGestureRecognizer(target: self, action: #selector(editTap(_:)))
//            cell.update.addGestureRecognizer(editTapGesture)
    
    
}
//    @objc func deleteTap(_ sender:UITapGestureRecognizer){
//    }
//    @objc func editTap(_ sender:UITapGestureRecognizer){
//
//    }

}



extension TasksViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "taskCell",for: indexPath)
            as! TaskTableViewCell
        var currentTask=tasksArr?[indexPath.row]
        cell.taskText?.text=currentTask?.taskDescription
        cell.chekmark.image = currentTask?.done==true ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "square")
        //cell.backgroundColor=
        cell.tasksProperties=["taskKey":currentTask?.taskKey,"taskDescription":currentTask?.taskDescription,"isTaskDone":currentTask?.done, "doneByTenant":currentTask?.tenantColor]
        
        let singleTapGestureRecognizer=UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(_:)))
        cell.addGestureRecognizer(singleTapGestureRecognizer)
        
        let longPressGestureRecognizer=UILongPressGestureRecognizer(target: self, action: #selector(handelLongPress(_:)))
        cell.addGestureRecognizer(longPressGestureRecognizer)
        
        // print(tasks?[indexPath.row].title)
        return cell
    }
    
    
    //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //        if editingStyle == .delete{
    //            tableView.deleteRows(at: [indexPath], with: .fade)
    //        }
    //    }
    //
    //
    //    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    //        return true
    //    }
    
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
