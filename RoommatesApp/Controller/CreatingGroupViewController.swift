//
//  CreatingGroupViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 14/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit

class CreatingGroupViewController: UIViewController {

    @IBOutlet weak var groupName: UITextField!
    @IBOutlet weak var groupId: UITextField!
    let fireBase=FirebaseHelper.shared
    @IBAction func create(_ sender: UIButton) {
        
        fireBase.addApartment(apartment: Apartment(name: groupName.text!, key: groupId.text!, tenants: [], tasks: []))
        
//        let createdAlert = UIAlertController(title: "Group Created Successfuly!",
//                                               message: "",
//                                               preferredStyle: .alert)
//
//        createdAlert.addAction(.init(title: "Invite Roommates", style: .default, handler: { (action) in
//            print("invite Tapped")
//        }))
//        createdAlert.addAction(.init(title: "Continue to regestration", style: .default, handler: { (action) in
//            print("continue Tapped")
//        }))
//
//        present(createdAlert, animated: true)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        groupId.delegate=self
        groupName.delegate=self
        
    }
    


}
extension CreatingGroupViewController:UITextFieldDelegate{
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let text=textField.text!
//
//        return   && text.count<3 || text.isEmpty
//    }
    
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
