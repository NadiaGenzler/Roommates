//
//  CreatedGroupDialogViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 28/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit

class CreatedGroupDialogViewController: UIViewController {

    @IBOutlet weak var message: UILabel!
    var apartmentName:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        message.text="\(apartmentName) \nwas Created Successfully!"
        
    }
    


}
