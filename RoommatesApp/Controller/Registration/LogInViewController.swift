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
    
    @IBOutlet weak var tenantName: UITextField!
    
    @IBOutlet weak var tenantPassword: UITextField!
    @IBOutlet weak var errorLable: UILabel!
    
    @IBAction func logInButton(_ sender: UIButton) {
        
        firebase.fetchAllApartmentsData { (apartments) in
            
            for i in 0..<apartments.count{
                let tenantsInApartment=apartments[i].tenants
                
                if tenantsInApartment.count != 0{
                    for j in 0..<tenantsInApartment.count{
                        let tenant=tenantsInApartment[j]
                        if tenant.name==self.tenantName.text && tenant.password==self.tenantPassword.text{
                            print(tenant.name,tenant.password,tenant.apartmentKey,apartments[i].name)
                            
                            self.firebase.fetchTenantData(apartmentKey: tenant.apartmentKey, tenantKey: tenant.tenantKey ?? "") { (currentTenant) in
                                
//                                UserDefaults.standard.set(apartments[i].name, forKey: "apartmentName")
//
//
//                                UserDefaults.standard.set(currentTenant.apartmentKey, forKey: "apartmentKey")
//                                UserDefaults.standard.set(currentTenant.tenantKey, forKey: "tenantKey")
//
//                                UserDefaults.standard.set(currentTenant.name, forKey: "name")
//                                UserDefaults.standard.set(currentTenant.password, forKey: "password")
//                                UserDefaults.standard.set(currentTenant.userColorString, forKey: "userColorString")
                                
                                NotificationCenter.default.post(name: NSNotification.Name("dismissRegestrationStoryboard"), object: nil)
                            }
                        }
                        else if i==apartments.count-1 && j == tenantsInApartment.count-1{
                            self.errorLable.isHidden=false
                        }
                        
                       // print(tenantsInApartment.count-1)
                        
                        
                        
                        
                        
                    }
                    
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    
    
}
