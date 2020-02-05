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
           self.dismiss(animated: true)
           
       }

}
