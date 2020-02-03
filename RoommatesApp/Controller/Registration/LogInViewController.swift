//
//  LogInViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 21/01/2020.
//  Copyright © 2020 NadiaGenzler. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    var firebase=FirebaseHelper.shared
    var utility=Utilities.shared
    var apartmentsArr:[Apartment]=[]
    @IBOutlet weak var tenantName: UITextField!
    @IBOutlet weak var tenantPassword: UITextField!
    @IBOutlet weak var errorLable: UILabel!
    
    @IBAction func logInButton(_ sender: UIButton) {
        
        for i in 0..<apartmentsArr.count{
            let tenantsInApartment=apartmentsArr[i].tenants
            
            if tenantsInApartment.count != 0{
            for j in 0..<tenantsInApartment.count{
                let tenant=tenantsInApartment[j]
                if tenant.name==self.tenantName.text && tenant.password==self.tenantPassword.text{
                    
                    self.firebase.fetchTenantData(apartmentKey: tenant.apartmentKey, tenantKey: tenant.tenantKey ?? "") { (currentTenant) in
                        
                        UserDefaults.standard.set(self.apartmentsArr[i].name, forKey: "apartmentName")
                        
                        UserDefaults.standard.set(currentTenant.apartmentKey, forKey: "apartmentKey")
                        UserDefaults.standard.set(currentTenant.tenantKey, forKey: "tenantKey")
                        
                        UserDefaults.standard.set(currentTenant.name, forKey: "name")
                        UserDefaults.standard.set(currentTenant.password, forKey: "password")
                        UserDefaults.standard.set(currentTenant.userColorString, forKey: "userColorString")
                        
                        
                        let nav=self.utility.showMainStoryboard()
                        nav.modalPresentationStyle = .overFullScreen
                        nav.modalTransitionStyle = .coverVertical
                        self.present(nav,animated: true)
                    }
                    return
                    
                }else if i==apartmentsArr.count-1 && j == tenantsInApartment.count-1{
                    self.errorLable.isHidden=false
                }
            }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firebase.fetchAllApartmentsData { (apartments) in
            self.apartmentsArr=apartments
        }
        
    }
    
    
    
    
}
