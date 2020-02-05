//
//  LoadViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 30/01/2020.
//  Copyright © 2020 NadiaGenzler. All rights reserved.
//

import UIKit

class LoadViewController: UIViewController {
    
    let utility=Utilities.shared
    let firebase=FirebaseHelper.shared
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserDefaults.standard.string(forKey: "apartmentKey") != nil{
            show(utility.showMainStoryboard(), sender: nil)
            
        }else{
            show(utility.showRegistrationStoryboard(), sender: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
