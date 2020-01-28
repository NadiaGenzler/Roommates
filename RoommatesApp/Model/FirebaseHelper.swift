//
//  FirebaseHelper.swift
//  RoommatesApp
//
//  Created by Nadia Genzler on 26/12/2019.
//  Copyright © 2019 NadiaGenzler. All rights reserved.
//

import UIKit
import Firebase

class FirebaseHelper {
    var ref: DatabaseReference!
    let storageRef:StorageReference!
    
    static let shared=FirebaseHelper()
    
    private init(){
        ref = Database.database().reference()
        storageRef=Storage.storage().reference()
    }
    
    
    //MARK: Write to FireBase
    
    // add new
    func addApartment(apartment: inout Apartment, completion: (String,String)->Void){
        guard let apartmentKey=self.ref.childByAutoId().key else {return}
        apartment.apartmentKey=apartmentKey
        
        let childUpdates=["/Apartment/\(apartmentKey)":apartment.toDictionary()]
        ref.updateChildValues(childUpdates)
        completion(apartmentKey, apartment.name)
    }
    
    func addTenant(apartmentKey:String, tenant: inout Tenant, completion : (Tenant)->Void){
        guard let tenantKey=self.ref.child(apartmentKey).child("tenants").childByAutoId().key else {return}
        tenant.tenantKey=tenantKey
        
        let childUpdates=["/Apartment/\(apartmentKey)/tenants/\(tenantKey)":tenant.toDictionary()]
        ref.updateChildValues(childUpdates)
        completion(tenant)
    }
    
    
    func addTask(apartmentKey:String, task: inout Task){
        guard let taskKey=self.ref.child(apartmentKey).child("tasks").childByAutoId().key else {return}
        task.taskKey=taskKey
        
        let childUpdates=["/Apartment/\(apartmentKey)/tasks/\(taskKey)":task.toDictionary()]
        ref.updateChildValues(childUpdates)
        
    }
    func updateTask(apartmentKey:String, taskKey:String, task: inout Task){
       // ref.child(apartmentKey).child("tasks").child(taskKey)
        
        let childUpdates=["/Apartment/\(apartmentKey)/tasks/\(taskKey)":task.toDictionary()]
        ref.updateChildValues(childUpdates)
        
    }
    
    func addEvent(apartmentKey:String, event: inout MyEvent){
        guard let eventKey=self.ref.child(apartmentKey).child("events").childByAutoId().key else {return}
        event.eventKey=eventKey
        
        let childUpdates=["/Apartment/\(apartmentKey)/events/\(eventKey)":event.toDictionary()]
        ref.updateChildValues(childUpdates)
    }
    
    func updateEvent(apartmentKey:String, eventKey:String, event: inout MyEvent){
        
        let childUpdates=["/Apartment/\(apartmentKey)/events/\(eventKey)":event.toDictionary()]
        ref.updateChildValues(childUpdates)
        
    }
    
    
    
    
    
    //    func uploadImage(url:URL){
    //        let imagesRef = storageRef.child("images")
    //        print(imagesRef)
    //        let uploadTask=imagesRef.putFile(from: url)
    //    }
    
    //MARK: Read from FireBase
    
    func fetchAllApartmentsData(completion: @escaping ([Apartment])->Void){
        ref.child("Apartment").observe(.value) { (snapshot) in
            let apartmentDict=snapshot.value as? [String:Any] ?? [:]
            var apartments:[Apartment]=[]
            for (_,apartmentValue) in apartmentDict{
                let apartmentValues=apartmentValue as! [String:Any]
                let apartment = Apartment(fromDictionary: apartmentValues)
                apartments.append(apartment)
            }
            completion(apartments)
        }
    }
    
    func fetchApartmentData(apartmentKey:String, completion: @escaping (Apartment)->Void){
        ref.child("Apartment").child(apartmentKey).observe(.value) { (snapshot) in
            let apartmentDict=snapshot.value as? [String:Any] ?? [:]
            //          print(apartmentDict)
            
            let apartment = Apartment(fromDictionary: apartmentDict)
            completion(apartment)
            
        }
    }
    
    func fetchTenantData(apartmentKey:String, completion: @escaping ([Tenant])->Void){
        ref.child("Apartment").child(apartmentKey).child("tenants").observe(.value) { (snapshot) in
            let tenantDict=snapshot.value as? [String:Any] ?? [:]
            var tenants:[Tenant]=[]
            for (_,tenantValue ) in tenantDict{
                let tenantValues=tenantValue as![String:Any]
                let tenant=Tenant(fromDictionary: tenantValues)
                
                tenants.append(tenant)
            }
            
            completion(tenants)
            
        }
    }
    
    func fetchEventData(apartmentKey:String, completion: @escaping ([MyEvent])->Void){
        ref.child("Apartment").child(apartmentKey).child("events").observe(.value) { (snapshot) in
            let eventDict=snapshot.value as? [String:Any] ?? [:]
          
            let formatter=DateFormatter()
                       formatter.dateFormat="MM/dd/yyyy HH:mm"
            
            var events:[MyEvent]=[]
            for (_,eventValue) in eventDict{
                let eventValues=eventValue as! [String:Any]
                let event=MyEvent(eventDescription: eventValues["eventDescription"] as! String, startDate: formatter.date(from: eventValues["startDate"] as! String) ?? Date(), endDate: formatter.date(from:eventValues["endDate"] as! String ) ?? Date(), tenantColor: eventValues["tenantColor"] as! String ,eventKey: eventValues["eventKey"] as? String ?? "nokey")

                events.append(event)
            }
            
            completion(events)
            
        }
    }
    
        
    func fetchTaskData(apartmentKey:String, completion: @escaping ([Task])->Void){
        
        self.ref.child("Apartment").child(apartmentKey).child("tasks").observe(.value) { (snapshot) in
            var tasks:[Task]=[]
            
            let taskDict=snapshot.value as? [String:Any] ?? [:]
            for (_,taskValue) in taskDict{
                
                let tasksValues=taskValue as! [String:Any]
                
                var Boolvalue = false
                if tasksValues["done"] as! String=="true"{
                    Boolvalue = true
                }
                let task=Task(taskDescription: tasksValues["taskDescription"] as! String,taskKey:tasksValues["taskKey"] as! String, done: Boolvalue,tenantColor: tasksValues["tenantColor"] as? String ?? "#ffffff")
                
                tasks.append(task)
            }
                completion(tasks)
        
        }
    }
    
    
    
    //MARK: Remove from FireBase
    func removeApartment(apartmentKey:String){
        let refForRemove=Database.database().reference(withPath: "/Apartment/\(apartmentKey)")
        refForRemove.removeValue()
        
    }
    
    func removeTenant(apartmentKey:String ,tenantKey:String){
        let refForRemove=Database.database().reference(withPath: "/Apartment/\(apartmentKey)/tenants/\(tenantKey)")
        refForRemove.removeValue()
        
    }
    
    func removeTask(apartmentKey:String ,taskKey:String){
        let refForRemove=Database.database().reference(withPath: "/Apartment/\(apartmentKey)/tasks/\(taskKey)")
        refForRemove.removeValue()
        
    }
    
    func removeEvent(apartmentKey:String ,eventKey:String){
        let refForRemove=Database.database().reference(withPath: "/Apartment/\(apartmentKey)/events/\(eventKey)")
        refForRemove.removeValue()
        
    }
    
}
