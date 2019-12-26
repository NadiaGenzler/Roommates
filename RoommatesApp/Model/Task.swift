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
        return "title: \(title), body: \(body), done: \(done), body: \(body), takenBy: \(takenBy), key \(key), apartmentKey: \(apartmentKey)"
    }
    
    
    var title:String
    var body:String
    var done:Bool
    var takenBy:Tenant?
    var key:String?
    var apartmentKey:String?

    init(fromDictionary:[String:Any]){
        self.title=fromDictionary["title"] as! String
        self.body=fromDictionary["body"] as! String
        self.done=fromDictionary["done"] as! Bool
        self.takenBy=fromDictionary["takenBy"] as? Tenant ?? nil
        self.key=fromDictionary["key"] as? String ?? nil
        self.apartmentKey=fromDictionary["apartmentKey"] as? String ?? nil
    }
    
    init(title:String,body:String,done:Bool){
        self.title=title
        self.body=body
        self.done=done
    }
    
    func toDictionary()->[String:Any]{
        var dict:Dictionary<String,Any>=[:]
        dict["title"]=title
        dict["body"]=body
        dict["done"]=done
        dict["takenBy"]=takenBy
        dict["key"]=key
        dict["apartmentKey"]=apartmentKey
        
        return dict
    }
    
}
