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
    
//    MARK: Storyboard Launch
    
// Checks if there is information in the UserDefaults and decides which storyboard to launch
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserDefaults.standard.string(forKey: "apartmentKey") == nil{
            show(utility.showRegistrationStoryboard(), sender: nil)
            
        }else{
            show(utility.showMainStoryboard(), sender: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
