//
//  CreatedGroupDialogViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 28/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit

class CreatedGroupDialogViewController: UIViewController {

    //let firebase=FirebaseHelper.shared

    @IBOutlet weak var message: UILabel!
    var apartmentKey:String = ""
    var apartmentName:String = ""
    var delegate:CreatingGroupViewController?
    
    @IBAction func continueRegestration(_ sender: UIButton) {

        let joinController=storyboard?.instantiateViewController(withIdentifier: "joinVC") as! JoiningViewController
        joinController.modalPresentationStyle = .overFullScreen
        joinController.modalTransitionStyle = .coverVertical
        joinController.apartmentKey=apartmentKey
        joinController.apartmentName=apartmentName
       present(joinController, animated: true)

        
//        delegate?.creationVC?.dismiss(animated: true, completion: {
//            self.
//        })
      //  delegate?.creationVC?.dismiss(animated: true)
      //  performSegue(withIdentifier: "joinVC", sender: nil)
//        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            guard let dest=segue.destination as? JoiningViewController else {return}
//            dest.apartmentName=apartmentName
//            dest.apartmentKey=apartmentKey
//        }
    }
   

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let dest=segue.destination as? JoiningViewController else {return}
//        dest.apartmentName=apartmentName
//        dest.apartmentKey=apartmentKey
//    }
    
    @IBAction func inviteRoommates(_ sender: UIButton) {
        //connect to whatsapp and pass the name and key of the apartment
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        message.text="\(apartmentName) \nwas Created Successfully!"
        
    }
    


}
