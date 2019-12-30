//
//  ViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 14/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        
    
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
        
        FirebaseHelper.shared.fetchApartmentData(apartmentKey: "-Lx0lGNvQu6ggnCJDtgX") { (apartment) in

            print(apartment)

        }
        

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showStoryboard()
    }
    

}

