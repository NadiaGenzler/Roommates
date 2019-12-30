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
        return "name: \(name)"
    }
    

    init(name:String,phoneNumber:String,password:String) {
        self.name=name
        self.phoneNumber=phoneNumber
        self.password=password
    }
    
    var apartmentKey:String?
    var tenantKey:String?
    let name:String
//    var photo:UIImage
//    var userColor:UIColor
    var phoneNumber:String
    var password:String
//    var tasks:[Task]
  
    
    init(fromDictionary:[String:Any]){
        
        self.name=fromDictionary["name"] as! String
        self.tenantKey=fromDictionary["tenantKey"] as? String ?? nil
        self.apartmentKey=fromDictionary["apartmentKey"] as? String ?? nil
        self.phoneNumber=fromDictionary["phoneNumber"] as! String
        self.password=fromDictionary["password"] as! String
        
    }
    
    func toDictionary()->[String:Any]{
        var dict: Dictionary<String,Any>=[:]
        dict["name"]=name
        dict["tenantKey"]=tenantKey
        dict["apartmentKey"]=apartmentKey
        dict["phoneNumber"]=phoneNumber
        dict["password"]=password
        
        return dict
    }
    
    
}
