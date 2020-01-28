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
        return "name: \(name), apartmentKey: \(apartmentKey), tenants: \(tenants),tasks: \(tasks), events: \(events) "
    }
    
    var name:String
    var apartmentKey:String?
    var tenants:[Tenant]
    var tasks:[Task]
    var events:[MyEvent]
    
    init(fromDictionary:[String:Any]) {
        
        self.name=fromDictionary["name"] as! String
        self.apartmentKey=fromDictionary["apartmentKey"] as! String
        self.tenants=[]
        self.tasks=[]
        self.events=[]
        
        
        let tenantsDict = fromDictionary["tenants"] as? [String:Any] ?? [:]
        for (tenantKey,tenantValue) in tenantsDict{
            let tenantValues = tenantValue as! [String:Any]
            let tenant = Tenant(apartmentKey:tenantValues["apartmentKey"] as? String ?? "no apartment key" ,name: tenantValues["name"] as! String,
            password: tenantValues["password"] as! String, userColorString: tenantValues["userColor"] as! String)
            tenant.tenantKey = tenantKey
            self.tenants.append(tenant)
        }
        
        
        let tasksDict = fromDictionary["tasks"] as? [String:Any] ?? [:]
        for (taskKey,taskValue) in tasksDict{
            let tasksValues=taskValue as! [String:Any]
            var Boolvalue = false
            if tasksValues["done"] as! String=="true"{
                Boolvalue = true
            }
            let task=Task(taskDescription: tasksValues["taskDescription"] as! String, done: Boolvalue,tenantColor: tasksValues["tenantColor"] as? String ?? "#ffffff")
                           
            task.taskKey=taskKey
            self.tasks.append(task)
        }
        
        
        let eventDict=fromDictionary["events"] as? [String:Any] ?? [:]
      let formatter=DateFormatter()
      formatter.dateFormat="MM/dd/yyyy HH:mm"
        for (eventKey, eventValue) in eventDict{
            let eventValues = eventValue as! [String:Any]
             
            let event=MyEvent(eventDescription: eventValues["eventDescription"] as! String, startDate: formatter.date(from: eventValues["startDate"] as! String) ?? Date(), endDate: formatter.date(from:eventValues["endDate"] as! String ) ?? Date(), tenantColor: eventValues["tenantColor"] as! String )
            event.eventKey=eventKey
            self.events.append(event)
            
        }
    }
    
    
    init(name:String, tenants: [Tenant], tasks: [Task], events:[MyEvent]){
        self.name=name
        self.tenants=tenants
        self.tasks=tasks
        self.events=events
    }
    
    
    func toDictionary() -> [String:Any] {
        var dict:Dictionary<String,Any>=[:]
        
        dict["name"]=name
        dict["apartmentKey"]=apartmentKey
        dict["tenants"]=tenantDict()
        dict["tasks"]=taskDict()
        dict["events"]=eventsDict()
        
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
    
    private func eventsDict()->[Dictionary<String,Any>]{
        var arr:[Dictionary<String,Any>]=[]
        for event in events{
            arr.append(event.toDictionary())
        }
        
        return arr
    }
}
