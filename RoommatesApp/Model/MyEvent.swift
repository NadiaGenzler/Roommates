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
    var eventDescription:String
    var startDate:Date
    var endDate:Date
    var tenantInvolved:Tenant?// decide whether the tenant subscribe himself right in the creation of the event or afterwards
    var description:String{
        return "eventDescription:\(eventDescription) startDate:\(startDate), endDate:\(endDate)"
    }
    let formatter=DateFormatter()
    
    
    init(fromDicionary:[String:Any]){
        self.apartmentKey=fromDicionary["apartmentKey"] as? String
        self.eventKey=fromDicionary["eventKey"] as? String
        self.eventDescription=fromDicionary["eventDescription"] as! String
        self.startDate=formatter.date(from: fromDicionary["startDate"] as! String) ?? Date()
        self.endDate=formatter.date(from: fromDicionary["endDate"] as! String) ?? Date()
        self.tenantInvolved=fromDicionary["tenantInvolved"] as? Tenant
        
    }
    
    init(eventDescription:String, startDate:Date, endDate:Date){
        self.eventDescription=eventDescription
        self.startDate=startDate
        self.endDate=endDate
    }
    
    func toDictionary()->[String:Any]{
        var dict:Dictionary<String,Any>=[:]
        formatter.dateFormat="MM/dd/yyyy HH:mm"
        dict["apartmentKey"]=apartmentKey
        dict["eventKey"]=eventKey
        dict["eventDescription"]=eventDescription
        dict["startDate"]=formatter.string(from: startDate)
        dict["endDate"]=formatter.string(from: endDate)
        dict["tenantInvolved"]=tenantInvolved
        
        print(startDate)
        return dict
    }
}
