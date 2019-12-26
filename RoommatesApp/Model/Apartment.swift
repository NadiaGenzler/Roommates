//
//  Apartment.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 14/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit

class Apartment:CustomStringConvertible{
    var description: String {
        return "name: \(name), key: \(key), tenants: \(tenants), tasks: \(tasks) "
    }
    
    var name:String
    var key:String
    var tenants:[Tenant]
    var tasks:[Task]
    
    init(fromDictionary:[String:Any]) {
       
        self.name=fromDictionary["name"] as! String
        self.key=fromDictionary["id"] as! String
        
        let tenantsDict = fromDictionary["tenants"] as! [String:Any]
        self.tenants=[]
        self.tasks=[]
        
        for (tenantKey,value) in tenantsDict{
           //print("00000000000",key,"vvvvvvvvvvvvv",value is Tenant )
            let tenantValues = value as! [String:Any]
            
            for (key,value) in tenantValues{
                let t = Tenant(name: value as! String)
                t.tenantKey = tenantKey
                self.tenants.append(t)
            }
            //let t = value as!
//            t.tenantKey = key
//            self.tenants.append(t)
            //print("tatatatat",Tenant(fromDictionary: [key:value]))
            
        }
        //print("---------------",tenantsDict)
        
        let tasksDict = fromDictionary["tasks"] as! [String:Any]
        
        
 

    }
    
    init(name:String, key: String, tenants: [Tenant], tasks: [Task]){
        self.name=name
        self.key=key
        self.tenants=tenants
        self.tasks=tasks
    }
    
    func toDictionary() -> [String:Any] {
        var dict:Dictionary<String,Any>=[:]
        
        dict["name"]=name
        dict["key"]=key
        dict["tenants"]=tenantDict()
        dict["tasks"]=taskDict()
        return dict
    }
    
    private func tenantDict()->[Dictionary<String,Any>]{
        var arr:[Dictionary<String,Any>]=[]
        
        for tenant in tenants{
            arr.append(tenant.toDictionary())
        }
        
        return arr
    }
    
    private func taskDict()->[Dictionary<String,Any>]{
        var arr:[Dictionary<String,Any>]=[]
        
        for task in tasks{
            arr.append(task.toDictionary())
        }
        
        return arr
    }
    
}
