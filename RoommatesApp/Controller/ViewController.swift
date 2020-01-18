//
//  ViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 14/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
       var firebase=FirebaseHelper.shared
    var tenantsArr:[Tenant]=[]
    var tasksArr=[Task(title: "wash the dishes", body: "with sponge", done: true)]
    var eventArr:[MyEvent]=[]
   
    
   func showStoryboard(){
       let sb=UIStoryboard(name: "Registration", bundle: Bundle.main)
       let nav=sb.instantiateViewController(identifier: "registrationSb")
       
    show(nav, sender: nil)
   }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        var t = Tenant(name: "nhhh")
//        FirebaseHelper.shared.addTenant(apartmentKey: "-Lx0lGNvQu6ggnCJDtgX", tenant: &t)
        
//        FirebaseHelper.shared.removeTenant(apartmentKey: "-Lx0lGNvQu6ggnCJDtgX", tenantKey: "-Lx11t5IIMz6PIbTm6LF")
        

//        FirebaseHelper.shared.addTask(apartmentKey: "-Lx0lGNvQu6ggnCJDtgX", task: &task)
//        
//        var task=Task(title: "wash the dishes", body: "with sponge", done: true)
//        FirebaseHelper.shared.addTask(apartmentKey: "-Lx0lGNvQu6ggnCJDtgX", task: &task)
        
        
//        var event=MyEvent(eventName: "gogogogo", eventDescription: "Go shopping ", startDate: Date(year: 2020, month: 01, day: 14, hour: 14, minute: 00, second: 00), endDate: Date(year: 2020, month: 01, day: 14, hour: 20, minute: 00, second: 00))
//        firebase.addEvent(apartmentKey: "-Lx0lGNvQu6ggnCJDtgX", event: &event)
        
     
        firebase.fetchApartmentData(apartmentKey: "-Lx0lGNvQu6ggnCJDtgX") { (apartment) in
            
            print(apartment)
            
        }
//        firebase.fetchTaskData(apartmentKey: "-Lx0lGNvQu6ggnCJDtgX") { (tasks) in
//
////                for task in tasks{
////                    self.tasksArr.append(task)
////                   // print(self.tasksArr)
////
////                }
//            self.tasksArr=tasks
//        }
        
                firebase.fetchEventData(apartmentKey: "-Lx0lGNvQu6ggnCJDtgX") { (events) in
        
                 for event in events{
                     self.eventArr.append(event)
                    // print(self.tasksArr)
                     
                 }
        
                       }
        
//        func uploadImage(url:URL){
//                let imagesRef = storageRef.child("imagess/user.jpg")
//                print(imagesRef)
//      
//                let uploadTask=imagesRef.putFile(from: url)
//            }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showStoryboard()
    }
    

}

