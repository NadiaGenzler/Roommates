//
//  ContainerViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 21/01/2020.
//  Copyright © 2020 NadiaGenzler. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    @IBOutlet weak var grayView: UIView!
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var mainContainerView: UIView!
    
    //handle the opening and closing of the menu
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        grayView.isHidden=true
        NotificationCenter.default.addObserver(self, selector: #selector(openSideMenu), name: NSNotification.Name("openMenu"), object: nil)
        
        
        let leftSwipe=UISwipeGestureRecognizer(target: self, action: #selector(closeSideMenu(_:)))
        leftSwipe.direction = .left
        self.children[1].view.addGestureRecognizer(leftSwipe)
        
    }
    
    @objc func openSideMenu(){
        sideMenuConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        grayView.isHidden=false
    }
    
    @objc func closeSideMenu(_ sender: UISwipeGestureRecognizer) {
        if(sender.direction == .left){
            sideMenuConstraint.constant = -240
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
            
        }
        grayView.isHidden=true
        
        
        
    }
    
}
