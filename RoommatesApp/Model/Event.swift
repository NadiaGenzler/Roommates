//
//  Event.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 14/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit

class Event {
    var apartmentKey:String?
    var eventKey:String?
    var title:String
    var description:String
    var startDate:Date
    var endDate:Date?
    var tenantInvolved:Tenant?// decide wether the tenant subscribe himself right in the creation of the event or afterwards
    
    init(fromDicionary:[String:Any]){
        self.apartmentKey=fromDicionary["apartmentKey"] as? String
        self.eventKey=fromDicionary["eventKey"] as? String
        self.title=fromDicionary["title"] as! String
        self.description=fromDicionary["description"] as! String
        self.startDate=fromDicionary["startDate"] as! Date
        self.endDate=fromDicionary["endDate"] as? Date
        self.tenantInvolved=fromDicionary["tenantInvolved"] as? Tenant
        
    }
    
    init(title:String, description:String, startDate:Date, endDate:Date){
        self.title=title
        self.description=description
        self.startDate=startDate
        self.endDate=endDate
    }
    
    func toDictionary()->[String:Any]{
        var dict:Dictionary<String,Any>=[:]
        dict["apartmentKey"]=apartmentKey
        dict["eventKey"]=eventKey
        dict["title"]=title
        dict["description"]=description
        dict["startDate"]=startDate
        dict["endDate"]=endDate
        dict["tenantInvolved"]=tenantInvolved
        
        return dict
    }
}
