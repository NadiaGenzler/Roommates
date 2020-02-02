//
//  MenuViewController.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 22/01/2020.
//  Copyright © 2020 NadiaGenzler. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    let utility=Utilities.shared
    let firebase=FirebaseHelper.shared
    @IBOutlet weak var apartmentName: UILabel!
    @IBOutlet weak var currentUserName: UILabel!
    @IBOutlet weak var userImg: CircularImageView!
    var tenantsArr:[Tenant]=[]
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func logOut(_ sender: UIButton) {
        
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
        show(utility.showRegistrationStoryboard(), sender: nil)
        
    }
    
    @IBAction func leave(_ sender: UIButton) {
   
        firebase.removeTenant(apartmentKey: UserDefaults.standard.string(forKey: "apartmentKey") ?? "", tenantKey: UserDefaults.standard.string(forKey: "tenantKey") ?? "")
        
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
        
         show(utility.showRegistrationStoryboard(), sender: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apartmentName.text=UserDefaults.standard.string(forKey: "apartmentName")
        currentUserName.text=UserDefaults.standard.string(forKey: "name")
        let stringColor=UserDefaults.standard.string(forKey: "userColorString")
        self.view.backgroundColor=utility.hexStringToUIColor(stringColor ?? "#ffffff")
        tableView.backgroundColor=utility.hexStringToUIColor(stringColor ?? "#ffffff")
        
        
        firebase.fetchAllTenantsData(apartmentKey: UserDefaults.standard.string(forKey: "apartmentKey") ?? "") { (tenants) in
            
            var tenantsWithoutCurrent:[Tenant]=[]
            for tenant in tenants{
                if tenant.tenantKey != UserDefaults.standard.string(forKey: "tenantKey"){
                    tenantsWithoutCurrent.append(tenant)
                }
            }
            if tenantsWithoutCurrent.count==0{
                
            }
            self.tenantsArr=tenantsWithoutCurrent
            self.tableView.reloadData()
        }
        
        
        // tableView.heightAnchor=40*tenantsArr.count
        //        }
        
        
    }
    
}

extension MenuViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tenantsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "tenantCell", for: indexPath)
            as! tenantTableViewCell
        if tenantsArr.count==1{
            cell.name.text="You have no roommates"
        }else{
        var tenant=tenantsArr[indexPath.row]
        cell.name.text=tenant.name
        cell.color.backgroundColor=utility.hexStringToUIColor(tenant.userColorString)
        cell.backgroundColor=utility.hexStringToUIColor(UserDefaults.standard.string(forKey: "userColorString") ?? "#ffffff")
        }
        return cell
    }
    
    
    
    
    
}
