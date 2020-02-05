//
//  CreatingGroupViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 14/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit

class CreatingGroupViewController: UIViewController{
    
    @IBOutlet weak var groupName: UITextField!
    
    let firebase=FirebaseHelper.shared
    var apartmentKey:String?
    var apartmentName:String?
    var apartmentsArr:[Apartment]=[]
    
    @IBOutlet weak var errorLable: UILabel!
    
    @IBAction func create(_ sender: UIButton) { //add function tha cheks that the fields are not empty
        self.errorLable.isHidden=true
        for i in 0..<apartmentsArr.count{
            
            // cheks if the apartment already exists
            if apartmentsArr[i].name == self.groupName.text?.trimmingCharacters(in: .whitespaces){
                self.errorLable.isHidden=false
                return
            }else if i==apartmentsArr.count-1{
                var apartment=Apartment(name: self.groupName.text!.trimmingCharacters(in: .whitespaces), tenants: [], tasks: [], events: [])
                self.firebase.addApartment(apartment: &apartment) { (apartmentKey, name) in
                    self.apartmentKey=apartmentKey
                    self.apartmentName=name
                }
                
                createdSuccessfuly()//present and after 2 secs dismiss

                groupName.isEnabled=false
                DispatchQueue.main.asyncAfter(deadline: .now() + 2 ) {
                    let joinController=self.storyboard?.instantiateViewController(withIdentifier: "joinVC") as! JoiningViewController
//                    joinController.apartmentKey=self.apartmentKey
                    joinController.apartmentName=self.apartmentName
                    self.show(joinController,sender: nil)
                }
           
            }
            
        }
        
    }
    

    func createdSuccessfuly(){
        var creationVC=self.storyboard?.instantiateViewController(identifier: "successfulCreation") as! CreatedGroupDialogViewController
   
        creationVC.modalPresentationStyle = .overFullScreen
        creationVC.modalTransitionStyle = .coverVertical
        creationVC.apartmentName=self.apartmentName ?? "0name"
        
        self.present(creationVC,animated: true, completion: nil)
       DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
        creationVC.dismiss(animated: true)
        })
        
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firebase.fetchAllApartmentsData { (apartments) in
            self.apartmentsArr=apartments
        }
        
        groupName.delegate=self
        
    }
}


extension CreatingGroupViewController:UITextFieldDelegate{
//            func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//                let text=textField.text!
//
//                return  text.count<3 || text.isEmpty
//            }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
