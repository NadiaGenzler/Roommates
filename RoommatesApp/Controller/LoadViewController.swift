//
//  LoadViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 30/01/2020.
//  Copyright © 2020 NadiaGenzler. All rights reserved.
//

import UIKit

class LoadViewController: UIViewController {
    
    // var nav:UIViewController?
    let utility=Utilities.shared
    let firebase=FirebaseHelper.shared
    
    //    func showRegistrationStoryboard()->UIViewController{
    //
    //        var registrationStoryBoard=UIStoryboard(name: "Registration", bundle: Bundle.main)
    //       var nav=registrationStoryBoard.instantiateViewController(withIdentifier: "registrationSb") as! UIViewController
    //
    //            show(nav, sender: nil)
    //        return nav
    //
    //    }
    //
    //
    //    func showMainStoryboard()->UIViewController{
    //        var registrationStoryBoard=UIStoryboard(name: "Main", bundle: Bundle.main)
    //        var nav=registrationStoryBoard.instantiateViewController(withIdentifier: "mainStoryboard") as! UIViewController
    //
    //            show(nav, sender: nil)
    //            return nav
    //        }
    
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
