//
//  LogInViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 21/01/2020.
//  Copyright © 2020 NadiaGenzler. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    var firebase=FirebaseHelper.shared
    
    @IBOutlet weak var tenantName: UITextField!
    
    @IBOutlet weak var tenantPassword: UITextField!
    
    @IBAction func logInButton(_ sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        firebase.fetchAllApartmentsData { (apartments) in
            for apartment in apartments{
                
            }
        }
      
    }
    

    

}
