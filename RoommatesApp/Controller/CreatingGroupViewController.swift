//
//  CreatingGroupViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 14/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit

class CreatingGroupViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var groupName: UITextField!
    
    let fireBase=FirebaseHelper.shared
//    var apartment:Apartment?
    // figur out how to pass the key to the popover
    @IBAction func create(_ sender: UIButton) {
       var apartment=Apartment(name: groupName.text!, tenants: [], tasks: [], events: [])
        
//        guard var apartment=apartment else {return}
       
        fireBase.addApartment(apartment: &apartment )
       
        let creationVC=storyboard?.instantiateViewController(identifier: "successfulCreation") as! CreatedGroupDialogViewController
        creationVC.modalPresentationStyle = .overCurrentContext
//        creationVC.apartmentKey.text=apartment.apartmentKey ?? "hh"
//        print(apartment.apartmentKey ?? "hh")
//        if let popoverPresentanionContoller=creationVC.popoverPresentationController{
//            popoverPresentanionContoller.delegate=self
//
//        }
        
        
        present(creationVC,animated: true, completion: nil)
    
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        // Return no adaptive presentation style, use default presentation behaviour
        return .none
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let dest=segue.description as? CreatedGroupDialogViewController else {return}
//        print(apartment?.apartmentKey ?? "hh")
//        dest.apartmentKeyS=apartment?.apartmentKey ?? "dd"
//    }
    
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
