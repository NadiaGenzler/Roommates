//
//  CreatedGroupDialogViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 28/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit

class CreatedGroupDialogViewController: UIViewController {

    let firebase=FirebaseHelper.shared
    @IBOutlet weak var apartmentKey: UILabel!
    var apartmentKeyS:String = ""
    
    @IBAction func continiueRegestration(_ sender: UIButton) {
    }
    
    @IBAction func inviteRoommates(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        firebase.fetchApartmentData(apartmentKey: <#T##String#>, complition: <#T##(Apartment) -> Void#>)
//        apartmentKey.text=apartmentKeyS
        
    }
    


}
