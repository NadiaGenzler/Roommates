//
//  Task.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 14/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit

class Task:CustomStringConvertible {
    var description: String{
        return "taskDescription: \(taskDescription), done: \(done), tenantColor: \(tenantColor), taskKey \(taskKey), apartmentKey: \(apartmentKey)"
    }
    
    
   // var title:String
    var taskDescription:String
    var done:Bool = false
    var apartmentKey:String?
    var taskKey:String?
  //  var takenBy:Tenant?
    var tenantColor:String?
    
    
    init(fromDictionary:[String:Any]){
            
      //  self.title=fromDictionary["title"] as! String
        self.taskDescription=fromDictionary["taskDescription"] as! String
        self.done=Bool(fromDictionary["done"] as! String ) ?? false
       // self.takenBy=fromDictionary["takenBy"] as? Tenant ?? nil
        self.taskKey=fromDictionary["taskKey"] as? String ?? nil
        self.apartmentKey=fromDictionary["apartmentKey"] as? String ?? nil
        self.tenantColor=fromDictionary["tenantColor"] as? String ?? "#ffffff"
    }
    //the task alway false in the begining
    init(taskDescription:String){
        self.taskDescription=taskDescription
    }
    
    init(taskDescription:String,taskKey:String, done:Bool,tenantColor:String){
        self.taskDescription=taskDescription
        self.taskKey=taskKey
        self.tenantColor=tenantColor
        self.done=done
    }
    
    init(taskDescription:String,done:Bool,tenantColor:String){
        self.taskDescription=taskDescription
        self.done=done
        self.tenantColor=tenantColor
    }
    
    
    func toDictionary()->[String:Any]{
        var dict:Dictionary<String,Any>=[:]
    //    dict["title"]=title
        dict["taskDescription"]=taskDescription
        dict["done"]=String(done)
       // dict["takenBy"]=takenBy
        dict["taskKey"]=taskKey
        dict["apartmentKey"]=apartmentKey
        dict["tenantColor"]=tenantColor
        
        return dict
    }
    
}
