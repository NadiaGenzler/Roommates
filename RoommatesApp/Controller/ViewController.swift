//
//  ViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 14/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var nav:UIViewController?
    var firebase=FirebaseHelper.shared
    var util=Utilities.shared
    //var delegate:JoiningViewController?
    
   func showStoryboard(){

    var registrationStoryBoard=UIStoryboard(name: "Registration", bundle: Bundle.main)
//    nav=regestrationStoryBoard.instantiateViewController(identifier: "registrationSb") as! UIViewController
    nav=registrationStoryBoard.instantiateViewController(withIdentifier: "registrationSb") as! UIViewController
    //regestrationStoryBoard.
    
 
    if let nav=nav{
       
    show(nav, sender: nil)
        
    }
    
   }
    
    @objc func dismissStoryBoard(){
      //   nav?.dismiss(animated: true)
        self.nav?.dismiss(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.barTintColor=UIColor.white
        
        NotificationCenter.default.addObserver(self, selector: #selector(dismissStoryBoard), name: NSNotification.Name("dismissRegestrationStoryboard"), object: nil)
     
//        func uploadImage(url:URL){
//                let imagesRef = storageRef.child("imagess/user.jpg")
//                print(imagesRef)
//      
//                let uploadTask=imagesRef.putFile(from: url)
//            }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showStoryboard()
    }
    

}

