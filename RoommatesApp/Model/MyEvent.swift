//
//  Event.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 14/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit

class MyEvent: CustomStringConvertible {
    var description:String{
        return "eventDescription:\(eventDescription) startDate:\(startDate), endDate:\(endDate), tenantColore : \(tenantColor)"
    }
    
    var apartmentKey:String?
    var eventKey:String?
  //  var eventName:String?
    var eventDescription:String
    var startDate:Date
    var endDate:Date
//    var tenantKey:String
     var tenantColor:String

    
    let formatter=DateFormatter()
    
    init(eventDescription:String, startDate:Date, endDate:Date, tenantColor : String){
        self.eventDescription=eventDescription
        self.startDate=startDate
        self.endDate=endDate
        self.tenantColor=tenantColor
        
    }
    init(eventDescription:String, startDate:Date, endDate:Date, tenantColor : String,eventKey:String){
        self.eventDescription=eventDescription
        self.startDate=startDate
        self.endDate=endDate
        self.tenantColor=tenantColor
        self.eventKey=eventKey
    }
    
//    MARK: Transformation to and from dictionary
    
    init(fromDictionary:[String:Any]){
        
        self.apartmentKey=fromDictionary["apartmentKey"] as? String
        self.eventKey=fromDictionary["eventKey"] as? String ?? ""
        self.eventDescription=fromDictionary["eventDescription"] as! String
       // self.eventName=fromDictionary["eventName"] as? String ?? ""
        self.startDate=formatter.date(from: fromDictionary["startDate"] as! String) ?? Date()
        self.endDate=formatter.date(from: fromDictionary["endDate"] as! String) ?? Date()
        self.tenantColor=fromDictionary["tenantColor"] as! String
    }
    
    
    
    func toDictionary()->[String:Any]{
        var dict:Dictionary<String,Any>=[:]
        formatter.dateFormat="MM/dd/yyyy HH:mm"
        dict["apartmentKey"]=apartmentKey
        dict["eventKey"]=eventKey
       // dict["eventName"]=eventName
        dict["eventDescription"]=eventDescription
        dict["startDate"]=formatter.string(from: startDate)
        dict["endDate"]=formatter.string(from: endDate)
        dict["tenantColor"]=tenantColor
        
        return dict
    }
}
