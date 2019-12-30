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
        
        apartmentKey.text=apartmentKeyS
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
