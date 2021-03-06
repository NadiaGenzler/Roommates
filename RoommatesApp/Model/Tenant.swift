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
        return "name: \(name), password: \(password), userColorString: \(userColorString) "
    }
 
    var apartmentKey:String
    var tenantKey:String?
    let name:String
//    var userPhoto:UIImage
    var userColorString:String="#ffffff"
  //  var phoneNumber:String
    var password:String
    var userColor:UIColor{
        return Utilities.shared.hexStringToUIColor(userColorString)
    }
  
    init(apartmentKey:String,name:String,password:String, userColorString:String) {
        self.apartmentKey=apartmentKey
        self.name=name
      //  self.phoneNumber=phoneNumber
        self.password=password
        self.userColorString=userColorString
    }
    
    
    //    MARK: Transformation to and from dictionary
    init(fromDictionary:[String:Any]){
        
        self.name=fromDictionary["name"] as? String ?? ""
        self.tenantKey=fromDictionary["tenantKey"] as? String ?? nil
        self.apartmentKey=fromDictionary["apartmentKey"] as? String ?? ""
       // self.phoneNumber=fromDictionary["phoneNumber"] as! String
        self.password=fromDictionary["password"] as? String ?? ""
        self.userColorString=fromDictionary["userColor"] as? String ?? ""
        
    }
    
    func toDictionary()->[String:Any]{
        var dict: Dictionary<String,Any>=[:]
        dict["name"]=name
        dict["tenantKey"]=tenantKey
        dict["apartmentKey"]=apartmentKey
    //    dict["phoneNumber"]=phoneNumber
        dict["password"]=password
        dict["userColor"]=userColorString
        
        return dict
    }
    
    
}
