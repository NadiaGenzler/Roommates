//
//  ViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 14/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var nav:UIViewController?
    var firebase=FirebaseHelper.shared
    var util=Utilities.shared
    
   func showStoryboard(){

    var regestrationStoryBoard=UIStoryboard(name: "Registration", bundle: Bundle.main)
    nav=regestrationStoryBoard.instantiateViewController(identifier: "registrationSb") as! UIViewController
    if let nav=nav{
    show(nav, sender: nil)
    }
//    NotificationCenter.default.addObserver(self, selector: <#T##Selector#>, name: <#T##NSNotification.Name?#>, object: <#T##Any?#>)
   }
    
    @objc func dismissStoryBoard(){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.barTintColor=UIColor.white

        
        
//        var event=MyEvent(eventName: "go2", eventDescription: "Go to the woods ", startDate: Date(year: 2020, month: 01, day: 20, hour: 14, minute: 00, second: 00), endDate: Date(year: 2020, month: 01, day: 20, hour: 20, minute: 00, second: 00))
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

