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
    

    init(name:String) {
        self.name=name
    }
    
    let name:String
    var tenantKey:String?
    var apartmentKey:String?
//    var photo:UIImage
//    var userColor:UIColor
//    var phoneNumber:String
//    var password:String
//    var tasks:[Task]
//    var events:[Event]
    
    init(fromDictionary:[String:Any]){
        self.name=fromDictionary["name"] as! String
        self.tenantKey=fromDictionary["tenantKey"] as? String ?? nil
        self.apartmentKey=fromDictionary["apartmentKey"] as? String ?? nil
    }
    
    func toDictionary()->[String:Any]{
        var dict: Dictionary<String,Any>=[:]
        dict["name"]=name
        dict["tenantKey"]=tenantKey
        dict["apartmentKey"]=apartmentKey
        return dict
    }
}
