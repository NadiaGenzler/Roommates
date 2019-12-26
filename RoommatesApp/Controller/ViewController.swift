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

       
        

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showStoryboard()
    }
    

}

