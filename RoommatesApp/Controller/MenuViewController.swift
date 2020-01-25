//
//  MenuViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 22/01/2020.
//  Copyright © 2020 NadiaGenzler. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    let utility=Utilities.shared
    @IBOutlet weak var apartmentName: UILabel!
    @IBOutlet weak var currentUserName: UILabel!
    @IBOutlet weak var userImg: CircularImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apartmentName.text=UserDefaults.standard.string(forKey: "apartmentName")
        currentUserName.text=UserDefaults.standard.string(forKey: "name")
        let stringColor=UserDefaults.standard.string(forKey: "userColorString")
        self.view.backgroundColor=utility.hexStringToUIColor(stringColor ?? "#ffffff")
    }
 
    //        UserDefaults.standard.string(forKey: "apartmentKey")
    //        UserDefaults.standard.string(forKey: "tenantKey")
    //        UserDefaults.standard.string(forKey: "password")

}
