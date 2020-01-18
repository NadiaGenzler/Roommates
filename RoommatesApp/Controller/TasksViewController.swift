//
//  TasksViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 23/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit
import Firebase

class TasksViewController: UIViewController  {

    
    var firebase=FirebaseHelper.shared
    var delegate:TaskTableViewCell?
    var tasks:[Task]?
    var util=Utilities.shared

   // @IBOutlet weak var checkMark: UIImageView!
    
    
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
  
//       firebase.fetchTaskData(apartmentKey: "-Lx0lGNvQu6ggnCJDtgX") { (tasks) in
//
//                      for task in tasks{
//                          self.tasksArr.append(task)
//                         // print(self.tasksArr)
//
//                      }
//              }
 
    }
    
    @objc func handleSingleTap(_ sender:UITapGestureRecognizer){
        
        let cell=sender.view as! TaskTableViewCell

        let checkMark=cell.chekmark
        let textL=cell.taskText
    
        if (checkMark?.image==UIImage(systemName: "square")){
            
            checkMark?.image=UIImage(systemName: "checkmark.square")
            textL?.attributedText = textL?.text?.strikeThrough()
            textL?.textColor=UIColor.gray
            cell.backgroundColor=util.hexStringToUIColor("#ffccff")
            
        }else{
            checkMark?.image=UIImage(systemName: "square")
            textL?.attributedText = textL?.text?.normal()
            textL?.textColor=UIColor.black
            cell.backgroundColor=UIColor.white
            
        }
         
    }
    @objc func handelLongPress(_ sendr: UILongPressGestureRecognizer){
        
    }
}



extension TasksViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          
        return 2
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell=tableView.dequeueReusableCell(withIdentifier: "taskCell",for: indexPath)
        as! TaskTableViewCell
       
        //cell.taskText?.text=tasks?[indexPath.row].title
        cell.taskText?.text="AbcgD"
        cell.chekmark.image=UIImage(systemName: "square")
        
        let singleTapGestureRecognizer=UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(_:)))
        cell.addGestureRecognizer(singleTapGestureRecognizer)
        let longPressGestureRecognizer=UILongPressGestureRecognizer(target: self, action: #selector(handelLongPress(_:)))
        cell.addGestureRecognizer(longPressGestureRecognizer)
        
          // print(tasks?[indexPath.row].title)
           return cell
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell=tableView.dequeueReusableCell(withIdentifier: "taskCell",for: indexPath)
         as! TaskTableViewCell
        

    }
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let cell=tableView.dequeueReusableCell(withIdentifier: "taskCell",for: indexPath)
//         as! TaskTableViewCell
//        cell.contentView.backgroundColor=UIColor.white
//        print("deselected")
//    }
   
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
    
    
    
}


extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0,attributeString.length))
  
        return attributeString
    }
    func normal() -> NSAttributedString {
          let attributeString =  NSMutableAttributedString(string: self)
        attributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
    
          return attributeString
      }
    
}
