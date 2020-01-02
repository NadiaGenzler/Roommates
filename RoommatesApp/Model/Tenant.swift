//
//  Roommate.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 14/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit

class Tenant:CustomStringConvertible {
    var description: String {
        return "name: \(name), phoneNumber: \(phoneNumber), password: \(password), userColorString: \(userColorString) "
    }
    

    init(name:String,phoneNumber:String,password:String, userColorString:String) {
        self.name=name
        self.phoneNumber=phoneNumber
        self.password=password
        self.userColorString=userColorString
    }
    
    // remember that my color is string
    
    var apartmentKey:String?
    var tenantKey:String?
    let name:String
//    var userPhoto:UIImage
    var userColorString:String?
    var phoneNumber:String
    var password:String
//    var tasks:[Task]
  
    
    init(fromDictionary:[String:Any]){
        
        self.name=fromDictionary["name"] as! String
        self.tenantKey=fromDictionary["tenantKey"] as? String ?? nil
        self.apartmentKey=fromDictionary["apartmentKey"] as? String ?? nil
        self.phoneNumber=fromDictionary["phoneNumber"] as! String
        self.password=fromDictionary["password"] as! String
        self.userColorString=fromDictionary["userColor"] as? String
        
    }
    
    func toDictionary()->[String:Any]{
        var dict: Dictionary<String,Any>=[:]
        dict["name"]=name
        dict["tenantKey"]=tenantKey
        dict["apartmentKey"]=apartmentKey
        dict["phoneNumber"]=phoneNumber
        dict["password"]=password
        dict["userColor"]=userColorString
        
        return dict
    }
    
    
}
