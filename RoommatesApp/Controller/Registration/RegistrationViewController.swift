//
//  RegistrationViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 23/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    var delegate:JoiningViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
      NotificationCenter.default.addObserver(self, selector: #selector(dismissStoryBoard), name: NSNotification.Name("dismissRegestrationStoryboard"), object: nil)
    }
    
    @objc func dismissStoryBoard(){
      //  self.removeFromParent()
           self.dismiss(animated: true)
       // self.navigationController.
        
           
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