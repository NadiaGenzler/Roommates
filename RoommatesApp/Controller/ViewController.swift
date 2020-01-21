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
   // var tenantsArr:[Tenant]=[]
  //  var tasksArr=[Task(body: "with sponge", done: true)]
   // var eventArr:[MyEvent]=[]
    var util=Utilities.shared
    
   func showStoryboard(){
       let sb=UIStoryboard(name: "Registration", bundle: Bundle.main)
       let nav=sb.instantiateViewController(identifier: "registrationSb")
       
    show(nav, sender: nil)
   }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.barTintColor=UIColor.white

        
        
//        var event=MyEvent(eventName: "gogogogo", eventDescription: "Go shopping ", startDate: Date(year: 2020, month: 01, day: 14, hour: 14, minute: 00, second: 00), endDate: Date(year: 2020, month: 01, day: 14, hour: 20, minute: 00, second: 00))
//        firebase.addEvent(apartmentKey: "-Lx0lGNvQu6ggnCJDtgX", event: &event)
        
     
       
    
        
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

