//
//  Event.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 14/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit

class MyEvent: CustomStringConvertible {
    var apartmentKey:String?
    var eventKey:String?
    var eventName:String?
    var eventDescription:String
    
    var startDate:Date
    var endDate:Date
    var tenant:Tenant?   // decide whether the tenant subscribe himself right in the creation of the event or afterwards

    var description:String{
        return "eventName:\(eventName ?? "no name"), eventDescription:\(eventDescription) startDate:\(startDate), endDate:\(endDate)"
    }
    let formatter=DateFormatter()
    
    
    init(fromDictionary:[String:Any]){
        
        self.apartmentKey=fromDictionary["apartmentKey"] as? String
        self.eventKey=fromDictionary["eventKey"] as? String
        self.eventDescription=fromDictionary["eventDescription"] as! String
        self.eventName=fromDictionary["eventName"] as? String ?? ""
        self.startDate=formatter.date(from: fromDictionary["startDate"] as! String) ?? Date()
        self.endDate=formatter.date(from: fromDictionary["endDate"] as! String) ?? Date()
        self.tenant=fromDictionary["tenant"] as? Tenant
        
    }
    
    init(eventName:String ,eventDescription:String, startDate:Date, endDate:Date){
        self.eventName=eventName
        self.eventDescription=eventDescription
        self.startDate=startDate
        self.endDate=endDate
    }
    
    func toDictionary()->[String:Any]{
        var dict:Dictionary<String,Any>=[:]
        formatter.dateFormat="MM/dd/yyyy HH:mm"
        dict["apartmentKey"]=apartmentKey
        dict["eventKey"]=eventKey
        dict["eventName"]=eventName
        dict["eventDescription"]=eventDescription
        dict["startDate"]=formatter.string(from: startDate)
        dict["endDate"]=formatter.string(from: endDate)
        dict["tenant"]=tenant
        
        return dict
    }
}