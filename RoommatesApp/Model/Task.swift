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
        return "body: \(body), done: \(done), takenBy: \(takenBy), taskKey \(taskKey), apartmentKey: \(apartmentKey)"
    }
    
    
   // var title:String
    var body:String
    var done:Bool = false
    var apartmentKey:String?
    var taskKey:String?
    var takenBy:Tenant?
    
    init(fromDictionary:[String:Any]){
            
      //  self.title=fromDictionary["title"] as! String
        self.body=fromDictionary["body"] as! String
        self.done=Bool(fromDictionary["done"] as! String ) ?? false
        self.takenBy=fromDictionary["takenBy"] as? Tenant ?? nil
        self.taskKey=fromDictionary["taskKey"] as? String ?? nil
        self.apartmentKey=fromDictionary["apartmentKey"] as? String ?? nil
    }
    //the task alway false in the begining
    init(body:String){
        self.body=body
    }
    
    init(body:String,taskKey:String){
        self.body=body
        self.taskKey=taskKey
    }
    
    init(body:String,done:Bool){
        self.body=body
        self.done=done
    }
    
    
    func toDictionary()->[String:Any]{
        var dict:Dictionary<String,Any>=[:]
    //    dict["title"]=title
        dict["body"]=body
        dict["done"]=String(done)
        dict["takenBy"]=takenBy
        dict["taskKey"]=taskKey
        dict["apartmentKey"]=apartmentKey
        
        return dict
    }
    
}
