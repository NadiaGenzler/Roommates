//
//  ContainerViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 21/01/2020.
//  Copyright © 2020 NadiaGenzler. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(openSideMenu), name: NSNotification.Name("openMenu"), object: nil)
        
    }
    
    @objc func openSideMenu(){
       
        sideMenuConstraint.constant = sideMenuConstraint.constant == -240 ? 0 : -240
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }

    }


}
