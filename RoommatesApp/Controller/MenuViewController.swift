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
    
    var tenantsArr:[Tenant]=[]
    var tenantsWithoutCurrent:[Tenant]=[]
    
    @IBOutlet weak var userImage: CircularImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    //    MARK: User Log Out or Leave and delete
    
    @IBAction func logOut(_ sender: UIButton) {
        let alert=UIAlertController(title: "Already leaving?", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            
            if let appDomain = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: appDomain)
            }
            self.show(self.utility.showRegistrationStoryboard(), sender: nil)
        })
        
        alert.addAction(okAction)
        alert.addAction(.init(title: "Cancel", style: .default, handler: { (action) in
            alert.dismiss(animated: true)
        }))
        present(alert, animated: true)
    }
    
    
    @IBAction func leave(_ sender: UIButton) {
        let alert=UIAlertController(title: "Moving out of the apartment?", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            
            self.firebase.removeTenant(apartmentKey: UserDefaults.standard.string(forKey: "apartmentKey") ?? "", tenantKey: UserDefaults.standard.string(forKey: "tenantKey") ?? "")
            
            if let appDomain = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: appDomain)
            }
            
            self.show(self.utility.showRegistrationStoryboard(), sender: nil)
        })
        
        alert.addAction(okAction)
        alert.addAction(.init(title: "Cancel", style: .default, handler: { (action) in
            alert.dismiss(animated: true)
        }))
        
        present(alert, animated: true)
    }
    
    
    // get the tenants from firebase and get the current users properties from UserDefaults
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pngImgData=UserDefaults.standard.object(forKey: "UserImagePng") as? Data{
            userImage.image = UIImage(data: pngImgData)}
        
        let apartmentKey=UserDefaults.standard.string(forKey: "apartmentKey") ?? ""
        let tenantKey=UserDefaults.standard.string(forKey: "tenantKey") ?? ""
        
        firebase.downloadImage(apartmentKey: apartmentKey, tenantKey: tenantKey) { (data) in
            self.userImage.image=UIImage(data: data)
        }
        
        apartmentName.text=UserDefaults.standard.string(forKey: "apartmentName")
        currentUserName.text=UserDefaults.standard.string(forKey: "name")
        let stringColor=UserDefaults.standard.string(forKey: "userColorString")
        self.view.backgroundColor=utility.hexStringToUIColor(stringColor ?? "#ffffff")
        tableView.backgroundColor=utility.hexStringToUIColor(stringColor ?? "#ffffff")
        
        
        
        firebase.fetchAllTenantsData(apartmentKey: apartmentKey) { (tenants) in
            self.tenantsArr=tenants
            
            for tenant in tenants{
                if tenant.tenantKey != tenantKey{
                    self.tenantsWithoutCurrent.append(tenant)
                }
            }
            self.tableView.reloadData()
        }
    }
    
}


extension MenuViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tenantsArr.count==1{
            return tenantsArr.count
        }
        return tenantsArr.count-1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "tenantCell", for: indexPath)
            as! tenantTableViewCell
        if tenantsArr.count==1{
            cell.name.text="You have no roommates"
            cell.backgroundColor=utility.hexStringToUIColor(UserDefaults.standard.string(forKey: "userColorString") ?? "#ffffff")
            cell.color.isHidden=true
        }else{
            let tenant=tenantsWithoutCurrent[indexPath.row]
            cell.name.text=tenant.name
            cell.color.backgroundColor=utility.hexStringToUIColor(tenant.userColorString)
            cell.backgroundColor=utility.hexStringToUIColor(UserDefaults.standard.string(forKey: "userColorString") ?? "#ffffff")
        }
        return cell
    }
    
    
    
    
    
}
