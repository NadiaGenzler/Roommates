//
//  CreatingGroupViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 14/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit

class CreatingGroupViewController: UIViewController, UIPopoverPresentationControllerDelegate {
// if no tenet subscribes, group will be eliminated within 3 days
    @IBOutlet weak var groupName: UITextField!
    
    let fireBase=FirebaseHelper.shared
    var apartmentKey:String?
    var apartmentName:String?
    var creationVC:CreatedGroupDialogViewController?
    
    @IBAction func create(_ sender: UIButton) {
        
        //add function tha cheks that the fields are not empty
     var apartment=Apartment(name: groupName.text!, tenants: [], tasks: [], events: [])
    
        fireBase.addApartment(apartment: &apartment) { (apartmentKey, name) in
                self.apartmentKey=apartmentKey
                self.apartmentName=name
        }
        
        creationVC=storyboard?.instantiateViewController(identifier: "successfulCreation") as! CreatedGroupDialogViewController
        
        if let creationVC=creationVC {
            creationVC.modalPresentationStyle = .overFullScreen
            creationVC.modalTransitionStyle = .coverVertical
        creationVC.apartmentKey=apartmentKey ?? "0key"
        creationVC.apartmentName=apartmentName ?? "0name"
            creationVC.delegate=self
      
        
        present(creationVC,animated: true, completion: nil)
        }
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
